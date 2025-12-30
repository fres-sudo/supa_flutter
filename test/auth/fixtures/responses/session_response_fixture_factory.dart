import 'package:data_fixture_dart/data_fixture_dart.dart';
import 'package:supa_flutter/auth/services/responses/session/session_response.dart';

extension SessionResponseFixture on SessionResponse {
  static SessionResponseFixtureFactory factory() => SessionResponseFixtureFactory();
}

class SessionResponseFixtureFactory extends JsonFixtureFactory<SessionResponse> {
  @override
  FixtureDefinition<SessionResponse> definition() => define(
        (faker) => const SessionResponse(),
  );

  @override
  JsonFixtureDefinition<SessionResponse> jsonDefinition() => defineJson(
      (object) => {},
  );
}
