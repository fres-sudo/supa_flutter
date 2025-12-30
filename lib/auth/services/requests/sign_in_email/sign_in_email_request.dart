import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pine/pine.dart';

part 'sign_in_email_request.freezed.dart';
part 'sign_in_email_request.g.dart';

@freezed
abstract class SignInEmailRequest extends DTO with _$SignInEmailRequest {
  const factory SignInEmailRequest({
    required String email,
  }) = _SignInEmailRequest;

  const SignInEmailRequest._() : super();

  factory SignInEmailRequest.fromJson(Map<String, dynamic> json) =>
      _$SignInEmailRequestFromJson(json);
}
