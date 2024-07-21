import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

typedef FilterIcon = (String activeIcon, String inactiveIcon);

class FilterButtonContent extends StatelessWidget {
  final List<FilterIcon> iconAssets;
  final List<int> selectedIndexes;
  final ValueSetter<int> onFilterOptionPressed;
  final Size size;

  const FilterButtonContent({
    super.key,
    required this.iconAssets,
    this.selectedIndexes = const [],
    required this.onFilterOptionPressed,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size.height,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        children: iconAssets.mapIndexed((index, e) {
          final isSelected = selectedIndexes.contains(index);
          return GestureDetector(
            onTap: () => onFilterOptionPressed(index),
            child: Image.asset(isSelected ? e.$1 : e.$2, fit: BoxFit.fitHeight),
          );
        }).toList(),
      ),
    );
  }
}
