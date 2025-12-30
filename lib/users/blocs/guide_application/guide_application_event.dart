part of 'guide_application_bloc.dart';

@freezed
sealed class GuideApplicationEvent with _$GuideApplicationEvent {
  const factory GuideApplicationEvent.apply({
    required String uid,
    required File file,
  }) = ApplyGuideApplicationEvent;
}
