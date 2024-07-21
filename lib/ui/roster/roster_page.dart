import 'package:animation_list/animation_list.dart';
import 'package:flutter/material.dart';
import 'package:mou_business_app/core/databases/app_database.dart';
import 'package:mou_business_app/core/databases/dao/roster_dao.dart';
import 'package:mou_business_app/helpers/app_icons.dart';
import 'package:mou_business_app/helpers/routers.dart';
import 'package:mou_business_app/helpers/translations.dart';
import 'package:mou_business_app/ui/base/base_widget.dart';
import 'package:mou_business_app/ui/roster/components/roster_item.dart';
import 'package:mou_business_app/ui/roster/roster_viewmodel.dart';
import 'package:mou_business_app/ui/widgets/app_body.dart';
import 'package:mou_business_app/ui/widgets/app_content.dart';
import 'package:mou_business_app/ui/widgets/app_loading.dart';
import 'package:mou_business_app/ui/widgets/app_menu_bar.dart';
import 'package:mou_business_app/ui/widgets/calendar.dart';
import 'package:mou_business_app/ui/widgets/load_more_builder.dart';
import 'package:mou_business_app/utils/app_colors.dart';
import 'package:mou_business_app/utils/app_constants.dart';
import 'package:mou_business_app/utils/app_font_size.dart';
import 'package:mou_business_app/utils/app_images.dart';
import 'package:mou_business_app/utils/app_languages.dart';
import 'package:mou_business_app/utils/app_utils.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class RosterPage extends StatelessWidget {
  final DateTime? selectedDay;

  const RosterPage({super.key, this.selectedDay});

  @override
  Widget build(BuildContext context) {
    return BaseWidget<RosterViewModel>(
      viewModel: RosterViewModel(Provider.of(context)),
      onViewModelReady: (viewModel) => viewModel..init(selectedDay),
      builder: (context, viewModel, child) {
        return Scaffold(
          key: viewModel.scaffoldKey,
          backgroundColor: Colors.white,
          body: AppBody(
            child: AppContent(
              headerBuilder: (hasInternet) => _buildHeader(viewModel, context, hasInternet),
              childBuilder: (_) => _buildContent(viewModel),
              menuBar: const AppMenuBar(),
            ),
          ),
        );
      },
    );
  }

  Widget _buildHeader(RosterViewModel viewModel, BuildContext context, bool hasInternet) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        _buildAppBar(viewModel, context),
        _buildCalendar(viewModel),
        _buildButtonAdd(context, hasInternet),
      ],
    );
  }

  Widget _buildAppBar(RosterViewModel viewModel, BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      automaticallyImplyLeading: false,
      titleSpacing: 0,
      centerTitle: false,
      title: Stack(
        children: [
          InkWell(
            borderRadius: const BorderRadius.horizontal(right: Radius.circular(50)),
            onTap: viewModel.onBackPressed,
            child: Container(
              height: 100,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Icon(AppIcons.previous, color: AppColors.normal, size: 15),
                  const SizedBox(width: 12),
                  StreamBuilder<DateTime>(
                    stream: viewModel.focusedDaySubject,
                    builder: (context, snapshot) {
                      final focusedDay = snapshot.data ?? DateTime.now();
                      return Text(
                        AppUtils.getMonth(focusedDay, maxLength: 3).toUpperCase(),
                        style: TextStyle(
                          color: AppColors.normal,
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: 100,
            width: MediaQuery.sizeOf(context).width,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  allTranslations.text(AppLanguages.roster).toUpperCase(),
                  style: TextStyle(
                    fontSize: AppFontSize.textTitlePage,
                    color: Colors.black,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCalendar(RosterViewModel viewModel) {
    return StreamBuilder<DateTime>(
      stream: viewModel.focusedDaySubject,
      builder: (_, snapshot) {
        DateTime currentDay = snapshot.data ?? DateTime.now();
        return StreamBuilder<Map<DateTime, List<dynamic>>>(
          stream: viewModel.rostersSubject,
          builder: (_, eventSnapshot) {
            final events = eventSnapshot.data ?? {};
            return Calendar(
              headerVisible: false,
              isRoster: true,
              focusedDay: currentDay,
              calendarFormat: CalendarFormat.week,
              availableGestures: AvailableGestures.horizontalSwipe,
              onPageChanged: (focusedDay) {
                viewModel.focusedDaySubject.add(focusedDay);
                viewModel.onRefresh();
              },
              onDaySelected: (selectedDay, _) {
                viewModel.onDaySelected(selectedDay);
              },
              events: events,
            );
          },
        );
      },
    );
  }

  Widget _buildButtonAdd(BuildContext context, bool hasInternet) {
    return Padding(
      padding: const EdgeInsets.only(right: 45),
      child: InkWell(
        onTap: hasInternet ? () => Navigator.pushNamed(context, Routers.ADD_ROSTER) : null,
        child: Container(
          height: 40,
          width: 40,
          child: hasInternet ? Image.asset(AppImages.icCircleAdd) : null,
        ),
      ),
    );
  }

  Widget _buildContent(RosterViewModel viewModel) {
    return Container(
      color: const Color(0xfff4f7fa),
      constraints: const BoxConstraints.expand(),
      child: StreamBuilder<DateTime>(
        stream: viewModel.focusedDaySubject,
        builder: (context, daySnapshot) {
          final rosterDao = Provider.of<RosterDao>(context);
          DateTime? date = AppUtils.clearTime(daySnapshot.data);

          return date == null
              ? const AppLoadingIndicator()
              : LoadMoreBuilder<Roster>(
                  viewModel: viewModel,
                  stream: rosterDao.watchRostersInDate(date),
                  builder: (context, rosterSnapshot, isLoadMore) {
                    List<Roster> rosters = rosterSnapshot.data ?? [];

                    return RefreshIndicator(
                      color: AppColors.normal,
                      backgroundColor: Colors.white,
                      onRefresh: viewModel.onRefresh,
                      child: rosters.isNotEmpty
                          ? ScrollConfiguration(
                              behavior: ScrollBehavior(),
                              child: AnimationList(
                                duration: AppConstants.ANIMATION_LIST_DURATION,
                                reBounceDepth: AppConstants.ANIMATION_LIST_RE_BOUNCE_DEPTH,
                                physics: const AlwaysScrollableScrollPhysics(),
                                children: [
                                  ...rosters
                                      .map((e) => RosterItem(roster: e, viewModel: viewModel))
                                      .toList(),
                                  if (isLoadMore) AppLoadingIndicator(),
                                ],
                              ),
                            )
                          : Center(
                              child: Text(
                                'No Rosters',
                                style: TextStyle(
                                  fontSize: AppFontSize.nameList,
                                  color: AppColors.normal,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                    );
                  },
                );
        },
      ),
    );
  }
}
