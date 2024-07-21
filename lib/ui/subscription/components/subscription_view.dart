import 'package:flutter/material.dart';
import 'package:mou_business_app/helpers/translations.dart';
import 'package:mou_business_app/ui/subscription/components/subscription_app_bar.dart';
import 'package:mou_business_app/ui/subscription/components/subscription_bottom_bar.dart';
import 'package:mou_business_app/ui/subscription/subscription_viewmodel.dart';
import 'package:mou_business_app/ui/widgets/expanded_child_scroll_view.dart';
import 'package:mou_business_app/ui/widgets/loading_full_screen.dart';
import 'package:mou_business_app/utils/app_constants.dart';
import 'package:mou_business_app/utils/app_images.dart';
import 'package:mou_business_app/utils/app_languages.dart';
import 'package:provider/provider.dart';

class SubscriptionView extends StatelessWidget {
  const SubscriptionView({super.key});

  @override
  Widget build(BuildContext context) {
    final SubscriptionViewModel viewModel = context.read<SubscriptionViewModel>();
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFFF3F3F3),
            Color(0xFFC7C7C7),
          ],
        ),
      ),
      child: StreamBuilder<bool>(
        stream: viewModel.loadingSubject,
        builder: (context, snapshot) {
          final bool loading = snapshot.data ?? false;
          return Stack(
            children: [
              Scaffold(
                backgroundColor: Colors.transparent,
                appBar: SubscriptionAppBar(),
                body: ExpandedChildScrollView(
                  child: FutureBuilder<int>(
                    future: viewModel.totalMembers,
                    builder: (context, snapshot) {
                      final int totalMembers = snapshot.data ?? 0;
                      final bool overLimit = totalMembers >= AppConstants.LIMIT_MEMBERS;
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Expanded(flex: 100, child: const SizedBox(height: 16)),
                          Image.asset(AppImages.icSubscriptionBig, height: 135),
                          Expanded(flex: 40, child: const SizedBox(height: 16)),
                          Text(
                            overLimit
                                ? allTranslations.text(AppLanguages.youReachedYourFreeLimit)
                                : allTranslations
                                    .text(AppLanguages.youReachedYourFreeLimitForXXUsers)
                                    .replaceAll('##CURRENT##', totalMembers.toString())
                                    .replaceAll('##LIMIT##', AppConstants.LIMIT_MEMBERS.toString()),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 24,
                              color: Color(0xFF8D8C8C),
                            ),
                          ),
                          Expanded(flex: 68, child: const SizedBox(height: 16)),
                          if (overLimit)
                            Text(
                              allTranslations.text(AppLanguages.subscriptionDescriptions),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 16,
                                color: Color(0xFF8D8C8C),
                              ),
                            ),
                          Expanded(flex: 102, child: const SizedBox(height: 16)),
                        ],
                      );
                    },
                  ),
                ),
                bottomNavigationBar: SubscriptionBottomBar(),
              ),
              if (loading)
                Positioned.fill(
                  child: LoadingFullScreen(
                    loading: true,
                    backgroundColor: Colors.transparent,
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
