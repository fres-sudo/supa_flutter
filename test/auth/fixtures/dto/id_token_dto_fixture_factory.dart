import 'package:data_fixture_dart/data_fixture_dart.dart';
import 'package:supa_flutter/auth/dto/id_token/id_token_dto.dart';

extension IdTokenDTOFixture on IdTokenDTO {
  static IdTokenDTOFixtureFactory factory() => IdTokenDTOFixtureFactory();
}

class IdTokenDTOFixtureFactory extends JsonFixtureFactory<IdTokenDTO> {
  @override
  FixtureDefinition<IdTokenDTO> definition() => define(
    (faker, [int _ = 0]) => IdTokenDTO(
      // TODO put real properties here
      world: faker.randomGenerator.string(10),
    ),
  );

  @override
  JsonFixtureDefinition<IdTokenDTO> jsonDefinition() => defineJson(
    (object, [int _ = 0]) => {
      // TODO put real properties here
      'world': object.world,
    },
  );
}
