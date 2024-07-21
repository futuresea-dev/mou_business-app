import 'package:flutter/material.dart';
import 'package:mou_business_app/utils/app_colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

const double _dotSize = 10;
const double _dotMargin = 8;

class OnboardingSlidesIndicator extends StatelessWidget {
  final PageController _pageController;
  final int totalPage;

  const OnboardingSlidesIndicator(this._pageController, {super.key, required this.totalPage});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        alignment: Alignment.center,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(totalPage, (index) => _Dot()),
          ),
          SmoothPageIndicator(
            controller: _pageController,
            count: totalPage,
            effect: WormEffect(
              dotHeight: _dotSize,
              dotWidth: _dotSize,
              type: WormType.underground,
              dotColor: Colors.transparent,
              activeDotColor: AppColors.onboardingDot,
              spacing: _dotMargin,
              paintStyle: PaintingStyle.stroke,
            ),
          ),
        ],
      ),
    );
  }
}

class _Dot extends StatelessWidget {
  const _Dot();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: _dotSize,
      height: _dotSize,
      margin: const EdgeInsets.symmetric(horizontal: _dotMargin / 2),
      decoration: ShapeDecoration(
        shape: OvalBorder(side: BorderSide(color: AppColors.onboardingDot)),
      ),
    );
  }
}
