import 'package:dio/dio.dart';
import 'package:mou_business_app/core/databases/app_database.dart';
import 'package:mou_business_app/core/databases/dao/notification_dao.dart';
import 'package:mou_business_app/core/network_bound_resource.dart';
import 'package:mou_business_app/core/resource.dart';
import 'package:mou_business_app/core/services/api_service.dart';
import 'package:mou_business_app/utils/app_constants.dart';

class NotificationRepository {
  CancelToken _cancelToken = CancelToken();

  final NotificationDao notificationDao;

  NotificationRepository(this.notificationDao);

  Future<Resource<List<Notification>>> getNotifications(int page) async {
    if (_cancelToken.isCancelled) _cancelToken = CancelToken();
    final resource = NetworkBoundResource<List<Notification>, List<Notification>>(
      createCall: () => APIService.getNotifications(page, _cancelToken),
      parsedData: (json) {
        var data = json["data"] as List;
        return data.map((e) => Notification.fromJson(e)).toList();
      },
      saveCallResult: (notifications) async {
        if (page == AppConstants.FIRST_PAGE) await notificationDao.deleteAll();
        for (Notification notification in notifications) {
          await notificationDao.insertNotification(notification);
        }
      },
      loadFromDb: () => notificationDao.getNotificationsByPage(page),
    );
    return resource.getAsObservable();
  }

  Future<Resource<int?>> countNotifications() async {
    final resource = NetworkBoundResource<int?, int?>(
      createCall: () => APIService.countNotifications(),
      parsedData: (json) => json["total"] as int?,
    );
    return resource.getAsObservable();
  }
}
