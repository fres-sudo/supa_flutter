import 'package:data_fixture_dart/data_fixture_dart.dart';
import 'package:supa_flutter/auth/services/requests/refresh_token/refresh_token_request.dart';

extension RefreshTokenRequestFixture on RefreshTokenRequest {
  static RefreshTokenRequestFixtureFactory factory() => RefreshTokenRequestFixtureFactory();
}

class RefreshTokenRequestFixtureFactory extends JsonFixtureFactory<RefreshTokenRequest> {
  @override
  FixtureDefinition<RefreshTokenRequest> definition() => define(
        (faker) => const RefreshTokenRequest(),
  );

  @override
  JsonFixtureDefinition<RefreshTokenRequest> jsonDefinition() => defineJson(
      (object) => {},
  );
}
