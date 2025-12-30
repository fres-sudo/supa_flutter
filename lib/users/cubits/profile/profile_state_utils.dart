part of 'profile_cubit.dart';

extension ProfileStateX on ProfileState {
  bool get isLoading => this is LoadingProfileState;
  bool get isLoaded => this is LoadedProfileState;
  bool get isError => this is ErrorProfileState;

  String? get errorMessage =>
      this is ErrorProfileState ? (this as ErrorProfileState).message : null;

  UserEntity? get user =>
      this is LoadedProfileState ? (this as LoadedProfileState).user : null;
}
