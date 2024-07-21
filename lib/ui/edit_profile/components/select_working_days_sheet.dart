import 'package:flutter/material.dart';
import 'package:mou_business_app/utils/app_colors.dart';
import 'package:mou_business_app/utils/app_font_size.dart';
import 'package:mou_business_app/utils/types/app_types.dart';
import 'package:rxdart/rxdart.dart';

class SelectWorkingDaysSheet extends StatelessWidget {
  const SelectWorkingDaysSheet({
    super.key,
    required this.selectedWorkingDays,
  });

  final BehaviorSubject<List<WeekDay>> selectedWorkingDays;

  void onSelectDay(WeekDay day) {
    List<WeekDay> selectedDays = selectedWorkingDays.value;
    if (selectedDays.contains(day)) {
      selectedDays.remove(day);
    } else {
      selectedDays.add(day);
    }
    selectedWorkingDays.add(selectedDays);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<WeekDay>>(
      stream: selectedWorkingDays,
      builder: (context, snapshot) {
        List<WeekDay> selectedDays = snapshot.data ?? [];

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: List.generate(
              WeekDay.values.length,
              (index) {
                WeekDay day = WeekDay.values[index];
                bool isSelected = selectedDays.contains(day);

                return InkWell(
                  onTap: () => onSelectDay(day),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      day.name,
                      style: TextStyle(
                        fontSize: AppFontSize.textButton,
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                        color: AppColors.normal,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
