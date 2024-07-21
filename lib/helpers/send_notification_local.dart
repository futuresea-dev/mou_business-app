// ignore_for_file: unnecessary_null_comparison

import 'package:mou_business_app/core/databases/app_database.dart';
import 'package:mou_business_app/core/models/notify_id_management.dart';
import 'package:mou_business_app/core/models/time_in_alarm.dart';
import 'package:mou_business_app/utils/app_notifications.dart';
import 'package:mou_business_app/utils/app_shared.dart';

class SendNotificationLocal {
  static List<NotifyIdManagement>? notifyIds;

  static void registerNotificationLocal(Event event) {
    notifyIds = <NotifyIdManagement>[];
    if (event != null && (event.busyMode == null || event.busyMode == 0)) {
      if (event.startDate != null && event.endDate != null) {
        //trường hợp alarm bằng null và repeat khác null thì thông báo sẽ hiển
        //thị vào những thời điểm repeat đã được chọn và giờ báo thức sẽ là giờ
        //của ngày bắt đầu sự kiện
        if (event.alarm == null && event.repeat != null) {
          _checkRepeat(event);
          //trường hợp alarm bằng khác null và repeat null thì thông báo sẽ hiển
          //thị vào thời gian đăng ký alarm và đúng vào giờ ngày bắt đầu sự
          //kiện
        } else if (event.alarm != null && event.repeat == null) {
          _checkAlarm(event);
          //trường hợp alarm khác null và repeat khác null thì thông báo sẽ hiển
          //thị vào thời gian đăng ký alarm và đúng vào giờ các ngày trong tuần
          // đã đăng ký ở repeat và ngày bắt đầu sự kiện
        } else if (event.alarm != null && event.repeat != null) {
          _checkAlarmAndRepeat(event);
        } else {
          _checkAlarmAndRepeatNull(event);
        }
      } else if (event.startDate != null && event.endDate == null) {
        _checkNotifyStartDay(event, true);
      }
      if (notifyIds!.length > 0) {
        _saveEventNotifyToDataLocal();
      }
    }
  }

  static void _checkNotifyStartDay(Event event, bool isFirst) {
    if (event.alarm == null && event.repeat != null) {
      _checkRepeatStartDate(event, isFirst);
    } else if (event.alarm != null && event.repeat == null) {
      _checkAlarmStartDate(event, isFirst);
    } else if (event.alarm != null && event.repeat != null && event.repeat != "") {
      _checkAlarmAndRepeatStartDate(event, isFirst);
    } else {
      _checkAlarmAndRepeatNull(event);
    }
  }

  //Trường hợp ngày bắt đầu khác null và ngày kết thúc null
  //Chọn Alarm và chọn Repeat
  static void _checkAlarmAndRepeatStartDate(Event event, bool isFirst) {
    var lstRepeatString = event.repeat?.split(";");
    var lstAlarmString = event.alarm?.split(";");
    if (lstRepeatString != null &&
        lstRepeatString.length > 0 &&
        lstAlarmString != null &&
        lstAlarmString.length > 0) {
      var startDate = DateTime.parse(event.startDate ?? "");
      var daysDiff = DateTime.now().difference(startDate).inDays;
      startDate = daysDiff > 0 ? startDate.add(Duration(days: daysDiff)) : startDate;
      daysDiff = DateTime.now().difference(startDate).inDays;
      if (daysDiff <= 0) {
        var hourDiff = DateTime.now().difference(startDate).inHours;
        if (hourDiff > 0) {
          startDate = startDate.add(Duration(days: 1));
        } else {
          var minuteDiff = DateTime.now().difference(startDate).inMinutes;
          if (minuteDiff > 0) {
            startDate = startDate.add(Duration(days: 1));
          }
        }
      } else {
        startDate = startDate.add(Duration(days: 1));
      }

      if (startDate != null) {
        for (var i = 0; i < lstRepeatString.length; i++) {
          for (int j = 0; j < 7; j++) {
            if (startDate.add(Duration(days: j)).weekday == int.parse(lstRepeatString[i]))
              for (var k = 0; k < lstAlarmString.length; k++) {
                _prepareAddNotifyAlarm(event, startDate, lstAlarmString[k], j);
              }
          }
        }
      }
    }
  }

  //Trường hợp ngày bắt đầu khác null và ngày kết thúc null
  //Chọn Alarm và không chọn Repeat
  static void _checkAlarmStartDate(Event event, bool isFirst) {
    var lstAlarmString = event.alarm?.split(";");
    if (lstAlarmString != null && lstAlarmString.length > 0) {
      var startDate = DateTime.parse(event.startDate ?? "");
      startDate = DateTime.now().difference(startDate).inDays > 6 &&
              DateTime.now().difference(startDate).inDays % 7 == 0
          ? DateTime.now().add(Duration(days: 1))
          : startDate;
      if (!isFirst && startDate.difference(DateTime.now()).inDays < 7) startDate = DateTime.now();
      if (startDate != null) {
        for (var i = 0; i < lstAlarmString.length; i++) {
          for (int j = 0; j < 7; j++) {
            _prepareAddNotifyAlarm(event, startDate, lstAlarmString[i], j);
          }
        }
      }
    }
  }

  //Trường hợp ngày bắt đầu và ngày kết thúc null
  //Không chọn Alarm và chọn Repeat
  //Thì sẽ báo thức đúng vào giờ ngày sự kiện bắt đầu và đúng ngày trong tuần
  //đã chọn trong repeat
  static void _checkRepeatStartDate(Event event, bool isFirst) {
    var lstRepeatString = event.repeat?.split(";");
    if (lstRepeatString != null && lstRepeatString.length > 0) {
      var startDate = DateTime.parse(event.startDate ?? "");
      startDate = DateTime.now().difference(startDate).inDays > 6 &&
              DateTime.now().difference(startDate).inDays % 7 == 0
          ? DateTime.now().add(Duration(days: 1))
          : startDate;
      if (!isFirst && startDate.difference(DateTime.now()).inDays < 7) startDate = DateTime.now();
      if (startDate != null) {
        for (var i = 0; i < lstRepeatString.length; i++) {
          for (int j = 0; j < 7; j++) {
            if (startDate.add(Duration(days: j)).weekday == int.parse(lstRepeatString[i]))
              _sendNotification(event, startDate.add(Duration(days: j)));
          }
        }
      }
    }
  }

  //Trường hợp ngày bắt đầu và ngày kết thúc khác null
  //Không chọn Alarm và không chọn Repeat
  // Thì ứng dụng chỉ đăng ký ở thiết bị thông báo vào giờ và ngày bắt đầu sự kiện
  static void _checkAlarmAndRepeatNull(Event event) {
    var startDate = DateTime.parse(event.startDate ?? "");
    _sendNotification(event, startDate);
  }

  //Trường hợp ngày bắt đầu và ngày kết thúc khác null
  //Chọn Alarm và chọn Repeat
  static void _checkAlarmAndRepeat(Event event) {
    var lstRepeatString = event.repeat?.split(";");
    var lstAlarmString = event.alarm?.split(";");
    if (lstRepeatString != null &&
        lstRepeatString.length > 0 &&
        lstAlarmString != null &&
        lstAlarmString.length > 0) {
      var startDate = DateTime.parse(event.startDate ?? "");
      var endDate = DateTime.parse(event.endDate ?? "");
      int inDays = endDate.difference(DateTime.now()).inDays;
      int inStartDays = DateTime.now().difference(startDate).inDays;
      int daysDiff = inDays;
      if (inDays == 0) inDays = 1;

      startDate = startDate.add(Duration(days: inStartDays));
      if (daysDiff <= 0) {
        var hourDiff = DateTime.now().difference(startDate).inHours;
        if (hourDiff > 0) {
          startDate = startDate.add(Duration(days: 1));
        } else {
          var minuteDiff = DateTime.now().difference(startDate).inMinutes;
          if (minuteDiff > 0) {
            startDate = startDate.add(Duration(days: 1));
          }
        }
      }

      for (var i = 0; i < lstRepeatString.length; i++) {
        for (int j = 0; j < inDays; j++) {
          if (startDate.add(Duration(days: j)).weekday == int.parse(lstRepeatString[i]))
            for (var k = 0; k < lstAlarmString.length; k++) {
              _prepareAddNotifyAlarm(event, startDate, lstAlarmString[k], daysDiff == 0 ? 0 : j);
            }
        }
      }
    }
  }

  //Trường hợp ngày bắt đầu và ngày kết thúc khác null
  //Chọn Alarm và không chọn Repeat
  static void _checkAlarm(Event event) {
    var lstAlarmString = event.alarm?.split(";");
    if (lstAlarmString != null && lstAlarmString.length > 0) {
      var startDate = DateTime.parse(event.startDate ?? "");
      var endDate = DateTime.parse(event.endDate ?? "");
      int inDays = endDate.difference(startDate).inDays;
      int inStartDays = DateTime.now().difference(startDate).inDays;
      int daysDiff = inDays;
      if (inDays == 0) inDays = 1;

      startDate = startDate.add(Duration(days: inStartDays));
      if (daysDiff <= 0) {
        var hourDiff = DateTime.now().difference(startDate).inHours;
        if (hourDiff > 0) {
          startDate = startDate.add(Duration(days: 1));
        } else {
          var minuteDiff = DateTime.now().difference(startDate).inMinutes;
          if (minuteDiff > 0) {
            startDate = startDate.add(Duration(days: 1));
          }
        }
      }

      for (var i = 0; i < lstAlarmString.length; i++) {
        for (int j = 0; j < inDays; j++) {
          _prepareAddNotifyAlarm(event, startDate, lstAlarmString[i], daysDiff == 0 ? 0 : j);
        }
      }
    }
  }

  //Kiểm tra loại alarm này thuộc loại báo thức 5 phút, 10 phút...
  // để đăng ký thông báo vào thiết bị
  static void _prepareAddNotifyAlarm(Event event, DateTime startDate, String alarm, int days) {
    switch (alarm) {
      case fiveMinute:
        _addNotifyAlarm(event, startDate, days, -300);
        break;
      case tenMinute:
        _addNotifyAlarm(event, startDate, days, -600);
        break;
      case thirtyMinute:
        _addNotifyAlarm(event, startDate, days, -1800);
        break;
      case oneHour:
        _addNotifyAlarm(event, startDate, days, -3600);
        break;
      case oneDay:
        _addNotifyAlarm(event, startDate, days, -86400);
        break;
      case oneWeek:
        _addNotifyAlarm(event, startDate, days, -604800);
        break;
    }
  }

  //Kiểm tra  ngày bắt đầu sự kiện có giống với ngày bắt đầu sự kiện cộng thêm ngày
  // VD: Nếu ngày bắt đầu sự kiện là ngày thứ 2 và ngày bắt đầu sự kiện công 2 ngày
  // có phải là ngày thứ 2 hay không nếu bằng thì thêm báo thức
  static void _addNotifyAlarm(Event event, DateTime startDate, int days, int alarm) {
    if (startDate.weekday == startDate.add(Duration(days: days)).weekday) {
      _sendNotification(event, startDate.add(Duration(days: days)).add(Duration(seconds: -alarm)));
      _sendNotification(event, startDate.add(Duration(days: days)));
    }
  }

  //Trường hợp ngày bắt đầu và ngày kết thúc khác null
  //Không chọn Alarm và chọn Repeat
  //Thì sẽ báo thức đúng vào giờ ngày sự kiện bắt đầu và đúng ngày trong tuần
  //đã chọn trong repeat
  static void _checkRepeat(Event event) {
    var lstRepeatString = event.repeat?.split(";");
    if (lstRepeatString != null && lstRepeatString.length > 0) {
      var startDate = DateTime.parse(event.startDate ?? "");
      var endDate = DateTime.parse(event.endDate ?? "");
      int inDays = endDate.difference(startDate).inDays;
      int inStartDays = DateTime.now().difference(startDate).inDays;
      int daysDiff = inDays;

      if (inDays == 0) inDays = 1;

      startDate = startDate.add(Duration(days: inStartDays));
      if (daysDiff <= 0) {
        var hourDiff = DateTime.now().difference(startDate).inHours;
        if (hourDiff > 0) {
          startDate = startDate.add(Duration(days: 1));
        } else {
          var minuteDiff = DateTime.now().difference(startDate).inMinutes;
          if (minuteDiff > 0) {
            startDate = startDate.add(Duration(days: 1));
          }
        }
      }

      for (var i = 0; i < lstRepeatString.length; i++) {
        for (int j = 0; j < inDays; j++) {
          if (startDate.add(Duration(days: j)).weekday == int.parse(lstRepeatString[i]))
            _sendNotification(event, startDate.add(Duration(days: daysDiff == 0 ? 0 : j)));
        }
      }
    }
  }

  //Đăng ký báo thức cho ứng dụng
  static void _sendNotification(Event event, DateTime dateTime) async {
    AppNotifications.singleNotification(dateTime, event.title != null ? event.title ?? "" : "",
        event.comment != null ? event.comment ?? "" : "", dateTime.hashCode);
    notifyIds?.add(NotifyIdManagement(id: event.id, notifyId: dateTime.hashCode));
    print("Add notification");
  }

  static Future<void> _saveEventNotifyToDataLocal() async {
    var notifyIdManagements = await AppShared.getNotifyIdManagementList();
    if (notifyIdManagements == null ||
        (notifyIdManagements != null && notifyIdManagements.notifyIdManagements == null)) {
      notifyIdManagements = NotifyIdManagementList();
      notifyIdManagements.notifyIdManagements = <NotifyIdManagement>[];
    }
    notifyIdManagements.notifyIdManagements?.addAll(notifyIds ?? []);
    await AppShared.setNotifyIdManagementList(notifyIdManagements);
  }

  static Future<void> removeEventRegisterFromDevice(Event event) async {
    var notifyIdManagements = await AppShared.getNotifyIdManagementList();
    if (notifyIdManagements != null &&
        notifyIdManagements.notifyIdManagements != null &&
        notifyIdManagements.notifyIdManagements!.length > 0) {
      var notifyListFilter =
          notifyIdManagements.notifyIdManagements?.where((item) => item.id == event.id).toList();
      if (notifyListFilter != null && notifyListFilter.length > 0) {
        for (var notify in notifyListFilter) {
          await AppNotifications.cancel(notify.notifyId ?? 0);
        }
        notifyIdManagements.notifyIdManagements =
            notifyIdManagements.notifyIdManagements?.where((item) => item.id != event.id).toList();
        await AppShared.setNotifyIdManagementList(notifyIdManagements);
      }
    }
  }
}
