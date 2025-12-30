import 'package:pine/pine.dart';
import 'package:supa_flutter/core/misc/extensions.dart';
import 'package:supa_flutter/users/domain/user_entity.dart';
import 'package:supa_flutter/users/dtos/user_profile_dto.dart';
import 'package:supa_flutter/core/enums/user_roles.dart';

class UserEntityMapper extends Mapper<UserProfileDto, UserEntity> {
  @override
  UserEntity from(UserProfileDto from) => UserEntity(
    id: from.id,
    role:
        UserRole.values.firstWhereOrNull((r) => r.name == from.role) ??
        UserRole.member,
    firstName: from.firstName,
    lastName: from.lastName,
    bio: from.bio,
    avatarUrl: from.avatarUrl,
    fcmToken: from.fcmToken,
    language: from.language,
    timezone: from.timezone,
    createdAt: from.createdAt ?? DateTime.now(),
    updatedAt: from.updatedAt ?? DateTime.now(),
    deletedAt: from.deletedAt,
  );

  @override
  UserProfileDto to(UserEntity to) => throw UnimplementedError();
}
