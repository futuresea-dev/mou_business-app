import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:mou_business_app/core/services/wifi_service.dart';
import 'package:mou_business_app/helpers/translations.dart';
import 'package:mou_business_app/ui/subscription/subscription_viewmodel.dart';
import 'package:mou_business_app/utils/app_images.dart';
import 'package:mou_business_app/utils/app_languages.dart';
import 'package:provider/provider.dart';

import '../../../utils/app_colors.dart';

class SubscriptionBottomBar extends StatelessWidget {
  const SubscriptionBottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    final SubscriptionViewModel viewModel = context.read();
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 35),
          Text(
            allTranslations.text(AppLanguages.users),
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: AppColors.normal,
            ),
          ),
          const SizedBox(height: 26),
          StreamBuilder<ConnectivityResult>(
            stream: WifiService.wifiSubject,
            builder: (context, snapshot) {
              bool hasInternet = snapshot.hasData ? snapshot.data != ConnectivityResult.none : true;
              return Opacity(
                opacity: hasInternet ? 1 : 0.2,
                child: GestureDetector(
                  onTap: hasInternet ? viewModel.onPurchase : null,
                  child: Image.asset(AppImages.btnActive, width: 60, height: 60),
                ),
              );
            },
          ),
          const SizedBox(height: 16),
          Text(
            allTranslations.text(AppLanguages.usDollar),
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 10,
              color: AppColors.normal,
            ),
          ),
          const SizedBox(height: 6),
          StreamBuilder<ConnectivityResult>(
            stream: WifiService.wifiSubject,
            builder: (context, snapshot) {
              bool hasInternet = snapshot.hasData ? snapshot.data != ConnectivityResult.none : true;
              return hasInternet
                  ? SizedBox()
                  : Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                      color: AppColors.slidableRed.withOpacity(0.8),
                      child: Text(
                        allTranslations.text(AppLanguages.noInternet),
                        style: TextStyle(color: Colors.white),
                      ),
                    );
            },
          ),
          SizedBox(height: MediaQuery.viewPaddingOf(context).bottom),
        ],
      ),
    );
  }
}
