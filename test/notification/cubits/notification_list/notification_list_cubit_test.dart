import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:supa_flutter/notification/cubits/notification_list/notification_list_cubit.dart';

void main() {
  late NotificationListCubit cubit;

  setUp(() {
    cubit = NotificationListCubit();
  });


  group('when the method fetchAll is called', () {
    blocTest<NotificationListCubit, NotificationListState>(
      'test that NotificationListCubit emits NotificationListState.loading when fetchAll is called',
      setUp: () {
        //TODO: setup the environment
      },
      build: () => cubit,
      act: (cubit) {
        cubit.fetchAll();
      },
      expect: () => <NotificationListState>[
        //TODO: define the emitted NotificationListState states
      ],
      verify: (_) {
        //TODO: verify that methods are invoked properly
      },
    );
  });

}
