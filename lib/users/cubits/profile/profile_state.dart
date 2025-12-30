part of 'profile_cubit.dart';

@freezed
sealed class ProfileState with _$ProfileState {
  const factory ProfileState.initial() = InitialProfileState;
  const factory ProfileState.loading() = LoadingProfileState;
  const factory ProfileState.loaded({required UserEntity user}) =
      LoadedProfileState;
  const factory ProfileState.error(String message) = ErrorProfileState;
}
