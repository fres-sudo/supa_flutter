import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:supa_flutter/auth/blocs/sign_in/sign_in_bloc.dart';

void main() {
  late SignInBloc bloc;

  setUp(() {
    bloc = SignInBloc();
  });


  group('when the event EmailSignInEvent is added to the BLoC', () {
    blocTest<SignInBloc, SignInState>(
      '[SignInBloc] emits SignInState.loadingEmail',
      setUp: () {
        //TODO: setup the environment
      },
      build: () => bloc,
      act: (bloc) {
        bloc.email();
      },
      expect: () => <SignInState>[
        //TODO: define the emitted SignInState states
      ],
      verify: (_) {
        //TODO: verify that methods are invoked properly
      },
    );
  });

  group('when the event SocialSignInEvent is added to the BLoC', () {
    blocTest<SignInBloc, SignInState>(
      '[SignInBloc] emits SignInState.loadingEmail',
      setUp: () {
        //TODO: setup the environment
      },
      build: () => bloc,
      act: (bloc) {
        bloc.social();
      },
      expect: () => <SignInState>[
        //TODO: define the emitted SignInState states
      ],
      verify: (_) {
        //TODO: verify that methods are invoked properly
      },
    );
  });

}
