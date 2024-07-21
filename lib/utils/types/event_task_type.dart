import 'package:mou_business_app/utils/app_images.dart';

enum EventTaskType {
  PROJECT_TASK,
  TASK,
  ROSTER,
  EVENT;

  static const List<EventTaskType> filterTypes = [PROJECT_TASK, TASK, ROSTER];

  String get inactiveIcon {
    return switch (this) {
      TASK => AppImages.btFilterETasksOff,
      PROJECT_TASK => AppImages.btFilterEProjectOff,
      ROSTER => AppImages.btFilterERostersOff,
      EVENT => '',
    };
  }

  String get activeIcon {
    return switch (this) {
      TASK => AppImages.btFilterETasksOn,
      PROJECT_TASK => AppImages.btFilterEProjectOn,
      ROSTER => AppImages.btFilterERostersOn,
      EVENT => '',
    };
  }
}
