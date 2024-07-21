import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mou_business_app/helpers/app_icons.dart';
import 'package:mou_business_app/utils/app_colors.dart';
import 'package:mou_business_app/utils/app_images.dart';
import 'package:mou_business_app/utils/app_utils.dart';
import 'package:table_calendar/table_calendar.dart';

class Calendar<T> extends StatelessWidget {
  final DateTime? focusedDay;
  final OnDaySelected? onDaySelected;
  final Function(DateTime focusedDay)? onPageChanged;
  final bool? headerVisible;
  final HeaderStyle? headerStyle;
  final AvailableGestures? availableGestures;
  final Map<DateTime, List<T>>? events;
  final CalendarFormat calendarFormat;
  final bool isRoster;

  final _textTitle = TextStyle(
    color: AppColors.normal,
    fontSize: 18,
    fontWeight: FontWeight.w500,
  );
  final _textCalendar = TextStyle(
    color: const Color(0xFF787878),
    fontSize: 17,
    fontWeight: FontWeight.w500,
  );

  Calendar({
    super.key,
    this.focusedDay,
    this.onDaySelected,
    this.onPageChanged,
    this.headerVisible,
    this.headerStyle,
    this.events,
    this.availableGestures,
    this.calendarFormat = CalendarFormat.month,
    this.isRoster = false,
  });

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      firstDay: DateTime(1950),
      focusedDay: focusedDay ?? DateTime.now(),
      lastDay: DateTime(2070),
      daysOfWeekHeight: 30,
      calendarStyle: CalendarStyle(
        isTodayHighlighted: false,
        defaultTextStyle: _textCalendar,
        weekendTextStyle: _textCalendar,
      ),
      daysOfWeekStyle: DaysOfWeekStyle(
        weekdayStyle: _textTitle,
        weekendStyle: _textTitle,
        dowTextFormatter: (dateTime, _) =>
            "${DateFormat('E').format(dateTime)}".split("")[0].toUpperCase(),
      ),
      headerVisible: headerVisible ?? true,
      headerStyle: headerStyle ??
          HeaderStyle(
            titleCentered: true,
            titleTextStyle: _textTitle,
            formatButtonVisible: false,
            leftChevronIcon: Icon(
              AppIcons.previous,
              color: AppColors.header,
              size: 16,
            ),
            rightChevronIcon: Icon(
              AppIcons.next,
              color: AppColors.header,
              size: 16,
            ),
            titleTextFormatter: (dateTime, _) =>
                "${DateFormat('MMMM').format(dateTime)}".toUpperCase(),
          ),
      calendarBuilders: CalendarBuilders(
        defaultBuilder: (context, day, focusedDay) => const SizedBox(),
        markerBuilder: (context, day, events) {
          DateTime now = DateTime.now();
          bool isToday = day.year == now.year && day.month == now.month && day.day == now.day;
          bool isOutsideDay =
              calendarFormat == CalendarFormat.month && day.month != focusedDay?.month;
          bool isFocusDay = focusedDay != null &&
              DateTime(day.year, day.month, day.day) ==
                  DateTime(focusedDay!.year, focusedDay!.month, focusedDay!.day);
          Color dayColor = events.isNotEmpty
              ? isRoster
                  ? (events[0] == 0 ? AppColors.normal : AppColors.red)
                  : AppUtils.convertToColor(events.first.toString())
              : isOutsideDay
                  ? AppColors.textPlaceHolder
                  : const Color(0xFF787878);

          return Center(
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Container(
                  height: 38,
                  width: 38,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: isFocusDay ? AppColors.header.withOpacity(.3) : null,
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    '${day.day}',
                    style: _textCalendar.copyWith(
                      color: dayColor,
                      fontWeight: events.isNotEmpty
                          ? FontWeight.bold
                          : isOutsideDay
                              ? FontWeight.w300
                              : FontWeight.w400,
                    ),
                  ),
                ),
                if (isToday)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 3),
                    child: Image.asset(
                      AppImages.icActive,
                      width: 5,
                      fit: BoxFit.cover,
                    ),
                  ),
              ],
            ),
          );
        },
        outsideBuilder: (context, day, focusedDay) => const SizedBox(),
      ),
      calendarFormat: calendarFormat,
      availableGestures: availableGestures ?? AvailableGestures.horizontalSwipe,
      onDaySelected: onDaySelected,
      onPageChanged: onPageChanged,
      eventLoader: (day) {
        if (events?.isNotEmpty ?? false) {
          DateTime date = DateTime(day.year, day.month, day.day);
          final a = events![date] ?? [];
          return a;
        }
        return [];
      },
    );
  }
}
