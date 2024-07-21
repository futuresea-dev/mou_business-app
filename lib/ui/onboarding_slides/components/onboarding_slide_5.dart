import 'package:flutter/material.dart';
import 'package:mou_business_app/helpers/translations.dart';
import 'package:mou_business_app/utils/app_colors.dart';
import 'package:mou_business_app/utils/app_images.dart';
import 'package:mou_business_app/utils/app_languages.dart';

class OnboardingSlide5 extends StatelessWidget {
  final VoidCallback onAddEventPressed;

  const OnboardingSlide5({super.key, required this.onAddEventPressed});

  TextStyle get _textStyle => TextStyle(color: Color(0xFF545252), fontSize: 14, height: 1.5);

  String _text(String text) => allTranslations.text(text);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.onboardingBackground5,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            top: 54,
            right: 18,
            child: Image.asset(AppImages.imgMouWhite, width: 75),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 42, top: 16, right: 64),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Spacer(flex: 110),
                Text(_text(AppLanguages.thanksForDownloadingTheMouApp), style: _textStyle),
                Spacer(flex: 29),
                Text(_text(AppLanguages.theLastThingToFinish), style: _textStyle),
                Spacer(flex: 32),
                IconButton(
                  onPressed: onAddEventPressed,
                  padding: const EdgeInsets.all(2),
                  constraints: const BoxConstraints(),
                  iconSize: 46,
                  icon: Image.asset(AppImages.icSlideAddEvent),
                ),
                Spacer(flex: 91),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
