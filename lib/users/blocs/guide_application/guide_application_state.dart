part of 'guide_application_bloc.dart';

@freezed
sealed class GuideApplicationState with _$GuideApplicationState {
  const factory GuideApplicationState.initial() = InitialGuideApplicationState;
  const factory GuideApplicationState.loading() = LoadingGuideApplicationState;
  const factory GuideApplicationState.success({
    required GuideCertificationEntity certification,
  }) = SuccessGuideApplicationState;
  const factory GuideApplicationState.error(String message) =
      ErrorGuideApplicationState;
}
