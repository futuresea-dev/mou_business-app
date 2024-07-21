import 'package:flutter/material.dart';
import 'package:mou_business_app/helpers/translations.dart';
import 'package:mou_business_app/utils/app_colors.dart';
import 'package:mou_business_app/utils/app_images.dart';
import 'package:mou_business_app/utils/app_languages.dart';

class OnboardingSlide2 extends StatelessWidget {
  const OnboardingSlide2({super.key});

  String _text(String text) => allTranslations.text(text);

  TextStyle get _textStyle => TextStyle(color: Color(0xFF545252), fontSize: 14);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.onboardingBackground2,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const Spacer(flex: 37),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    _text(AppLanguages.letSStartOpeningTheSideMenu),
                    style: _textStyle,
                  ),
                  const SizedBox(width: 6),
                  Image.asset(AppImages.icMenuClosed, width: 45),
                ],
              ),
            ),
            const Spacer(flex: 17),
            Padding(
              padding: const EdgeInsets.only(left: 12, right: 8),
              child: Stack(
                alignment: Alignment.center,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: MediaQuery.sizeOf(context).height * .034),
                    child: Image.asset(AppImages.imgSlide_2),
                  ),
                  Positioned(
                    top: MediaQuery.sizeOf(context).height * .053,
                    right: 0,
                    child: SizedBox(
                      width: MediaQuery.sizeOf(context).width * .35,
                      child: Text(
                        _text(AppLanguages.thisIsYourCalendarPage),
                        style: _textStyle.copyWith(height: 1.5),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: MediaQuery.sizeOf(context).height * .2,
                    left: 16,
                    child: SizedBox(
                      width: MediaQuery.sizeOf(context).width * .45,
                      child: Text(
                        _text(AppLanguages.addPageWhereYouCan),
                        style: _textStyle.copyWith(height: 1.5),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 16,
                    child: SizedBox(
                      width: MediaQuery.sizeOf(context).width * .42,
                      child: Text(
                        _text(AppLanguages.hereYouCanSee),
                        style: _textStyle.copyWith(height: 1.5),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: MediaQuery.sizeOf(context).height * .073,
                    right: MediaQuery.sizeOf(context).width * .14,
                    child: Text(_text(AppLanguages.yourSettings), style: _textStyle),
                  ),
                ],
              ),
            ),
            const Spacer(flex: 50),
          ],
        ),
      ),
    );
  }
}
