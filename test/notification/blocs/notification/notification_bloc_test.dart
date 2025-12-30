import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:supa_flutter/notification/blocs/notification/notification_bloc.dart';

void main() {
  late NotificationBloc bloc;

  setUp(() {
    bloc = NotificationBloc();
  });


  group('when the event ActionNotificationEvent is added to the BLoC', () {
    blocTest<NotificationBloc, NotificationState>(
      '[NotificationBloc] emits NotificationState.initial',
      setUp: () {
        //TODO: setup the environment
      },
      build: () => bloc,
      act: (bloc) {
        bloc.action();
      },
      expect: () => <NotificationState>[
        //TODO: define the emitted NotificationState states
      ],
      verify: (_) {
        //TODO: verify that methods are invoked properly
      },
    );
  });

}
