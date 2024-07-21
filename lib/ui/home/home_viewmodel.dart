import 'dart:convert';
import 'dart:io';

import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:mou_business_app/core/databases/dao/employee_dao.dart';
import 'package:mou_business_app/core/repositories/employee_repository.dart';
import 'package:mou_business_app/core/repositories/notification_repository.dart';
import 'package:mou_business_app/core/repositories/user_repository.dart';
import 'package:mou_business_app/core/resource.dart';
import 'package:mou_business_app/helpers/push_notification_helper.dart';
import 'package:mou_business_app/helpers/push_notification_local_helper.dart';
import 'package:mou_business_app/helpers/routers.dart';
import 'package:mou_business_app/managers/payments_manager.dart';
import 'package:mou_business_app/ui/base/base_viewmodel.dart';
import 'package:mou_business_app/ui/project_detail/project_detail_page.dart';
import 'package:mou_business_app/utils/app_globals.dart';
import 'package:mou_business_app/utils/app_shared.dart';
import 'package:mou_business_app/utils/app_utils.dart';
import 'package:mou_business_app/utils/types/app_types.dart';
import 'package:rxdart/rxdart.dart';

class HomeViewModel extends BaseViewModel {
  final showUISubject = BehaviorSubject<bool>.seeded(false);

  final UserRepository _userRepository;
  final NotificationRepository _notificationRepository;
  final EmployeeRepository _employeeRepository;
  final EmployeeDao _employeeDao;
  final PaymentsManager _paymentsManager;

  HomeViewModel(
    this._userRepository,
    this._notificationRepository,
    this._employeeRepository,
    this._employeeDao,
    this._paymentsManager,
  );

  void init(bool openCalendar) async {
    if (openCalendar) {
      Future.delayed(Duration(milliseconds: 300), () {
        Navigator.pushNamed(context, Routers.CALENDAR);
        Future.delayed(Duration(milliseconds: 300), () => showUISubject.add(true));
      });
    } else {
      showUISubject.add(true);
    }
    _countNotifications();
    _registerFCM();
    _initDynamicLinks();
    _fetchEmployee();
  }

  void _registerFCM() {
    PushNotificationHelper.getToken().then((firebaseToken) {
      if (firebaseToken.isEmpty) return;
      //Update FireBase Cloud Message Token to server
      final deviceOS = Platform.isIOS ? "ios" : "android";
      _userRepository
          .updateFCMToken(fcmToken: firebaseToken, deviceOS: deviceOS)
          .then((value) => print("Update FCM ${value.message}"))
          .catchError((error) => print("Update FCM " + error.toString()));
    });
    PushNotificationHelper.processInitialMessage();
    PushNotificationHelper.setNotificationCallback((firebaseMessage) {
      if (firebaseMessage.isNavigate) {
        // Handle action when touch notify
        if (firebaseMessage.type == NotifyType.SMS_MESSAGE) {
          _navigationSMSMessage(firebaseMessage.toJson());
        } else {
          _navigationMessage(firebaseMessage.toJson());
        }
      } else if (firebaseMessage.title.isNotEmpty && (Platform.isAndroid || Platform.isIOS)) {
        PushNotificationLocalHelper.getInstance().showNotification(
          firebaseMessage.title,
          firebaseMessage.body,
          jsonEncode(firebaseMessage.toJson()),
        );
      }
    });

    PushNotificationLocalHelper.getInstance()
      ..addAlarmCallback((alarmDate) {
        Navigator.pushNamedAndRemoveUntil(
          context,
          Routers.HOME,
          (router) => false,
          arguments: alarmDate,
        );
      })
      ..addMessageCallback((message) async {
        // Handle action when touch local notify
        String notifyType = "";
        if (message.containsKey("notify_type")) {
          notifyType = message["notify_type"] ?? "";
        }
        if (notifyType == NotifyType.SMS_MESSAGE) {
          _navigationSMSMessage(message);
        } else {
          _navigationMessage(message);
        }
      });
  }

  void _navigationMessage(Map<String, dynamic> message) {
    debugPrint('Navigation Message: ${jsonEncode(message)}');
    final String routeName = message.containsKey('route_name') ? message['route_name'] : '';
    if (routeName.isNotEmpty) {
      final arguments = message.containsKey('arguments') ? message['arguments'] : null;
      if (routeName == Routers.CALENDAR) {
        Navigator.pushNamedAndRemoveUntil(context, routeName, (route) => route.isFirst,
            arguments: arguments);
      } else {
        Navigator.pushNamed(context, routeName, arguments: arguments);
      }
    }
  }

  void _initDynamicLinks() async {
    final data = await FirebaseDynamicLinks.instance.getInitialLink();
    _navigationDeepLink(data?.link);

    FirebaseDynamicLinks.instance.onLink.listen(
      (dynamicLink) {
        _navigationDeepLink(dynamicLink.link);
      },
      onError: (e) async {
        print('onLinkError');
        print(e.message);
      },
    );
  }

  void _navigationDeepLink(Uri? deepLink) {
    if (deepLink == null) return;
    print("Dynamic link path: ${deepLink.toString()}");
    _navigationSMSMessage(deepLink.queryParameters);
  }

  void _navigationSMSMessage(Map<String, dynamic> message) {
    if (message.isEmpty) return;
    final page = message["page"] ?? "";
    print("Dynamic link page: $page");
    if (page.endsWith("employee")) {
      Navigator.pushNamed(context, Routers.EMPLOYEE);
    } else if (page.endsWith("project_detail")) {
      final id = message["id"] ?? 0;
      final name = message["name"] ?? "";
      print("Dynamic link id: $id");
      print("Dynamic link name: $name");
      Navigator.pushNamed(context, Routers.PROJECT_DETAIL,
          arguments: ProjectDetailArgument(int.parse(id.toString()), name));
    } else if (page.endsWith("project")) {
      final key = message["key"] ?? 0;
      print("Dynamic link key: $key");
      Navigator.pushNamed(context, Routers.WORK);
    } else if (page.endsWith("task")) {
      final id = message["event_id"] != null ? message["event_id"] as int : 0;
      final taskName = message["title"] ?? 0;
      print("Dynamic link key: $id");
      Navigator.pushNamed(context, Routers.TASK_DETAIL, arguments: [id, taskName]);
    } else if (page.endsWith("roster")) {
      final date = message["date"] ?? "";
      print("Dynamic link key: $date");
      if (date != "") {
        final rosterDate = AppUtils.convertStringToDateTime(date);
        Navigator.pushNamed(context, Routers.ROSTER, arguments: rosterDate);
      }
    } else if (message.containsKey("action")) {
      final action = message["action"] ?? "";
      print("Dynamic link action: $action");
      if (action.contains("PHONE_CHANGE")) {
        AppGlobals.logout(context, arguments: message);
      }
    }
  }

  Future<void> _countNotifications() async {
    Resource<int?> resource = await _notificationRepository.countNotifications();

    if (resource.isSuccess) {
      AppShared.setCountNotification(resource.data ?? 0);
    }
  }

  void onAddEmployee() async {
    setLoading(true);
    final int currentUsers = await _employeeDao.getLocalEmployees().then((value) => value.length);
    final bool purchased = await _paymentsManager.checkPurchased(context, currentUsers);
    setLoading(false);
    if (purchased) {
      Navigator.pushNamed(context, Routers.ADD_EMPLOYEE).then((_) => _fetchEmployee());
    }
  }

  Future<void> _fetchEmployee() async {
    setLoading(true);
    await _employeeRepository.getEmployeeList();
    setLoading(false);
  }
}
