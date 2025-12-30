import 'package:data_fixture_dart/data_fixture_dart.dart';
import 'package:supa_flutter/auth/models/account/account.dart';

extension AccountFixture on Account {
  static AccountFixtureFactory factory() => AccountFixtureFactory();
}

class AccountFixtureFactory extends FixtureFactory<Account> {
  @override
  FixtureDefinition<Account> definition() => define(
    (faker, [int _ = 0]) => Account(
      // TODO put real properties here
      world: faker.randomGenerator.string(10),
    ),
  );
}
