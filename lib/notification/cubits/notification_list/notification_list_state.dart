part of 'notification_list_cubit.dart';

@freezed
sealed class NotificationListState with _$NotificationListState {
  
  const factory NotificationListState.loading() = LoadingNotificationListState;
  
  const factory NotificationListState.fetched() = FetchedNotificationListState;
  
  const factory NotificationListState.error() = ErrorNotificationListState;
  
}
