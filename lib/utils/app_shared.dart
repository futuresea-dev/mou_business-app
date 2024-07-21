import 'dart:async';
import 'dart:convert';

import 'package:mou_business_app/core/models/event_count.dart';
import 'package:mou_business_app/core/models/notify_id_management.dart';
import 'package:mou_business_app/core/responses/register_response.dart';
import 'package:rx_shared_preferences/rx_shared_preferences.dart';

class AppShared {
  static const String keyAccessToken = "keyMouAccessToken";
  static const String keyUser = "keyMouBusinessUser";
  static const String keyUserID = "keyMouBusinessUserID";
  static const String keyEventCount = "keyMouBusinessEventCount";
  static const String keyNotifyIdManagement = "keyMouBusinessNotifyIdManagement";
  static const String keyCountNotification = "keyCountNotification";

  static final _prefs = RxSharedPreferences(SharedPreferences.getInstance());

  static Future<void> setAccessToken(String accessToken) =>
      _prefs.setString(keyAccessToken, accessToken);

  static Future<String?> getAccessToken() => _prefs.getString(keyAccessToken);

  static FutureOr<void> setUserID(int? userID) {
    _prefs.setInt(keyUserID, userID);
  }

  static FutureOr<int?> getUserID() => _prefs.getInt(keyUserID);

  static Stream<int?> watchUserID() => _prefs.getIntStream(keyUserID);

  static Future<void> setEventCount(EventCount? value) async {
    final String json = value == null ? "" : jsonEncode(value.toJson());
    _prefs.setString(keyEventCount, json);
  }

  static Future<EventCount> getEventCount() async {
    final String json = await _prefs.getString(keyEventCount) ?? "";
    if (json.isEmpty) return EventCount();
    return EventCount.fromJson(jsonDecode(json));
  }

  static FutureOr<void> setUser(RegisterResponse? user) {
    final String json = user == null ? "" : jsonEncode(user.toJson());
    return _prefs.setString(keyUser, json);
  }

  static Future<RegisterResponse> getUser() async {
    final String json = await _prefs.getString(keyUser) ?? "";
    return json.isNotEmpty ? RegisterResponse.fromJson(jsonDecode(json)) : RegisterResponse();
  }

  static FutureOr<void> setNotifyIdManagementList(NotifyIdManagementList? notifyIds) async {
    final String json = notifyIds == null ? "" : jsonEncode(notifyIds.toJson());
    print("setNotifyIdManagementList $json");
    await _prefs.setString(keyNotifyIdManagement, json);
  }

  static FutureOr<NotifyIdManagementList> getNotifyIdManagementList() async {
    final String json = await _prefs.getString(keyNotifyIdManagement) ?? "";
    print("getNotifyIdManagementList $json");
    if (json.length == 0) return NotifyIdManagementList();

    return NotifyIdManagementList.fromJson(jsonDecode(json));
  }

  static FutureOr<void> setCountNotification(int value) {
    _prefs.setInt(keyCountNotification, value);
  }

  static FutureOr<int> getCountNotification() async {
    return await _prefs.getInt(keyCountNotification) ?? 0;
  }

  static Stream<int?> watchCountNotification() {
    return _prefs.getIntStream(keyCountNotification);
  }

  static Future<void> clear() => _prefs.clear();
}
