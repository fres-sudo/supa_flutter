import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:supa_flutter/auth/blocs/sign_up/sign_up_bloc.dart';

void main() {
  late SignUpBloc bloc;

  setUp(() {
    bloc = SignUpBloc();
  });


  group('when the event EmailSignUpEvent is added to the BLoC', () {
    blocTest<SignUpBloc, SignUpState>(
      '[SignUpBloc] emits SignUpState.loading',
      setUp: () {
        //TODO: setup the environment
      },
      build: () => bloc,
      act: (bloc) {
        bloc.email();
      },
      expect: () => <SignUpState>[
        //TODO: define the emitted SignUpState states
      ],
      verify: (_) {
        //TODO: verify that methods are invoked properly
      },
    );
  });

}
