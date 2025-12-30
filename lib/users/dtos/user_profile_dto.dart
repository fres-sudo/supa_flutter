import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pine/pine.dart';

part 'user_profile_dto.freezed.dart';
part 'user_profile_dto.g.dart';

@freezed
abstract class UserProfileDto extends DTO with _$UserProfileDto {
  const factory UserProfileDto({
    required String id,
    required String role,
    @JsonKey(name: 'first_name') String? firstName,
    @JsonKey(name: 'last_name') String? lastName,
    String? bio,
    @JsonKey(name: 'avatar_url') String? avatarUrl,
    @JsonKey(name: 'fcm_token') String? fcmToken,
    required String language,
    required String timezone,
    @JsonKey(name: 'liked_sports') List<String>? likedSports,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'updated_at') DateTime? updatedAt,
    @JsonKey(name: 'deleted_at') DateTime? deletedAt,
  }) = _UserProfileDto;

  const UserProfileDto._() : super();

  factory UserProfileDto.fromJson(Map<String, dynamic> json) =>
      _$UserProfileDtoFromJson(json);
}
