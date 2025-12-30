import 'package:flutter_test/flutter_test.dart';
import 'package:supa_flutter/auth/dto/user/user_dto.dart';
import 'package:supa_flutter/auth/mappers/user_dto_mapper.dart';
import 'package:supa_flutter/auth/models/app_user/app_user.dart';

import '../fixtures/dto/user_dto_fixture_factory.dart';

void main() {
  late UserDTOMapper mapper;
  late UserDTO dto;
  late AppUser model;

  setUp(() {
    dto = UserDTOFixture.factory().makeSingle();

    model = AppUser();
    mapper = const UserDTOMapper();
  });

  test('mapping AppUser object from UserDTO', () {
    expect(mapper.fromDTO(dto), equals(model));
  });

  test('mapping AppUser to UserDTO', () {
    expect(mapper.toDTO(model), equals(dto));
  });
}
