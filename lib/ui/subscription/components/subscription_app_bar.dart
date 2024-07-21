import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mou_business_app/utils/app_images.dart';

class SubscriptionAppBar extends StatelessWidget implements PreferredSizeWidget{
  const SubscriptionAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      systemOverlayStyle: SystemUiOverlayStyle(
        // Status bar color
        statusBarColor: Color(0xFFF3F3F3),
        // Status bar brightness (optional)
        statusBarIconBrightness: Brightness.dark,
        // For Android (dark icons)
        statusBarBrightness: Brightness.light,
        // For iOS (dark icons)
        systemNavigationBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark, // (dark icons)
      ),
      leading: IconButton(
        onPressed: () => Navigator.pop(context),
        icon: Image.asset(
          AppImages.icArrowBack,
          width: 14,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
