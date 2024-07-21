import 'dart:convert';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:timezone/timezone.dart' as tz;

typedef MessageCallback(Map<String, dynamic> message);
typedef AlarmCallback(DateTime alarmDate);
typedef ChatCallback(String roomChatID);

class PushNotificationLocalHelper {
  static const String CHANNEL_ID = 'mou_personal_id';
  static const String CHANNEL_NAME = 'mou_personal_name';
  static const String CHANNEL_DESCRIPTION = 'mou_personal_description';

  static final localNotificationsPlugin = FlutterLocalNotificationsPlugin();
  static PushNotificationLocalHelper? _instance;

  MessageCallback? _messageCallback;
  AlarmCallback? _alarmCallback;
  ChatCallback? _chatCallback;

  factory PushNotificationLocalHelper.getInstance() {
    return _instance ??= PushNotificationLocalHelper();
  }

  addMessageCallback(MessageCallback callback) {
    this._messageCallback = callback;
  }

  addAlarmCallback(AlarmCallback callback) {
    this._alarmCallback = callback;
  }

  addChatCallback(ChatCallback callback) {
    this._chatCallback = callback;
  }

  PushNotificationLocalHelper() {
    final initSettings = InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
      iOS: DarwinInitializationSettings(),
    );
    localNotificationsPlugin
        .initialize(initSettings, onDidReceiveNotificationResponse: _onSelectNotification)
        .then((value) {
      print("local notification init success");
    });
  }

  void singleNotification(
    DateTime datetime,
    String message,
    String subtext,
    int hashcode,
    DateTime createdAt,
  ) {
    final androidChannel = AndroidNotificationDetails(
      CHANNEL_ID,
      CHANNEL_NAME,
      channelDescription: CHANNEL_DESCRIPTION,
      importance: Importance.max,
      priority: Priority.high,
    );

    final iosChannel = DarwinNotificationDetails();
    final platformChannel = NotificationDetails(
      android: androidChannel,
      iOS: iosChannel,
    );
    final data = {
      "message": "message",
      "created_at": DateFormat("yyyy-MM-dd HH:mm:ss").format(createdAt)
    };
    final jsonData = jsonEncode(data);
    var scheduledDate = tz.TZDateTime.from(
      datetime,
      tz.local,
    );
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    if (scheduledDate.isAfter(now)) {
      localNotificationsPlugin.zonedSchedule(
        hashcode,
        message,
        subtext,
        scheduledDate,
        platformChannel,
        payload: jsonData.toString(),
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
      );
    }
  }

  void showNotification(String title, String subtext, String payload) {
    final androidChannel = AndroidNotificationDetails(
      CHANNEL_ID,
      CHANNEL_NAME,
      channelDescription: CHANNEL_DESCRIPTION,
      importance: Importance.max,
      priority: Priority.high,
      showWhen: false,
    );

    final iosChannel = DarwinNotificationDetails(); // IOSNotificationDetails();
    final platformChannel = NotificationDetails(
      android: androidChannel,
      iOS: iosChannel,
    );
    localNotificationsPlugin.show(
      DateTime.now().millisecond,
      title,
      subtext,
      platformChannel,
      payload: payload,
    );
  }

  Future cancel(int id) async {
    await localNotificationsPlugin.cancel(id);
  }

  Future cancelAll() async {
    await localNotificationsPlugin.cancelAll();
  }

  Future _onSelectNotification(NotificationResponse payload) async {
    print("Payload $payload");
    Map<String, dynamic> data = jsonDecode(payload.payload ?? "");
    if (data.isEmpty) return;
    if (data.containsKey("created_at")) {
      final createdAt = DateTime.parse(data["created_at"]);
      if (_alarmCallback != null) _alarmCallback!(createdAt);
    }
    if (data.containsKey("room_chat_id")) {
      String roomChatID = data["room_chat_id"] ?? [];
      if (roomChatID.length > 0 && _chatCallback != null) {
        _chatCallback!(roomChatID);
      }
    }
    if (data.containsKey("notify_type")) {
      if (_messageCallback != null) _messageCallback!(data);
    }
  }
}
