import 'package:supa_flutter/core/misc/repository.dart';

abstract interface class NotificationRepository {
  void fetchAll();
}

class NotificationRepositoryImpl extends Repository
    implements NotificationRepository {
  const NotificationRepositoryImpl();

  @override
  void fetchAll() {}
}
