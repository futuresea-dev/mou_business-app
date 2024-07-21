import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionsService {
  Future<bool> _requestPermission(Permission permission) async {
    return await permission.request().isGranted;
  }

  Future<bool> hasPermission(Permission permission) async {
    return permission.status.isGranted;
  }

  Future<bool> requestContactsPermission({Function? onPermissionDenied}) async {
    var granted = await _requestPermission(Permission.contacts);
    if (!granted) {
      onPermissionDenied!();
    }
    return granted;
  }

  Future<bool> hasContactsPermission() async {
    return hasPermission(Permission.contacts);
  }

  Future<bool> requestStoragePermission({Function? onPermissionDenied}) async {
    var granted = await _requestPermission(Permission.storage);
    if (!granted) {
      onPermissionDenied?.call();
    }
    return granted;
  }

  Future<bool> requestManageExternalStorage({Function? onPermissionDenied}) async {
    var granted = await _requestPermission(Permission.manageExternalStorage);
    if (!granted) {
      onPermissionDenied?.call();
    }
    return granted;
  }

  Future<bool> checkStoragePermission() async {
    if (Platform.isIOS) {
      return true;
    }

    if (Platform.isAndroid) {
      final AndroidDeviceInfo info = await DeviceInfoPlugin().androidInfo;
      if (info.version.sdkInt > 28) {
        return true;
      }

      final PermissionStatus status = await Permission.storage.status;
      if (status == PermissionStatus.granted) {
        return true;
      }

      final PermissionStatus result = await Permission.storage.request();
      return result == PermissionStatus.granted;
    }

    throw StateError('unknown platform');
  }
}
