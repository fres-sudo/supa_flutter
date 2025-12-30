import 'package:pine/pine.dart';
import 'package:supa_flutter/core/misc/extensions.dart';
import 'package:supa_flutter/users/domain/certification_status.dart';
import 'package:supa_flutter/users/domain/guide_certification_entity.dart';
import 'package:supa_flutter/users/dtos/guide_certification_dto.dart';

class GuideCertificationEntityMapper
    extends Mapper<GuideCertificationDto, GuideCertificationEntity> {
  @override
  GuideCertificationEntity from(GuideCertificationDto from) =>
      GuideCertificationEntity(
        id: from.id,
        userId: from.userId,
        documentUrl: from.documentUrl,
        status: CertificationStatus.values.firstWhereOrNull(
              (s) => s.name == from.status,
            ) ??
            CertificationStatus.pending,
        rejectionReason: from.rejectionReason,
        reviewedBy: from.reviewedBy,
        reviewedAt: from.reviewedAt,
        createdAt: from.createdAt ?? DateTime.now(),
      );

  @override
  GuideCertificationDto to(GuideCertificationEntity to) =>
      throw UnimplementedError();
}
