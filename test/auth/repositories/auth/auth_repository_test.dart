import 'package:flutter_test/flutter_test.dart';
import 'package:supa_flutter/auth/repositories/auth_repository.dart';

void main() {
  late AuthRepository repository;

  setUp(() {
    repository = const AuthRepositoryImpl();
  });

  group('when the method signIn is called', () {});

  group('when the method signInSocial is called', () {});

  group('when the method signUp is called', () {});

  group('when the method resetPassword is called', () {});

  group('when the method sendVerificationEmail is called', () {});

  group('when the method forgetPassword is called', () {});
}
