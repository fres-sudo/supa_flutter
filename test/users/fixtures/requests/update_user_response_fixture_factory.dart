import 'package:data_fixture_dart/data_fixture_dart.dart';
import 'package:supa_flutter/users/services/requests/update_user/update_user_request.dart';

extension UpdateUserRequestFixture on UpdateUserRequest {
  static UpdateUserRequestFixtureFactory factory() => UpdateUserRequestFixtureFactory();
}

class UpdateUserRequestFixtureFactory extends JsonFixtureFactory<UpdateUserRequest> {
  @override
  FixtureDefinition<UpdateUserRequest> definition() => define(
        (faker) => const UpdateUserRequest(),
  );

  @override
  JsonFixtureDefinition<UpdateUserRequest> jsonDefinition() => defineJson(
      (object) => {},
  );
}
