import 'package:flutter/material.dart';
import 'package:mou_business_app/utils/app_images.dart';

import '../app_colors.dart';

enum EventStatus {
  WAITING,
  DENIED,
  CONFIRMED;

  String get inactiveIconAsset {
    return switch (this) {
      WAITING => AppImages.icWaitingInactive,
      DENIED => AppImages.icDenied,
      CONFIRMED => AppImages.icDoneInactive,
    };
  }

  String get activeIconAsset {
    return switch (this) {
      WAITING => AppImages.icWaitingActive,
      DENIED => AppImages.icDenied,
      CONFIRMED => AppImages.icDoneActive,
    };
  }

  Color get color {
    return switch (this) {
      WAITING => AppColors.themeColor,
      DENIED => AppColors.slidableRed,
      CONFIRMED => Colors.transparent,
    };
  }
}
