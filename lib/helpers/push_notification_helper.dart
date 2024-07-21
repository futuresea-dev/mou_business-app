import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:mou_business_app/core/models/firebase_message.dart';

class PushNotificationHelper {
  static final FirebaseMessaging _fm = FirebaseMessaging.instance;
  static String _latestProcessedInitialMessageId = '';

  static ValueChanged<FirebaseMessage>? _callback;

  static Future<void> setupFirebaseFCM() async {
    // Config FirebaseMessaging Plugin - Used for iOS
    await _fm.setForegroundNotificationPresentationOptions(
      alert: true, // Required to display a heads up notification
      badge: true,
      sound: true,
    );
    final Future<NotificationSettings> request = _fm.requestPermission(
      sound: true,
      badge: true,
      alert: true,
    );
    request.then((settings) {
      if (settings.authorizationStatus == AuthorizationStatus.authorized) {
        debugPrint('User granted permission');
        // For handling received message

        // Minimize apps
        FirebaseMessaging.onBackgroundMessage(onBackgroundMessage);

        // Push Notification is clicked when using app
        FirebaseMessaging.onMessageOpenedApp.listen(_handleNotificationActionFromRemoteMessage);

        // Push Notification arrives when the App is in Opened and in Foreground
        FirebaseMessaging.onMessage.listen(_handleForegroundNotification);
      } else {
        debugPrint('User declined or has not accepted permission');
      }
    }).catchError((error) {
      debugPrint('User declined or has not accepted permission');
    });
  }

  /// When the user taps on a Notification with the Application close we have
  /// to consume it ones the App is completely started.
  static void processInitialMessage() => _fm.getInitialMessage().then(_handleInitialMessage);

  /// Set callback to listen when receiving notifications
  static void setNotificationCallback(ValueChanged<FirebaseMessage> callback) =>
      _callback = callback;

  static Future<dynamic> _handleInitialMessage(RemoteMessage? message) async {
    if (message != null) {
      if (_latestProcessedInitialMessageId != message.messageId) {
        _latestProcessedInitialMessageId = message.messageId ?? '';
        debugPrint('Processing Initial Message');
        _handleNotificationActionFromRemoteMessage(message);
      } else {
        debugPrint('Initial Message Already Processed');
      }
    }
  }

  static void onHandleMessage(RemoteMessage message) {
    _handleNotificationActionFromRemoteMessage(message);
  }

  static void _handleForegroundNotification(RemoteMessage message) {
    debugPrint('_handleForegroundNotification ${message.toMap()}');
    _callback?.call(FirebaseMessage.fromJson(message.data).copyWith(
      title: message.notification?.title,
      body: message.notification?.body,
      isNavigate: false,
    ));
  }

  static void _handleNotificationActionFromRemoteMessage(RemoteMessage message) {
    debugPrint('_handleNotificationActionFromRemoteMessage ${message.toMap()}');
    _callback?.call(FirebaseMessage.fromJson(message.data).copyWith(
      title: message.notification?.title,
      body: message.notification?.body,
      isNavigate: true,
    ));
  }

  static Future<void> deleteToken() => _fm.deleteToken();

  static Future<String> getToken() => _fm.getToken().then((value) => value ?? '');
}

Future<void> onBackgroundMessage(RemoteMessage message) async {
  debugPrint('On Message Background');
  return PushNotificationHelper.onHandleMessage(message);
}
