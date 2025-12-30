import 'package:freezed_annotation/freezed_annotation.dart';

part 'account.freezed.dart';

@freezed
abstract class Account with _$Account {
  const factory Account(
      {String? id,
      required String accountId,
      required String providerId,
      required DateTime updatedAt,
      required String userId,
      required DateTime createdAt,
      String? accessToken,
      String? refreshToken,
      DateTime? accessTokenExpiresAt,
      DateTime? refreshTokenExpiresAt,
      String? idToken,
      String? scope}) = _Account;

  const Account._();
}
