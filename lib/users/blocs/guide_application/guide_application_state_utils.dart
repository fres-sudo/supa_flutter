part of 'guide_application_bloc.dart';

extension GuideApplicationStateX on GuideApplicationState {
  bool get isLoading => this is LoadingGuideApplicationState;
  bool get isSuccess => this is SuccessGuideApplicationState;
  bool get isError => this is ErrorGuideApplicationState;

  String? get errorMessage => this is ErrorGuideApplicationState
      ? (this as ErrorGuideApplicationState).message
      : null;
}
