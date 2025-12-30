import 'package:supabase_flutter/supabase_flutter.dart' as s;
import 'package:supa_flutter/auth/services/requests/requests.dart';
import 'package:supa_flutter/core/misc/result.dart';
import 'package:supa_flutter/core/services/supabase/supabase_service.dart';
import 'package:supa_flutter/core/enums/user_roles.dart';

abstract class AuthService {
  Stream<s.AuthState?> get userStream;
  Future<Result<void>> signInEmail(SignInEmailRequest request);
  Future<Result<void>> signInSocial(SignInSocialRequest request);
  Future<Result<void>> verifyOtp(VerifyOtpRequest request);
  Future<Result<void>> signOut();
}

class AuthServiceImpl extends SupabaseService implements AuthService {
  s.SupabaseQueryBuilder get _usersTable => client.from('users');

  @override
  Stream<s.AuthState?> get userStream => auth.onAuthStateChange;

  @override
  Future<Result<void>> signInEmail(SignInEmailRequest request) => safe(
    'signInEmail',
    () => auth.signInWithOtp(email: request.email, shouldCreateUser: true),
  );

  @override
  Future<Result<void>> signInSocial(SignInSocialRequest request) =>
      safe('signInSocial', () async {
        final result = await auth.signInWithIdToken(
          accessToken: request.accessToken,
          idToken: request.idToken,
          provider: request.provider,
        );
        logger?.debug('signInSocial success - userId: ${result.user?.id}');
        if (result.user != null) {
          logger?.debug("upserting user: ${result.user?.id}");
          final name = result.user?.userMetadata?['name'];
          final firstName = name?.split(' ').first;
          final lastName = name?.split(' ').last;
          await _usersTable.upsert({
            'id': result.user?.id,
            'role': UserRole.member.name,
            'first_name': firstName,
            'last_name': lastName,
            'avatar_url': result.user?.userMetadata?['avatar_url'],
          });
        }
      });

  @override
  Future<Result<void>> verifyOtp(VerifyOtpRequest request) =>
      safe('verifyOtp', () async {
        final response = await auth.verifyOTP(
          token: request.token,
          type: request.type,
          email: request.email,
        );
        if (response.user != null) {
          await _usersTable.upsert({
            'id': response.user?.id,
            'role': UserRole.member.name,
            'first_name': response.user?.userMetadata?['name'],
          });
        }
      });

  @override
  Future<Result<void>> signOut() => safe('signOut', () => auth.signOut());
}
