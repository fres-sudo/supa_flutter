import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pine/pine.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'sign_in_social_request.freezed.dart';
part 'sign_in_social_request.g.dart';

@freezed
abstract class SignInSocialRequest extends DTO with _$SignInSocialRequest {
  const factory SignInSocialRequest({
    required OAuthProvider provider,
    required String accessToken,
    required String idToken,
  }) = _SignInSocialRequest;

  const SignInSocialRequest._() : super();

  factory SignInSocialRequest.fromJson(Map<String, dynamic> json) =>
      _$SignInSocialRequestFromJson(json);
}
