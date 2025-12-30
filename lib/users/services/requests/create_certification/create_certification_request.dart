import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pine/pine.dart';

part 'create_certification_request.freezed.dart';
part 'create_certification_request.g.dart';

@freezed
abstract class CreateCertificationRequest extends DTO
    with _$CreateCertificationRequest {
  const factory CreateCertificationRequest({
    @JsonKey(name: 'user_id') required String userId,
    @JsonKey(name: 'document_url') required String documentUrl,
  }) = _CreateCertificationRequest;

  const CreateCertificationRequest._() : super();

  factory CreateCertificationRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateCertificationRequestFromJson(json);
}
