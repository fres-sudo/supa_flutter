import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:supa_flutter/core/cubits/config/config_cubit.dart';

void main() {
  late ConfigCubit cubit;

  setUp(() {
    cubit = ConfigCubit();
  });


  group('when the method fetch is called', () {
    blocTest<ConfigCubit, ConfigState>(
      'test that ConfigCubit emits ConfigState.loading when fetch is called',
      setUp: () {
        //TODO: setup the environment
      },
      build: () => cubit,
      act: (cubit) {
        cubit.fetch();
      },
      expect: () => <ConfigState>[
        //TODO: define the emitted ConfigState states
      ],
      verify: (_) {
        //TODO: verify that methods are invoked properly
      },
    );
  });

}
