import 'package:flutter/material.dart';
import 'package:mou_business_app/ui/base/base_widget.dart';
import 'package:mou_business_app/ui/subscription/components/subscription_view.dart';
import 'package:mou_business_app/ui/subscription/subscription_viewmodel.dart';
import 'package:provider/provider.dart';

class SubscriptionPage extends StatelessWidget {
  final String? productId;

  const SubscriptionPage({super.key, this.productId});

  @override
  Widget build(BuildContext context) {
    return BaseWidget<SubscriptionViewModel>(
      viewModel: SubscriptionViewModel(
        Provider.of(context),
        Provider.of(context),
        Provider.of(context),
        productId,
      ),
      onViewModelReady: (viewModel) => viewModel.fetchProducts(),
      builder: (context, viewModel, child) => SubscriptionView(),
    );
  }
}
