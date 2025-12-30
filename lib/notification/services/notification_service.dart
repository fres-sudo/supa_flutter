import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:supa_flutter/core/misc/result.dart';
import 'package:supa_flutter/core/services/supabase/supabase_service.dart';
import 'package:supa_flutter/notification/models/app_notification/app_notification.dart';

abstract class NotificationService {
  Future<Result<void>> sendNotification(AppNotification notification);
  Future<Result<List<AppNotification>>> getNotifications();
  Future<Result<void>> setFcmToken();
}

class NotificationServiceImpl extends SupabaseService
    implements NotificationService {
  SupabaseQueryBuilder get _notificationsTable => client.from('notifications');
  SupabaseQueryBuilder get _usersTable => client.from('users');

  @override
  Future<Result<void>> sendNotification(AppNotification notification) => safe(
      "sendNotification",
      () => _notificationsTable.insert(notification.toJson()));

  @override
  Future<Result<List<AppNotification>>> getNotifications() =>
      safeAuthenticated("getNotifications", (user) async {
        final result =
            await _notificationsTable.select().eq("user_id", user.id);
        return result.map((e) => AppNotification.fromJson(e)).toList();
      });

  @override
  Future<Result<void>> setFcmToken() =>
      safeAuthenticated("setFcmToken", (user) async {
        await FirebaseMessaging.instance.requestPermission();
        await FirebaseMessaging.instance.getAPNSToken();

        final fcmToken = await FirebaseMessaging.instance.getToken();
        if (fcmToken == null) {
          return;
        }
        await _usersTable.update({"fcm_token": fcmToken}).eq("id", user.id);
      });
}
