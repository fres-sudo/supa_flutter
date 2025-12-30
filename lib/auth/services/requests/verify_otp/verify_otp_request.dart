import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pine/pine.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'verify_otp_request.freezed.dart';
part 'verify_otp_request.g.dart';

@freezed
abstract class VerifyOtpRequest extends DTO with _$VerifyOtpRequest {
  const factory VerifyOtpRequest({
    required String token,
    required OtpType type,
    required String email,
  }) = _VerifyOtpRequest;

  const VerifyOtpRequest._() : super();

  factory VerifyOtpRequest.fromJson(Map<String, dynamic> json) =>
      _$VerifyOtpRequestFromJson(json);
}
