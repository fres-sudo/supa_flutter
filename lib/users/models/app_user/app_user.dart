import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:supa_flutter/core/enums/user_roles.dart';

part 'app_user.freezed.dart';
part 'app_user.g.dart';

@freezed
abstract class AppUser with _$AppUser {
  const factory AppUser({
    required String id,
    required String email,
    required String name,
    required UserRole role,
    String? image,
    required DateTime createdAt,
  }) = _AppUser;

  const AppUser._();
  factory AppUser.fromJson(Map<String, dynamic> json) =>
      _$AppUserFromJson(json);
}
