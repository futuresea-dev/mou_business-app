import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:rxdart/rxdart.dart';

typedef WifiListener = Function(bool enabled);

class WifiService {
  static final wifiSubject = BehaviorSubject<ConnectivityResult>();

  WifiService() {
    addListener();
  }

  Future<void> addListener() async {
    wifiSubject.add(await Connectivity().checkConnectivity());
    Connectivity().onConnectivityChanged.distinct().listen((ConnectivityResult result) {
      wifiSubject.add(result);
    });
  }

  static Future<bool> isConnectivity() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    return connectivityResult != ConnectivityResult.none;
  }

  static Future<bool> isDisconnect() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    return connectivityResult == ConnectivityResult.none;
  }

  Future<void> close() async {
    await wifiSubject.drain();
    wifiSubject.close();
  }
}
