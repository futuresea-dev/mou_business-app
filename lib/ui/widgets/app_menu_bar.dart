import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:just_the_tooltip/just_the_tooltip.dart';
import 'package:mou_business_app/helpers/routers.dart';
import 'package:mou_business_app/ui/widgets/menu/other_icon.dart';
import 'package:mou_business_app/utils/app_colors.dart';
import 'package:mou_business_app/utils/app_images.dart';
import 'package:mou_business_app/utils/types/bubble_button_type.dart';

class AppMenuBar extends StatefulWidget {
  const AppMenuBar({super.key, this.onCloseBar});

  final VoidCallback? onCloseBar;

  @override
  _AppMenuBarState createState() => _AppMenuBarState();
}

class _AppMenuBarState extends State<AppMenuBar> {
  bool isShow = false;
  bool isShowOther = false;
  bool isShowKeyboard = false;
  bool isAds = false;
  final keyboardVisibilityController = KeyboardVisibilityController();

  @protected
  void initState() {
    super.initState();
    keyboardVisibilityController.onChange.listen((bool visible) {
      if (mounted) {
        setState(() {
          isShowKeyboard = visible;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return isShow ? _buildOpen() : _buildClose();
  }

  void _onBubbleButtonPressed(BubbleButtonType buttonType) {
    final destinationPage = switch (buttonType) {
      BubbleButtonType.events => Routers.EVENT,
      BubbleButtonType.calendar => Routers.CALENDAR,
      BubbleButtonType.projects => Routers.WORK,
      BubbleButtonType.addTask => Routers.HOME,
      BubbleButtonType.settings => Routers.SETTING,
      BubbleButtonType.employees => Routers.EMPLOYEE,
    };
    widget.onCloseBar?.call();
    if (destinationPage == Routers.HOME) {
      Navigator.popUntil(context, (router) => router.isFirst);
    } else if (destinationPage == Routers.CALENDAR) {
      Navigator.pushNamedAndRemoveUntil(context, Routers.CALENDAR, (router) => router.isFirst);
    } else {
      Navigator.pushNamed(context, destinationPage);
    }
    _onClosePressed();
  }

  _buildOpen() {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 1.5, sigmaY: 1.5),
      blendMode: BlendMode.srcOver,
      child: Row(
        children: <Widget>[
          if (isShow)
            GestureDetector(
              onTap: _onClosePressed,
              behavior: HitTestBehavior.opaque,
              child: SizedBox(
                width: MediaQuery.sizeOf(context).width - 60,
                height: MediaQuery.sizeOf(context).height,
                child: isShowOther
                    ? Stack(
                        alignment: Alignment.bottomRight,
                        children: BubbleButtonType.values
                            .map(
                              (e) => Positioned(
                                right: e.positionOffset.$1,
                                bottom: e.positionOffset.$2,
                                child: OtherIcon(
                                  img: e.icon,
                                  isEvents: e == BubbleButtonType.events,
                                  onTap: () => _onBubbleButtonPressed(e),
                                ),
                              ),
                            )
                            .toList(),
                      )
                    : const SizedBox(),
              ),
            ),
          Column(
            children: [
              Expanded(
                child: Container(
                  width: 60,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [
                        Color(0xFF838282),
                        Color(0xFFc8c8c8),
                      ],
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 6, right: 2),
                        child: SizedBox(
                          height: 185,
                          child: Image.asset(AppImages.icMenuBarLogo),
                        ),
                      ),
                      const Spacer(),
                      _buildOther(icon: AppImages.icMenuBarADS),
                      _buildOther(icon: AppImages.icMenuBarMall),
                      _buildOther(icon: AppImages.icMenuBarCommunity),
                      _buildOther(icon: AppImages.icMenuBarChat, isAds: true),
                      InkWell(
                        onTap: () {
                          setState(() {
                            isShowOther = !isShowOther;
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Image.asset(AppImages.icMenuBarBusiness),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                width: 60,
                height: 129,
                color: Colors.transparent,
                child: Stack(
                  alignment: Alignment.centerLeft,
                  fit: StackFit.expand,
                  children: <Widget>[
                    Image.asset(AppImages.bgCloseBar, fit: BoxFit.fitWidth),
                    Positioned(
                      top: 0,
                      bottom: 0,
                      left: 10,
                      child: InkWell(
                        onTap: _onClosePressed,
                        borderRadius: BorderRadius.circular(24),
                        child: Image.asset(
                          AppImages.icCloseBar,
                          width: 30,
                          fit: BoxFit.scaleDown,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  _buildOther({required String icon, bool isAds = false}) {
    return JustTheTooltip(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10).copyWith(bottom: 40),
        child: Image.asset(icon),
      ),
      triggerMode: TooltipTriggerMode.tap,
      margin: EdgeInsets.only(right: 130),
      backgroundColor: Colors.white,
      tailBaseWidth: 0,
      borderRadius: BorderRadius.circular(9),
      elevation: 3,
      offset: -150,
      content: isAds
          ? Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Text(
                'Coming soon',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: AppColors.normal,
                ),
              ),
            )
          : const SizedBox(),
    );
  }

  _buildClose() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        if (!isShowKeyboard)
          Container(
            transform: Matrix4.translationValues(1, 0, 0),
            padding: EdgeInsets.only(bottom: Platform.isIOS ? 26.0 : 16.0),
            child: Container(
              width: 50,
              height: 98,
              child: Stack(
                alignment: Alignment.centerRight,
                children: <Widget>[
                  Image.asset(AppImages.bgOpenBar),
                  Positioned(
                    right: 1,
                    bottom: 24,
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          isShow = !isShow;
                        });
                      },
                      borderRadius: BorderRadius.circular(22),
                      child: CircleAvatar(
                        radius: 23,
                        backgroundImage: AssetImage(AppImages.icOpenBar),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        Image.asset(
          AppImages.bgSidebarClose,
          height: double.infinity,
        ),
      ],
    );
  }

  void _onClosePressed() {
    setState(() {
      isShow = !isShow;
      isShowOther = false;
    });
  }
}
