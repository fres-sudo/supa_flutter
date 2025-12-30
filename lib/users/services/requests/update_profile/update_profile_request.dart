import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pine/pine.dart';

part 'update_profile_request.freezed.dart';
part 'update_profile_request.g.dart';

@freezed
abstract class UpdateProfileRequest extends DTO with _$UpdateProfileRequest {
  const factory UpdateProfileRequest({
    @JsonKey(name: 'first_name') String? firstName,
    @JsonKey(name: 'last_name') String? lastName,
    String? bio,
    @JsonKey(name: 'avatar_url') String? avatarUrl,
    @JsonKey(name: 'liked_sports') List<String>? likedSports,
  }) = _UpdateProfileRequest;

  const UpdateProfileRequest._() : super();

  factory UpdateProfileRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateProfileRequestFromJson(json);
}
