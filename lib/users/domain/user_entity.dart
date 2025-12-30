import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:supa_flutter/users/domain/certification_status.dart';
import 'package:supa_flutter/core/enums/user_roles.dart';

part 'user_entity.freezed.dart';

@freezed
abstract class UserEntity with _$UserEntity {
  const factory UserEntity({
    required String id,
    required UserRole role,
    String? firstName,
    String? lastName,
    String? bio,
    String? avatarUrl,
    String? fcmToken,
    required String language,
    required String timezone,
    required DateTime createdAt,
    required DateTime updatedAt,
    DateTime? deletedAt,
  }) = _UserEntity;

  const UserEntity._();
}
