import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:supa_flutter/core/enums/social_provider.dart';
import 'package:supa_flutter/auth/repositories/auth_repository.dart';
import 'package:supa_flutter/auth/services/requests/requests.dart';
import 'package:supa_flutter/core/misc/extensions.dart';
import 'package:supa_flutter/core/misc/result.dart';

part 'sign_in_event.dart';
part 'sign_in_state.dart';

part 'sign_in_bloc.freezed.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  SignInBloc(this._authRepository) : super(const SignInState.initial()) {
    on<EmailSignInEvent>(_onEmail);
    on<SocialSignInEvent>(_onSocial);
  }

  final AuthRepository _authRepository;

  void email({required String email}) => add(SignInEvent.email(email: email));

  void social({required SocialProvider provider}) =>
      add(SignInEvent.social(provider: provider));

  FutureOr<void> _onEmail(
    EmailSignInEvent event,
    Emitter<SignInState> emit,
  ) async {
    emit(const SignInState.loadingEmail());
    (await _authRepository.signInEmail(
      SignInEmailRequest(email: event.email),
    )).when(
      success: (_) => emit(const SignInState.successEmail()),
      error: (error) =>
          emit(SignInState.error("Error signing in with email".hardcoded())),
    );
  }

  FutureOr<void> _onSocial(
    SocialSignInEvent event,
    Emitter<SignInState> emit,
  ) async {
    switch (event.provider) {
      case SocialProvider.google:
        emit(const SignInState.loadingGoogle());
        break;
      case SocialProvider.apple:
        emit(const SignInState.loadingApple());
        break;
    }
    (await _authRepository.signInSocial(event.provider)).when(
      success: (_) => emit(const SignInState.successSocial()),
      error: (error) => emit(
        SignInState.error("Error signing in with ${event.provider.label}"),
      ),
    );
  }
}

extension SignInBlocExtension on BuildContext {
  SignInBloc get signInBloc => read<SignInBloc>();

  SignInBloc get watchSignInBloc => watch<SignInBloc>();
}
