part of 'notification_bloc.dart';

@freezed
sealed class NotificationState with _$NotificationState {
  
  const factory NotificationState.initial() = InitialNotificationState;
  
}
