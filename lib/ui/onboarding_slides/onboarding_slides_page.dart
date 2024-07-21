import 'package:flutter/material.dart';
import 'package:mou_business_app/helpers/routers.dart';
import 'package:mou_business_app/helpers/translations.dart';
import 'package:mou_business_app/ui/onboarding_slides/components/onboarding_slide_1.dart';
import 'package:mou_business_app/ui/onboarding_slides/components/onboarding_slide_2.dart';
import 'package:mou_business_app/ui/onboarding_slides/components/onboarding_slide_3.dart';
import 'package:mou_business_app/ui/onboarding_slides/components/onboarding_slide_4.dart';
import 'package:mou_business_app/ui/onboarding_slides/components/onboarding_slide_5.dart';
import 'package:mou_business_app/ui/onboarding_slides/components/onboarding_slides_indicator.dart';
import 'package:mou_business_app/utils/app_languages.dart';

class OnboardingSlidesPage extends StatefulWidget {
  const OnboardingSlidesPage({super.key});

  @override
  State<OnboardingSlidesPage> createState() => _OnboardingSlidesPageState();
}

class _OnboardingSlidesPageState extends State<OnboardingSlidesPage> {
  final _slides = [
    OnboardingSlide1(),
    OnboardingSlide2(),
    OnboardingSlide3(),
    OnboardingSlide4(),
  ];
  final _pageController = PageController();
  int _currentPage = 0;

  bool get isLastPage => _currentPage == _slides.length - 1;

  @override
  void initState() {
    super.initState();
    _slides.add(
      OnboardingSlide5(onAddEventPressed: _onSkipPressed),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onNextSlide() {
    _pageController.nextPage(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeOut,
    );
  }

  void _onPageChanged(int index) => setState(() => _currentPage = index);

  Future<dynamic> _onSkipPressed() =>
      Navigator.pushNamedAndRemoveUntil(context, Routers.HOME, (route) => false, arguments: true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      resizeToAvoidBottomInset: false,
      body: Stack(
        alignment: Alignment.center,
        children: [
          PageView(
            controller: _pageController,
            children: _slides,
            onPageChanged: _onPageChanged,
          ),
          Positioned(
            bottom: 18,
            left: 22,
            right: 22,
            child: SafeArea(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  OnboardingSlidesIndicator(_pageController, totalPage: _slides.length),
                  if (!isLastPage)
                    Positioned(
                      left: 0,
                      child: _BottomButton(onPressed: _onSkipPressed, title: AppLanguages.skip),
                    ),
                  if (!isLastPage)
                    Positioned(
                      right: 0,
                      child:
                          _BottomButton(onPressed: () => _onNextSlide(), title: AppLanguages.next),
                    ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class _BottomButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;

  const _BottomButton({required this.title, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        margin: const EdgeInsets.all(8.0),
        color: Colors.transparent,
        child: Text(
          allTranslations.text(title).toLowerCase(),
          style: TextStyle(color: Color(0xFF545252), fontSize: 12),
        ),
      ),
    );
  }
}
