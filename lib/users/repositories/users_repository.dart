import 'dart:io';

import 'package:pine/pine.dart';
import 'package:supa_flutter/core/misc/repository.dart';
import 'package:talker/talker.dart';
import 'package:supa_flutter/core/misc/result.dart';
import 'package:supa_flutter/users/domain/domain.dart';
import 'package:supa_flutter/users/dtos/dtos.dart';
import 'package:supa_flutter/users/services/services.dart';
import 'package:supa_flutter/users/services/requests/requests.dart';

abstract interface class UsersRepository {
  Future<Result<UserEntity>> getProfile(String uid);
  Future<Result<UserEntity>> updateProfile(
    String uid,
    UpdateProfileRequest data,
  );
}

class UsersRepositoryImpl extends Repository implements UsersRepository {
  UsersRepositoryImpl({
    required this.usersService,
    required this.userEntityMapper,
    required this.guideCertificationEntityMapper,
    Talker? logger,
  }) : super(logger);

  final UsersService usersService;
  final Mapper<UserProfileDto, UserEntity> userEntityMapper;
  final Mapper<GuideCertificationDto, GuideCertificationEntity>
  guideCertificationEntityMapper;

  @override
  Future<Result<UserEntity>> getProfile(String uid) =>
      safe('getProfile', () async {
        final profileResult = await usersService.getProfile(uid);

        final profile = switch (profileResult) {
          Ok(:final value) => value,
          Error(:final error) => throw error,
        };

        final user = userEntityMapper.from(profile);
        return user;
      });

  @override
  Future<Result<UserEntity>> updateProfile(
    String uid,
    UpdateProfileRequest data,
  ) => safe('updateProfile', () async {
    final profileResult = await usersService
        .updateProfile(uid, data)
        .unwrapAsync();

    // Reuse getProfile logic to attach certification status.
    final user = userEntityMapper.from(profileResult);
  });
}
