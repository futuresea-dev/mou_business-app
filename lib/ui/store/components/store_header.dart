import 'package:flutter/material.dart';
import 'package:mou_business_app/ui/widgets/app_header.dart';
import 'package:mou_business_app/utils/app_images.dart';

class StoreHeader extends StatelessWidget {
  const StoreHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return AppHeader(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12).copyWith(bottom: 25),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 28,
              child: IconButton(
                icon: Image.asset(AppImages.icArrowBack),
                onPressed: () => Navigator.pop(context),
              ),
            ),
            Image.asset(
              AppImages.icStore_g,
              height: 38,
            ),
            const SizedBox(width: 28),
          ],
        ),
      ),
    );
  }
}
