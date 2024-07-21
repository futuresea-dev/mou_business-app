import 'package:flutter/material.dart';
import 'package:mou_business_app/utils/app_images.dart';

enum WorkStatus {
  OPEN,
  IN_PROGRESS,
  DONE;

  String get apiRequestName {
    return switch (this) {
      OPEN => "open",
      IN_PROGRESS => "progress",
      DONE => "done",
    };
  }

  int get value => this.index + 1;

  String get inactiveIconAsset {
    return switch (this) {
      OPEN => AppImages.icRequestInactive,
      IN_PROGRESS => AppImages.icOngoingInactive,
      DONE => AppImages.icDoneInactive,
    };
  }

  String get activeIconAsset {
    return switch (this) {
      OPEN => AppImages.icRequestActive,
      IN_PROGRESS => AppImages.icOngoingActive,
      DONE => AppImages.icDoneActive,
    };
  }

  Color get gradientColor {
    return switch (this) {
      OPEN => Color(0xFFEDEBEA),
      IN_PROGRESS => Color(0xFFFEFBD8),
      DONE => Color(0xFFD7EAC9),
    };
  }
}
