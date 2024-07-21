import 'package:flutter/material.dart';
import 'package:mou_business_app/helpers/translations.dart';
import 'package:mou_business_app/ui/onboarding_slides/components/tutorial_item.dart';
import 'package:mou_business_app/utils/app_colors.dart';
import 'package:mou_business_app/utils/app_images.dart';
import 'package:mou_business_app/utils/app_languages.dart';

class OnboardingSlide4 extends StatelessWidget {
  const OnboardingSlide4({super.key});

  String _text(String text) => allTranslations.text(text);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.onboardingBackground4,
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const Spacer(flex: 24),
          Padding(
            padding: const EdgeInsets.only(left: 32),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Flexible(
                  child: Text(
                    _text(AppLanguages.inTheEventsYouCan),
                    style: TextStyle(color: Color(0xFF545252), fontSize: 14),
                  ),
                ),
                const SizedBox(width: 8),
                Image.asset(AppImages.icSlideWork, width: 42),
              ],
            ),
          ),
          const Spacer(flex: 16),
          TutorialItem(
            asset: AppImages.imgSlide_4_1,
            text: _text(AppLanguages.allTheRostersAndTasks),
          ),
          const Spacer(flex: 16),
          TutorialItem(
            asset: AppImages.imgSlide_4_2,
            text: _text(AppLanguages.ifTheRostersAndTasksAreDenied),
          ),
          const Spacer(flex: 16),
          TutorialItem(
            asset: AppImages.imgSlide_4_3,
            text: _text(AppLanguages.andTheRostersAndTasksAreAccepted),
          ),
          const Spacer(flex: 36),
        ],
      ),
    );
  }
}
