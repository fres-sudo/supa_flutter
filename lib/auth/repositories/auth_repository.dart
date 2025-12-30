import 'dart:io' show Platform;

import 'package:google_sign_in/google_sign_in.dart';
import 'package:pine/utils/mapper.dart';
import 'package:supa_flutter/core/exceptions/repository_exception.dart';
import 'package:supa_flutter/core/misc/constants.dart';
import 'package:supa_flutter/core/misc/repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supabase;
import 'package:talker/talker.dart';
import 'package:supa_flutter/core/enums/social_provider.dart';
import 'package:supa_flutter/auth/services/auth_service.dart';
import 'package:supa_flutter/auth/services/requests/requests.dart';
import 'package:supa_flutter/core/misc/result.dart';
import 'package:supa_flutter/notification/services/notification_service.dart';
import 'package:supa_flutter/users/models/app_user/app_user.dart';
import 'package:supa_flutter/users/services/users_service.dart';

abstract interface class AuthRepository {
  Stream<AppUser?> get userStream;
  Future<Result<void>> signOut();
  Future<Result<void>> signInEmail(SignInEmailRequest request);
  Future<Result<void>> signInSocial(SocialProvider provider);
  Future<Result<void>> verifyOtp(VerifyOtpRequest request);
}

class AuthRepositoryImpl extends Repository implements AuthRepository {
  AuthRepositoryImpl({
    required this.authService,
    Talker? logger,
    required this.appUserMapper,
    required this.notificationService,
    required this.userService,
  }) : super(logger);

  final AuthService authService;
  final NotificationService notificationService;
  final Mapper<supabase.User, AppUser> appUserMapper;
  static Future<void>? _googleInit;
  final UsersService userService;

  @override
  Stream<AppUser?> get userStream =>
      authService.userStream.asyncMap((event) async {
        if (event?.session == null) return null;
        final user = appUserMapper.from(event!.session!.user);
        final result = await userService.getCurrentProfile();
        switch (result) {
          case Ok(:final value):
            return user.copyWith(
              name: '${value.firstName ?? ""} ${value.lastName ?? ""}',
              image: value.avatarUrl,
            );
          case Error():
            return null;
        }
      });
  // authService.userStream.asyncMap((event) =>
  //  switch (event) {
  //     supabase.AuthState(:final session) => session.user;
  //     _ => null,
  //});

  @override
  Future<Result<void>> signInEmail(SignInEmailRequest request) =>
      safe('signInEmail', () => authService.signInEmail(request));

  @override
  Future<Result<void>> signInSocial(SocialProvider provider) =>
      safe('signInSocial', () async {
        final result = switch (provider) {
          SocialProvider.google => await performGoogleSignIn(),
          _ => throw RepositoryException(
            'Unsupported social provider: $provider',
          ),
        };

        final request = SignInSocialRequest(
          provider: provider.oauthProvider,
          accessToken: result.unwrap().$2,
          idToken: result.unwrap().$1,
        );
        (await authService.signInSocial(request)).unwrap();
        await setFcmToken().unwrapAsync();
      });

  Future<Result<(String, String)>> performGoogleSignIn() =>
      safe('performGoogleSignIn', () async {
        final googleSignIn = GoogleSignIn.instance;
        _googleInit ??= googleSignIn.initialize(
          serverClientId: K.webClientId,
          clientId: Platform.isIOS ? K.iosClientId : null,
        );
        await _googleInit;
        late final GoogleSignInAccount googleUser;
        try {
          googleUser = await googleSignIn.authenticate(scopeHint: K.scopes);
        } on GoogleSignInException catch (e) {
          if (e.code == GoogleSignInExceptionCode.canceled) {
            throw RepositoryException('Google sign-in was cancelled.');
          }
          rethrow;
        }

        // Supabase validates that the access token matches the `at_hash` inside
        // the ID token. Requesting authorization interactively after the ID
        // token was issued can mint a *different* access token, causing:
        // "access token hash does not match value in ID token".
        //
        // So we first try to get a non-interactive token that should be paired
        // with the ID token from the authentication flow.
        final idToken = googleUser.authentication.idToken;
        GoogleSignInClientAuthorization? authorization = await googleUser
            .authorizationClient
            .authorizationForScopes(K.scopes);

        if (authorization == null) {
          // Fall back to prompting for authorization, then re-authenticate to
          // ensure the returned ID token matches the newly minted access token.
          await googleUser.authorizationClient.authorizeScopes(K.scopes);
          final refreshedUser = await googleSignIn.authenticate(
            scopeHint: K.scopes,
          );
          final refreshedIdToken = refreshedUser.authentication.idToken;
          authorization = await refreshedUser.authorizationClient
              .authorizationForScopes(K.scopes);

          if (authorization == null || refreshedIdToken == null) {
            throw RepositoryException('Failed to sign in with Google.');
          }
          return (refreshedIdToken, authorization.accessToken);
        }
        final accessToken = authorization.accessToken;

        if (idToken == null) {
          throw RepositoryException('Failed to sign in with Google.');
        }

        return (idToken, accessToken);
      });

  @override
  Future<Result<void>> signOut() =>
      safe('signOut', () => authService.signOut());

  @override
  Future<Result<void>> verifyOtp(VerifyOtpRequest request) =>
      safe('verifyOtp', () async {
        (await authService.verifyOtp(request)).unwrap();
        await setFcmToken().unwrapAsync();
      });

  Future<Result<void>> setFcmToken() =>
      safe('setFcmToken', () => notificationService.setFcmToken());
}
