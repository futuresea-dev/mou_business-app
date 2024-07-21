import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mou_business_app/helpers/app_icons.dart';
import 'package:mou_business_app/ui/base/base_widget.dart';
import 'package:mou_business_app/ui/month_calendar/month_calendar_viewmodel.dart';
import 'package:mou_business_app/ui/widgets/app_body.dart';
import 'package:mou_business_app/ui/widgets/app_content.dart';
import 'package:mou_business_app/ui/widgets/calendar.dart';
import 'package:mou_business_app/ui/widgets/app_menu_bar.dart';
import 'package:mou_business_app/utils/app_colors.dart';
import 'package:mou_business_app/utils/app_utils.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class MonthCalendarPage extends StatelessWidget {
  final DateTime selectedDay;

  const MonthCalendarPage({super.key, required this.selectedDay});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppBody(
        child: BaseWidget<MonthCalendarViewModel>(
          viewModel: MonthCalendarViewModel(Provider.of(context)),
          onViewModelReady: (viewModel) => viewModel.init(selectedDay),
          builder: (context, viewModel, child) => AppContent(
            menuBar: const AppMenuBar(),
            headerBuilder: (_) => _buildHeader(viewModel),
            childBuilder: (_) => _buildContent(viewModel),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(MonthCalendarViewModel viewModel) {
    return StreamBuilder<DateTime>(
      stream: viewModel.focusedDaySubject,
      builder: (context, snapshot) {
        final focusedDay = snapshot.data ?? selectedDay;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SafeArea(
              child: Container(
                color: Colors.white,
                child: StreamBuilder<Map<DateTime, List<dynamic>>>(
                  stream: viewModel.eventsSubject,
                  builder: (context, eventSnapshot) {
                    final events = eventSnapshot.data ?? {};

                    return Calendar(
                      headerStyle: HeaderStyle(
                        titleTextStyle: TextStyle(
                          color: AppColors.normal,
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                        formatButtonVisible: false,
                        leftChevronIcon: Icon(
                          AppIcons.previous,
                          color: AppColors.normal,
                          size: 16,
                        ),
                        rightChevronIcon: Icon(
                          AppIcons.next,
                          color: AppColors.normal,
                          size: 16,
                        ),
                        titleCentered: true,
                        titleTextFormatter: (date, _) => AppUtils.getMonth(date).toUpperCase(),
                      ),
                      focusedDay: focusedDay,
                      onPageChanged: (focusedDay) {
                        viewModel.focusedDaySubject.add(focusedDay);
                        viewModel.fetchEvents();
                      },
                      onDaySelected: (selectedDay, _) => viewModel.onDaySelected(selectedDay),
                      events: events,
                    );
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(18, 8, 14, 29),
              child: Transform.rotate(
                angle: -pi / 60,
                child: Text(
                  focusedDay.year.toString().toUpperCase(),
                  style: TextStyle(
                    color: AppColors.normal,
                    fontSize: 30,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildContent(MonthCalendarViewModel viewModel) {
    return const SizedBox();
  }
}
