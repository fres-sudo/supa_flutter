import 'package:data_fixture_dart/data_fixture_dart.dart';
import 'package:supa_flutter/notification/models/notification/notification.dart';

extension NotificationFixture on Notification {
  static NotificationFixtureFactory factory() => NotificationFixtureFactory();
}

class NotificationFixtureFactory extends FixtureFactory<Notification> {
  @override
  FixtureDefinition<Notification> definition() => define(
    (faker, [int _ = 0]) => Notification(
      // TODO put real properties here
      world: faker.randomGenerator.string(10),
    ),
  );
}
