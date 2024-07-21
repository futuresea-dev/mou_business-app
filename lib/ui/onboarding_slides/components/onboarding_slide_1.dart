import 'package:flutter/material.dart';
import 'package:mou_business_app/helpers/translations.dart';
import 'package:mou_business_app/utils/app_colors.dart';
import 'package:mou_business_app/utils/app_images.dart';
import 'package:mou_business_app/utils/app_languages.dart';

class OnboardingSlide1 extends StatelessWidget {
  const OnboardingSlide1({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.onboardingBackground1,
      padding: EdgeInsets.symmetric(horizontal: MediaQuery.sizeOf(context).width * .11),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            allTranslations.text(AppLanguages.welcomeTo),
            style: TextStyle(color: Color(0xFF545252), fontSize: 19),
          ),
          const SizedBox(height: 36),
          Image.asset(AppImages.imgMouSliver, width: 188),
          const SizedBox(height: 30),
          Text(
            allTranslations.text(AppLanguages.welcomeContent),
            style: TextStyle(color: Color(0xFF545252), fontSize: 14, height: 1.6),
          ),
        ],
      ),
    );
  }
}
