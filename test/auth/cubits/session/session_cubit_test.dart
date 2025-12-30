import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:supa_flutter/auth/cubits/session/session_cubit.dart';

void main() {
  late SessionCubit cubit;

  setUp(() {
    cubit = SessionCubit();
  });


  group('when the method action is called', () {
    blocTest<SessionCubit, SessionState>(
      'test that SessionCubit emits SessionState.initial when action is called',
      setUp: () {
        //TODO: setup the environment
      },
      build: () => cubit,
      act: (cubit) {
        cubit.action();
      },
      expect: () => <SessionState>[
        //TODO: define the emitted SessionState states
      ],
      verify: (_) {
        //TODO: verify that methods are invoked properly
      },
    );
  });

}
