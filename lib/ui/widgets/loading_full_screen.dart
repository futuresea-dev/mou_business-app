import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LoadingFullScreen extends StatelessWidget {
  final Widget? child;
  final bool? loading;
  final Color? backgroundColor;

  const LoadingFullScreen({
    super.key,
    this.child,
    this.loading,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => !(loading ?? false),
      child: Container(
        constraints: const BoxConstraints.expand(),
        color: backgroundColor ?? Colors.white,
        child: Stack(
          children: <Widget>[
            Container(
              constraints: const BoxConstraints.expand(),
              child: child,
            ),
            loading == true ? _buildLoading() : const SizedBox(),
          ],
        ),
      ),
    );
  }

  Widget _buildLoading() {
    return Container(
      constraints: const BoxConstraints.expand(),
      color: const Color(0x77ffffff),
      child: Center(
        child: LottieBuilder.asset(
          'assets/anim/loading.json',
          width: 350,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
