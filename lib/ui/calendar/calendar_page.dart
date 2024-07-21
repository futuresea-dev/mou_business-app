import 'package:animation_list/animation_list.dart';
import 'package:flutter/material.dart' hide MenuBar;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mou_business_app/core/databases/app_database.dart';
import 'package:mou_business_app/core/databases/dao/event_dao.dart';
import 'package:mou_business_app/helpers/app_icons.dart';
import 'package:mou_business_app/helpers/translations.dart';
import 'package:mou_business_app/ui/base/base_widget.dart';
import 'package:mou_business_app/ui/calendar/calendar_viewmodel.dart';
import 'package:mou_business_app/ui/home/notifications_overlay.dart';
import 'package:mou_business_app/ui/widgets/app_body.dart';
import 'package:mou_business_app/ui/widgets/app_content.dart';
import 'package:mou_business_app/ui/widgets/app_loading.dart';
import 'package:mou_business_app/ui/widgets/app_menu_bar.dart';
import 'package:mou_business_app/ui/widgets/calendar.dart';
import 'package:mou_business_app/ui/widgets/item_layout/item_layout.dart';
import 'package:mou_business_app/ui/widgets/load_more_builder.dart';
import 'package:mou_business_app/utils/app_colors.dart';
import 'package:mou_business_app/utils/app_constants.dart';
import 'package:mou_business_app/utils/app_font_size.dart';
import 'package:mou_business_app/utils/app_images.dart';
import 'package:mou_business_app/utils/app_languages.dart';
import 'package:mou_business_app/utils/app_shared.dart';
import 'package:mou_business_app/utils/app_utils.dart';
import 'package:mou_business_app/utils/types/event_task_type.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarPage extends StatefulWidget {
  final DateTime? selectedDay;

  CalendarPage({super.key, this.selectedDay});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> with TickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    const Duration duration = Duration(milliseconds: 200);
    _animationController = AnimationController(
      vsync: this,
      duration: duration,
      reverseDuration: duration,
    );
  }

  void _onHideOverlay() => _animationController.reverse();

  void _showOverlay() => _animationController.forward();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: BaseWidget<CalendarViewModel>(
        viewModel: CalendarViewModel(Provider.of(context), Provider.of(context)),
        onViewModelReady: (viewModel) => viewModel..init(widget.selectedDay),
        builder: (context, viewModel, child) {
          return Scaffold(
            key: viewModel.scaffoldKey,
            body: AppBody(
              statusBarColor: Colors.transparent,
              child: AppContent(
                menuBar: AppMenuBar(onCloseBar: _onHideOverlay),
                headerBuilder: (_) => _buildHeader(viewModel),
                childBuilder: (_) => _buildContent(viewModel),
                overlay: _buildNotifications(viewModel),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildHeader(CalendarViewModel viewModel) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        _buildAppBar(viewModel),
        _buildCalendar(viewModel),
        _buildButtonAdd(viewModel),
      ],
    );
  }

  Widget _buildAppBar(CalendarViewModel viewModel, {bool isOverlay = false}) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      bottomOpacity: 0,
      scrolledUnderElevation: 0,
      automaticallyImplyLeading: false,
      titleSpacing: 0,
      centerTitle: false,
      title: isOverlay
          ? const SizedBox()
          : InkWell(
              borderRadius: const BorderRadius.horizontal(right: Radius.circular(50)),
              onTap: viewModel.onBackPressed,
              child: Container(
                height: 100,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Icon(AppIcons.previous, color: AppColors.normal, size: 15),
                    const SizedBox(width: 10),
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
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: IconButton(
            onPressed: isOverlay ? null : _showOverlay,
            icon: StreamBuilder<int?>(
              stream: AppShared.watchCountNotification(),
              builder: (context, snapshot) {
                final int count = snapshot.data ?? 0;
                return isOverlay
                    ? SvgPicture.asset(
                        AppImages.icOpenNotification,
                        width: 22,
                      )
                    : Image.asset(
                        count > 0 ? AppImages.icNewNotification : AppImages.icEmptyNotification,
                        width: 22,
                        fit: BoxFit.contain,
                      );
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCalendar(CalendarViewModel viewModel) {
    return StreamBuilder<DateTime>(
      stream: viewModel.focusedDaySubject,
      builder: (_, snapshot) {
        DateTime currentDay = snapshot.data ?? DateTime.now();
        return StreamBuilder<Map<DateTime, List<dynamic>>>(
          stream: viewModel.eventsSubject,
          builder: (_, eventSnapshot) {
            final events = eventSnapshot.data ?? {};
            return Calendar(
              headerVisible: false,
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

  Widget _buildButtonAdd(CalendarViewModel viewModel) {
    return const SizedBox(height: 40);
  }

  Widget _buildContent(CalendarViewModel viewModel) {
    return GestureDetector(
      onHorizontalDragEnd: (DragEndDetails details) {
        DateTime focusedDay = viewModel.focusedDaySubject.value;
        double edge = details.primaryVelocity ?? 0;
        Duration oneDay = const Duration(days: 1);
        if (edge > 0) {
          viewModel.onDaySelected(focusedDay.subtract(oneDay));
        } else if (edge < 0) {
          viewModel.onDaySelected(focusedDay.add(oneDay));
        }
      },
      behavior: HitTestBehavior.opaque,
      child: StreamBuilder<DateTime>(
        stream: viewModel.focusedDaySubject,
        builder: (context, daySnapshot) {
          final focusedDay = daySnapshot.data;
          final eventDao = Provider.of<EventDao>(context);
          final selected = AppUtils.clearTime(focusedDay) ?? DateTime.now();

          return LoadMoreBuilder<Event>(
            viewModel: viewModel,
            stream: eventDao.watchHomeEventsByDate(selected),
            builder: (context, eventSnapshot, isLoadMore) {
              List<Event> events = eventSnapshot.data ?? [];
              events.removeWhere((e) => e.type == null || e.type == EventTaskType.EVENT);

              return RefreshIndicator(
                onRefresh: viewModel.onRefresh,
                child: events.isNotEmpty
                    ? ScrollConfiguration(
                        behavior: const ScrollBehavior(),
                        child: AnimationList(
                          duration: AppConstants.ANIMATION_LIST_DURATION,
                          reBounceDepth: AppConstants.ANIMATION_LIST_RE_BOUNCE_DEPTH,
                          padding: const EdgeInsets.fromLTRB(14, 10, 18, 24),
                          children: [
                            ...events.map((e) => _buildItem(e, context, viewModel)).toList(),
                            if (isLoadMore) AppLoadingIndicator(),
                          ],
                        ),
                      )
                    : Center(
                        child: Text(
                          allTranslations.text(AppLanguages.noWorkForToday),
                          style: TextStyle(
                            fontSize: AppFontSize.textButton,
                            color: AppColors.normal,
                            fontWeight: FontWeight.w500,
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

  Widget _buildItem(Event event, BuildContext context, CalendarViewModel viewModel) {
    final EventTaskType? type = event.type;
    if (type == null) return const SizedBox();
    switch (type) {
      case EventTaskType.EVENT:
        return const SizedBox();
      case EventTaskType.PROJECT_TASK:
        return _buildProjectItem(event, context, viewModel);
      case EventTaskType.TASK:
        return _buildTaskItem(event, context, viewModel);
      case EventTaskType.ROSTER:
        return _buildRosterItem(event, context, viewModel);
    }
  }

  Widget _buildProjectItem(Event event, BuildContext context, CalendarViewModel viewModel) {
    return ProjectItem(
      event: event,
      eventRepository: Provider.of(context),
      showSnackBar: viewModel.showSnackBar,
      onRefreshList: viewModel.onRefresh,
    );
  }

  Widget _buildTaskItem(Event event, BuildContext context, CalendarViewModel viewModel) {
    return TaskItem(
      event: event,
      repository: Provider.of(context),
      showSnackBar: viewModel.showSnackBar,
      onRefreshList: viewModel.onRefresh,
      showDateLabel: false,
    );
  }

  Widget _buildRosterItem(Event event, BuildContext context, CalendarViewModel viewModel) {
    return RosterItem(
      event: event,
      repository: Provider.of(context),
      showSnackBar: viewModel.showSnackBar,
      onRefreshList: viewModel.onRefresh,
      showDateLabel: false,
    );
  }

  Widget _buildNotifications(CalendarViewModel viewModel) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        final double scale = _animationController.value;
        return NotificationsOverlay(
          viewModel: viewModel,
          appBar: _buildAppBar(viewModel, isOverlay: scale > 0),
          onHideOverlay: _onHideOverlay,
          scale: scale,
        );
      },
    );
  }
}
