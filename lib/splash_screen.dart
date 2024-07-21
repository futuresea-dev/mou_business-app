import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:mou_business_app/ui/base/base_widget.dart';
import 'package:mou_business_app/ui/login/login_viewmodel.dart';
import 'package:mou_business_app/utils/app_colors.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  AnimationController? _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return BaseWidget<LoginViewModel>(
      viewModel: LoginViewModel(
        authRepository: Provider.of(context),
        service: Provider.of(context),
      ),
      builder: (context, viewModel, child) {
        return Scaffold(
          body: DecoratedBox(
            decoration: BoxDecoration(gradient: AppColors.bgGradient),
            child: Center(
              child: Lottie.asset(
                'assets/anim/splashscreen_m.json',
                controller: _controller,
                height: MediaQuery.sizeOf(context).height * 1,
                animate: true,
                onLoaded: (composition) {
                  _controller
                    ?..duration = composition.duration
                    ..forward().whenComplete(
                      () async => await viewModel.checkLogged(fromSplash: true),
                    );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
