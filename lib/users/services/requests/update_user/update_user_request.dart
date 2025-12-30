import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pine/pine.dart';

part 'update_user_request.freezed.dart';
part 'update_user_request.g.dart';

@freezed
abstract class UpdateUserRequest extends DTO with _$UpdateUserRequest {
  const factory UpdateUserRequest({
    String? name,
    String? image,
  }) = _UpdateUserRequest;

  const UpdateUserRequest._() : super();

  factory UpdateUserRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateUserRequestFromJson(json);
}
