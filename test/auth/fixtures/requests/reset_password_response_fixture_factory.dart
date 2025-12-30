import 'package:data_fixture_dart/data_fixture_dart.dart';
import 'package:supa_flutter/auth/services/requests/reset_password/reset_password_request.dart';

extension ResetPasswordRequestFixture on ResetPasswordRequest {
  static ResetPasswordRequestFixtureFactory factory() => ResetPasswordRequestFixtureFactory();
}

class ResetPasswordRequestFixtureFactory extends JsonFixtureFactory<ResetPasswordRequest> {
  @override
  FixtureDefinition<ResetPasswordRequest> definition() => define(
        (faker) => const ResetPasswordRequest(),
  );

  @override
  JsonFixtureDefinition<ResetPasswordRequest> jsonDefinition() => defineJson(
      (object) => {},
  );
}
