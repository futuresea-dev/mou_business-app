import 'package:mou_business_app/utils/app_images.dart';

enum BubbleButtonType {
  events,
  calendar,
  projects,
  addTask,
  settings,
  employees;

  (double right, double bottom) get positionOffset {
    return switch (this) {
      events => (83, 155),
      calendar => (138, 129),
      projects => (23, 174),
      addTask => (172, 80),
      settings => (37, 115),
      employees => (93, 91),
    };
  }

  String get icon {
    return switch (this) {
      events => AppImages.icEvent_g,
      calendar => AppImages.icMenuBarAgenda,
      projects => AppImages.icSuitcase,
      addTask => AppImages.icMenuSettingAddTask,
      settings => AppImages.icSetting_g,
      employees => AppImages.icMenuSettingEmployee,
    };
  }
}
