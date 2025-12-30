import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'notification_list_state.dart';
part 'notification_list_state_utils.dart';

part 'notification_list_cubit.freezed.dart';

class NotificationListCubit extends Cubit<NotificationListState> {
  NotificationListCubit() : super(const NotificationListState.loading());
  
  FutureOr<void> fetchAll() {
    //TODO: map fetchAll to NotificationListState states
  }
  
}

extension NotificationListCubitExtension on BuildContext {
  NotificationListCubit get notificationListCubit => read<NotificationListCubit>();

  NotificationListCubit get watchNotificationListCubit => watch<NotificationListCubit>();
}
