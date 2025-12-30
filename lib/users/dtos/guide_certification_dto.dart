import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pine/pine.dart';

part 'guide_certification_dto.freezed.dart';
part 'guide_certification_dto.g.dart';

@freezed
abstract class GuideCertificationDto extends DTO with _$GuideCertificationDto {
  const factory GuideCertificationDto({
    required String id,
    @JsonKey(name: 'user_id') required String userId,
    @JsonKey(name: 'document_url') required String documentUrl,
    required String status,
    @JsonKey(name: 'rejection_reason') String? rejectionReason,
    @JsonKey(name: 'reviewed_by') String? reviewedBy,
    @JsonKey(name: 'reviewed_at') DateTime? reviewedAt,
    @JsonKey(name: 'created_at') DateTime? createdAt,
  }) = _GuideCertificationDto;

  const GuideCertificationDto._() : super();

  factory GuideCertificationDto.fromJson(Map<String, dynamic> json) =>
      _$GuideCertificationDtoFromJson(json);
}
