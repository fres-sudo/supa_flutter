import 'package:data_fixture_dart/data_fixture_dart.dart';
import 'package:supa_flutter/users/services/requests/change_password/change_password_request.dart';

extension ChangePasswordRequestFixture on ChangePasswordRequest {
  static ChangePasswordRequestFixtureFactory factory() => ChangePasswordRequestFixtureFactory();
}

class ChangePasswordRequestFixtureFactory extends JsonFixtureFactory<ChangePasswordRequest> {
  @override
  FixtureDefinition<ChangePasswordRequest> definition() => define(
        (faker) => const ChangePasswordRequest(),
  );

  @override
  JsonFixtureDefinition<ChangePasswordRequest> jsonDefinition() => defineJson(
      (object) => {},
  );
}
