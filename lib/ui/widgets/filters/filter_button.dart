import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mou_business_app/utils/app_images.dart';

class FilterButton extends StatelessWidget {
  final bool expanded;
  final VoidCallback onExpanded;
  final Widget filterOptions;

  const FilterButton({
    super.key,
    this.expanded = false,
    required this.onExpanded,
    required this.filterOptions,
  });

  @override
  Widget build(BuildContext context) {
    const _offButtonSize = Size(35, 10);

    return GestureDetector(
      onTap: expanded ? null : onExpanded.call,
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 200),
        child: expanded
            ? filterOptions
            : Container(
                height: _offButtonSize.height,
                width: _offButtonSize.width,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(AppImages.imgFilterButton),
                  ),
                ),
                alignment: Alignment.center,
                child: SvgPicture.asset(AppImages.icFilter, width: 23),
              ),
      ),
    );
  }
}
