import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mou_business_app/utils/app_images.dart';

class WidgetImageNetwork extends StatelessWidget {
  final String url;
  final double width;
  final double height;
  final BoxFit fit;
  final String? assetError;
  final BorderRadiusGeometry? borderRadius;
  final double radius;
  final Widget? errorBuilder;

  const WidgetImageNetwork({
    super.key,
    required this.url,
    this.fit = BoxFit.cover,
    this.borderRadius,
    this.height = 31,
    this.width = 50,
    this.radius = 5,
    this.assetError,
    this.errorBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.circular(radius),
      child: CachedNetworkImage(
        imageUrl: url,
        height: height,
        width: width,
        errorWidget: (context, url, error) =>
            errorBuilder ??
            Image.asset(
              AppImages.logo,
              height: height,
              width: width,
              fit: BoxFit.cover,
            ),
        fit: fit,
      ),
    );
  }
}
