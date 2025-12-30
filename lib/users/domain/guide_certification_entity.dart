import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:supa_flutter/users/domain/certification_status.dart';

part 'guide_certification_entity.freezed.dart';

@freezed
abstract class GuideCertificationEntity with _$GuideCertificationEntity {
  const factory GuideCertificationEntity({
    required String id,
    required String userId,
    required String documentUrl,
    required CertificationStatus status,
    String? rejectionReason,
    String? reviewedBy,
    DateTime? reviewedAt,
    required DateTime createdAt,
  }) = _GuideCertificationEntity;

  const GuideCertificationEntity._();
}
