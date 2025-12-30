import 'package:data_fixture_dart/data_fixture_dart.dart';
import 'package:supa_flutter/core/models/remote_config/remote_config.dart';

extension RemoteConfigFixture on RemoteConfig {
  static RemoteConfigFixtureFactory factory() => RemoteConfigFixtureFactory();
}

class RemoteConfigFixtureFactory extends FixtureFactory<RemoteConfig> {
  @override
  FixtureDefinition<RemoteConfig> definition() => define(
    (faker, [int _ = 0]) => RemoteConfig(
      // TODO put real properties here
      world: faker.randomGenerator.string(10),
    ),
  );
}
