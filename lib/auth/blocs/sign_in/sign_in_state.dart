part of 'sign_in_bloc.dart';

@freezed
sealed class SignInState with _$SignInState {
  const factory SignInState.initial() = InitialSignInState;

  const factory SignInState.loadingEmail() = LoadingEmailSignInState;

  const factory SignInState.loadingGoogle() = LoadingGoogleSignInState;
  const factory SignInState.loadingApple() = LoadingAppleSignInState;

  const factory SignInState.successEmail() = SuccessEmailSignInState;
  const factory SignInState.successSocial() = SuccessSocialSignInState;

  const factory SignInState.error(String message) = ErrorSignInState;
}
