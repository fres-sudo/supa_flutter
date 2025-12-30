part of 'sign_in_bloc.dart';

@freezed
sealed class SignInEvent with _$SignInEvent {
  const factory SignInEvent.email({
    required String email,
  }) = EmailSignInEvent;

  const factory SignInEvent.social({
    required SocialProvider provider,
  }) = SocialSignInEvent;
}
