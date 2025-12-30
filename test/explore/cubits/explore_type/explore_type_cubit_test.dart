import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:supa_flutter/explore/cubits/explore_type/explore_type_cubit.dart';

void main() {
  late ExploreTypeCubit cubit;

  setUp(() {
    cubit = ExploreTypeCubit();
  });


  group('when the method switch is called', () {
    blocTest<ExploreTypeCubit, ExploreTypeState>(
      'test that ExploreTypeCubit emits ExploreTypeState.list when switch is called',
      setUp: () {
        //TODO: setup the environment
      },
      build: () => cubit,
      act: (cubit) {
        cubit.switch();
      },
      expect: () => <ExploreTypeState>[
        //TODO: define the emitted ExploreTypeState states
      ],
      verify: (_) {
        //TODO: verify that methods are invoked properly
      },
    );
  });

}
