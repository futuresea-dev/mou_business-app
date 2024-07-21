import 'dart:ui';

import 'package:mou_business_app/ui/widgets/slidable/app_slidable.dart';
import 'package:mou_business_app/utils/app_colors.dart';
import 'package:mou_business_app/utils/app_images.dart';

enum SlidableActionType implements AppSlidableActionType {
  EXPORT,
  EDIT,
  DELETE,
  ACCEPT,
  DENY;

  @override
  double? get iconSize {
    return switch (this) {
      EXPORT => null,
      EDIT => null,
      DELETE => null,
      ACCEPT => 22,
      DENY => 18,
    };
  }

  @override
  String get iconPath {
    return switch (this) {
      EXPORT => AppImages.icMoreOptions,
      EDIT => AppImages.icEditSVG,
      DELETE => AppImages.icDeleteSVG,
      ACCEPT => AppImages.icAcceptW,
      DENY => AppImages.icDenyW,
    };
  }

  @override
  Color get backgroundColor {
    return switch (this) {
      EXPORT => const Color(0xFFE8A65A),
      EDIT => AppColors.slidableGrey,
      DELETE => AppColors.slidableRed,
      ACCEPT => AppColors.slidableGreen,
      DENY => AppColors.slidableRed,
    };
  }
}
