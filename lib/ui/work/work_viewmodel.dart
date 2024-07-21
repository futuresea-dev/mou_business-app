import 'dart:isolate';
import 'dart:ui';

import 'package:flutter/services.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:mou_business_app/core/repositories/project_repository.dart';
import 'package:mou_business_app/helpers/permissions_service.dart';
import 'package:mou_business_app/helpers/translations.dart';
import 'package:mou_business_app/ui/base/base_viewmodel.dart';
import 'package:mou_business_app/utils/app_languages.dart';
import 'package:rxdart/rxdart.dart';

class WorkViewModel extends BaseViewModel {
  final indexSubject = BehaviorSubject<int>.seeded(1);

  void onTabChanged(int index) => indexSubject.add(index);

  final PermissionsService permissionsService;
  final ProjectRepository projectRepository;

  WorkViewModel(this.permissionsService, this.projectRepository);

  final ReceivePort _port = ReceivePort();

  @pragma('vm:entry-point')
  static void downloadCallback(String id, int status, int progress) {
    final SendPort? send = IsolateNameServer.lookupPortByName('downloader_send_port');
    send?.send([id, status, progress]);
  }

  void onInit() {
    IsolateNameServer.registerPortWithName(_port.sendPort, 'downloader_send_port');
    _port.listen((dynamic data) async {
      final status = DownloadTaskStatus.fromInt(int.tryParse(data[1].toString()) ?? 0);
      String? message;
      switch (status) {
        case DownloadTaskStatus.complete:
          final String? taskId = data[0];
          if (taskId != null) {
            await Future.delayed(Duration(seconds: 1));
            final bool opened = await FlutterDownloader.open(taskId: taskId);
            if (opened) {
              setLoading(false);
            } else {
              message = S.text(AppLanguages.cannotOpenThisFile);
            }
          } else {
            message = S.text(AppLanguages.thisProjectCannotBeExported);
          }
          break;
        case DownloadTaskStatus.failed:
        // Show error message This project cannot be exported!
          message = S.text(AppLanguages.thisProjectCannotBeExported);
          break;
        case DownloadTaskStatus.canceled:
        case DownloadTaskStatus.paused:
          setLoading(false);
          break;
        case DownloadTaskStatus.running:
          if (!isLoading) {
            setLoading(true);
          }
          break;
        default:
          break;
      }
      if (message != null) {
        setLoading(false);
        showSnackBar(message);
      }
    });
    FlutterDownloader.registerCallback(downloadCallback);
  }

  Future<bool> _checkStoragePermission() async {
    if (await permissionsService.checkStoragePermission()) {
      return true;
    } else {
      return await permissionsService.requestStoragePermission(
        onPermissionDenied: () => showSnackBar("Storage permission denied"),
      );
    }
  }

  Future<void> onExportProject(int eventId) async {
    String? message;
    setLoading(true);
    if (await _checkStoragePermission()) {
      try {
        await projectRepository.downloadFile(eventId);
      } catch (e) {
        if (e is FlutterDownloaderException) {
          message = e.message;
        } else if (e is PlatformException) {
          message = e.message ?? e.toString();
        } else {
          message = e.toString();
        }
      }
    } else {
      // Show error message Storage permission has not been granted
      message = S.text(AppLanguages.storagePermissionHasNotBeenGranted);
    }
    if (message != null) {
      setLoading(false);
      showSnackBar(message);
    }
  }

  @override
  void dispose() {
    IsolateNameServer.removePortNameMapping('downloader_send_port');
    indexSubject.close();
    super.dispose();
  }
}
