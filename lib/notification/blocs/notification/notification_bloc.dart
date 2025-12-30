import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'notification_event.dart';
part 'notification_state.dart';

part 'notification_bloc.freezed.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  NotificationBloc() : super(const NotificationState.initial()) {
    on<ActionNotificationEvent>(_onAction);
  }

  void action() => add(const NotificationEvent.action());

  FutureOr<void> _onAction(
    ActionNotificationEvent event,
    Emitter<NotificationState> emit,
  ) {
    //TODO: map ActionNotificationEvent to NotificationState states
  }
}

extension NotificationBlocExtension on BuildContext {
  NotificationBloc get notificationBloc => read<NotificationBloc>();

  NotificationBloc get watchNotificationBloc => watch<NotificationBloc>();
}
