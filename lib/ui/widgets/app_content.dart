import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:mou_business_app/core/services/wifi_service.dart';
import 'package:mou_business_app/helpers/translations.dart';
import 'package:mou_business_app/utils/app_colors.dart';
import 'package:mou_business_app/utils/app_images.dart';
import 'package:mou_business_app/utils/app_languages.dart';

class AppContent extends StatelessWidget {
  final Widget? menuBar;
  final Widget Function(bool hasInternet)? headerBuilder;
  final Widget Function(bool hasInternet) childBuilder;
  final ImageProvider? headerImage;
  final Widget? overlay;

  const AppContent({
    super.key,
    this.menuBar,
    this.headerBuilder,
    required this.childBuilder,
    this.headerImage,
    this.overlay,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ConnectivityResult>(
      stream: WifiService.wifiSubject,
      builder: (context, snapshot) {
        bool hasInternet = snapshot.hasData ? snapshot.data != ConnectivityResult.none : true;

        return DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.white, AppColors.bgColor, AppColors.bgColor2],
              stops: [0.1, 0.11, 1],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Stack(
            children: <Widget>[
              headerBuilder == null
                  ? childBuilder.call(hasInternet)
                  : Stack(
                      children: [
                        Column(
                          children: <Widget>[
                            Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  fit: BoxFit.fitWidth,
                                  alignment: FractionalOffset.bottomCenter,
                                  image: headerImage ?? AssetImage(AppImages.bgTopHeaderNew),
                                ),
                              ),
                              child: headerBuilder!.call(hasInternet),
                            ),
                            Expanded(
                              child: childBuilder.call(hasInternet),
                            ),
                          ],
                        ),
                        if (!hasInternet)
                          Positioned(
                            bottom: 0,
                            width: MediaQuery.of(context).size.width,
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                              color: AppColors.slidableRed.withOpacity(0.8),
                              child: Text(
                                allTranslations.text(AppLanguages.noInternet),
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                      ],
                    ),
              Positioned(
                right: 0,
                top: 0,
                bottom: 0,
                child: menuBar ?? const SizedBox(),
              ),
              Positioned.fill(child: overlay ?? const SizedBox()),
            ],
          ),
        );
      },
    );
  }
}
