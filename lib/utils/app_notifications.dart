import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class AppNotifications {
  static final localNotificationsPlugin = FlutterLocalNotificationsPlugin();
  static BuildContext? context;

  static initializeNotifications(BuildContext context) async {
    final initSettings = InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
      iOS: DarwinInitializationSettings(),
    );
    localNotificationsPlugin
        .initialize(initSettings,
            onDidReceiveNotificationResponse: onSelectNotification)
        .then((value) {
      print("local notification init success");
    });
    // AppNotifications.context = context;
    // var initializeAndroid =
    //     AndroidInitializationSettings('@mipmap/ic_launcher');
    // var initializeIOS = IOSFlutterLocalNotificationsPlugin();
    // var initSettings =
    //     DarwinInitializationSettings(initializeAndroid, initializeIOS);
    // await localNotificationsPlugin.initialize(initSettings,
    //     onSelectNotification: onSelectNotification);
  }

  static Future singleNotification(
      DateTime datetime, String message, String subtext, int hashcode,
      {String? sound,
      String channelId = 'channel-id',
      String channelName = 'channel-name',
      String channelDes = 'channel-description'}) async {
    AndroidNotificationDetails androidChannel = AndroidNotificationDetails(
      channelId,
      channelName,
      channelDescription: channelDes,
      importance: Importance.max,
      priority: Priority.max,
    );

    var iosChannel = DarwinNotificationDetails();
    var platformChannel =
        NotificationDetails(android: androidChannel, iOS: iosChannel);
    localNotificationsPlugin.show(
        datetime.millisecond, message, subtext, platformChannel,
        payload: hashcode.toString());
  }

  static Future showNotification(String message, String subtext,
      {String? sound,
      String channelId = 'channel-id',
      String channelName = 'channel-name',
      String channelDes = 'channel-description'}) async {
    var androidChannel = AndroidNotificationDetails(
      channelId,
      channelName,
      channelDescription: channelDes,
      importance: Importance.max,
      priority: Priority.max,
    );

    var iosChannel = DarwinNotificationDetails();
    var platformChannel =
        NotificationDetails(android: androidChannel, iOS: iosChannel);
    localNotificationsPlugin.show(
        DateTime.now().millisecond, message, subtext, platformChannel);
  }

  static Future cancel(int id) async {
    await localNotificationsPlugin.cancel(id);
  }

  static Future cancelAll() async {
    await localNotificationsPlugin.cancelAll();
  }

  static Future onSelectNotification(NotificationResponse payload) async {
    print("payload $payload");
  }
}
