import 'package:drift/drift.dart';
import 'package:mou_business_app/core/databases/app_database.dart';
import 'package:mou_business_app/core/databases/table/notifications.dart';

part 'notification_dao.g.dart';

@DriftAccessor(tables: [Notifications])
class NotificationDao extends DatabaseAccessor<AppDatabase> with _$NotificationDaoMixin {
  final AppDatabase db;

  NotificationDao(this.db) : super(db);

  Future<List<Notification>> getAllNotifications() => select(notifications).get();

  Future<List<Notification>> getNotificationsByPage(int page) =>
      (select(notifications)..limit(10, offset: 10 * (page - 1))).get();

  Future insertNotification(Notification notification) =>
      into(notifications).insert(notification, mode: InsertMode.insertOrReplace);

  Future deleteAll() => delete(notifications).go();
}
