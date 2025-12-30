import 'package:freezed_annotation/freezed_annotation.dart';

part 'session.freezed.dart';
part 'session.g.dart';

@freezed
abstract class Session with _$Session {
  const factory Session(
      {String? id,
      required String userId,
      String? ipAddress,
      String? userAgent,
      required DateTime createdAt,
      required DateTime updatedAt,
      required DateTime expiresAt,
      required String token}) = _Session;

  const Session._();
  factory Session.fromJson(Map<String, dynamic> json) =>
      _$SessionFromJson(json);
}
