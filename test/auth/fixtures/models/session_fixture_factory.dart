import 'package:data_fixture_dart/data_fixture_dart.dart';
import 'package:supa_flutter/auth/models/session/session.dart';

extension SessionFixture on Session {
  static SessionFixtureFactory factory() => SessionFixtureFactory();
}

class SessionFixtureFactory extends FixtureFactory<Session> {
  @override
  FixtureDefinition<Session> definition() => define(
    (faker, [int _ = 0]) => Session(
      // TODO put real properties here
      world: faker.randomGenerator.string(10),
    ),
  );
}
