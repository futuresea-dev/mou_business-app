import 'dart:math';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:mou_business_app/constants/constants.dart';
import 'package:mou_business_app/core/models/event_count.dart';
import 'package:mou_business_app/ui/base/base_widget.dart';
import 'package:mou_business_app/ui/event/event_viewmodel.dart';
import 'package:mou_business_app/ui/event/events_tab/events_tab_view.dart';
import 'package:mou_business_app/ui/widgets/app_body.dart';
import 'package:mou_business_app/ui/widgets/app_content.dart';
import 'package:mou_business_app/ui/widgets/app_menu_bar.dart';
import 'package:mou_business_app/ui/widgets/get_box_offset.dart';
import 'package:mou_business_app/utils/app_colors.dart';
import 'package:mou_business_app/utils/app_images.dart';
import 'package:mou_business_app/utils/types/event_status.dart';
import 'package:provider/provider.dart';

class EventPage extends StatefulWidget {
  final int index;

  const EventPage({super.key, required this.index});

  @override
  _EventPageState createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> with TickerProviderStateMixin {
  late TabController _tabController;
  late AnimationController _animController;
  late EventViewModel _viewModel;
  final _displayedStatuses = EventStatus.values;
  List<Offset> tabOffsets = [];
  List<Size> tabSizes = [];
  int currentTab = 0;
  int previousTab = 0;

  @override
  void initState() {
    super.initState();
    currentTab = widget.index;
    _tabController = TabController(
      vsync: this,
      initialIndex: widget.index,
      length: _displayedStatuses.length,
    );

    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
      reverseDuration: const Duration(milliseconds: 300),
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _tabController.animation?.addListener(() {
        if (!_tabController.indexIsChanging) {
          _viewModel.onTabChanged(_tabController.index);
        } else {
          setState(() {
            currentTab = _tabController.index;
            previousTab = _tabController.previousIndex;
          });
          _animController.forward().then((_) => _animController.reverse());
        }
      });
    });
  }

  @override
  void dispose() {
    _animController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseWidget<EventViewModel>(
      viewModel: EventViewModel(Provider.of(context)),
      onViewModelReady: (viewModel) => _viewModel = viewModel,
      builder: (context, viewModel, child) {
        return Scaffold(
          body: AppBody(
            child: AppContent(
              menuBar: const AppMenuBar(),
              headerBuilder: (_) => Stack(
                children: [
                  Container(
                    height: Constants.appBarHeight,
                    margin: const EdgeInsets.symmetric(horizontal: 40),
                    child: TabBar(
                      indicatorColor: Colors.transparent,
                      controller: _tabController,
                      labelPadding: EdgeInsets.zero,
                      indicatorPadding: const EdgeInsets.all(5),
                      padding: const EdgeInsets.only(top: 18),
                      tabs: _displayedStatuses
                          .mapIndexed((index, eventStatus) => GetBoxOffset(
                                child: _buildTabs(eventStatus, viewModel),
                                offset: (offset, size) {
                                  setState(() {
                                    tabOffsets.add(offset);
                                    tabSizes.add(size);
                                  });
                                },
                              ))
                          .toList(),
                      onTap: (index) {
                        _viewModel.onTabChanged(index);
                      },
                    ),
                  ),
                  if (tabOffsets.isNotEmpty)
                    AnimatedBuilder(
                      animation: _animController,
                      builder: (_, __) {
                        Widget child = Container(
                          width: _animController.value *
                                  (tabOffsets[currentTab].dx +
                                          tabSizes[currentTab].width / 2 -
                                          tabOffsets[previousTab].dx -
                                          tabSizes[previousTab].width / 2)
                                      .abs() +
                              8,
                          decoration: BoxDecoration(
                            color: AppColors.normal.withOpacity(.1),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          alignment: currentTab > previousTab
                              ? Alignment.centerLeft
                              : Alignment.centerLeft,
                          child: Image.asset(AppImages.icActive),
                        );
                        return AnimatedPositioned(
                          top: tabOffsets[currentTab].dy + 32 + 5,
                          height: 8,
                          left: tabOffsets[currentTab > previousTab ? previousTab : currentTab].dx +
                              tabSizes[currentTab].width / 2 -
                              4 +
                              (currentTab > previousTab
                                  ? (tabOffsets[currentTab].dx +
                                          tabSizes[currentTab].width / 2 -
                                          tabOffsets[previousTab].dx -
                                          tabSizes[previousTab].width / 2)
                                      .abs()
                                  : 0),
                          duration: const Duration(milliseconds: 300),
                          child: currentTab > previousTab
                              ? Transform(
                                  transform: Matrix4.rotationY(pi),
                                  origin: Offset(4, 0),
                                  child: child,
                                )
                              : child,
                        );
                      },
                    ),
                ],
              ),
              childBuilder: (_) => _buildContent(),
            ),
          ),
        );
      },
    );
  }

  Widget _buildTabs(EventStatus status, EventViewModel viewModel) {
    return StreamBuilder<EventCount?>(
      stream: viewModel.eventCountSubject,
      builder: (context, snapshot) {
        EventCount? eventCount = snapshot.data;
        int count = 0;
        switch (status) {
          case EventStatus.WAITING:
            count = eventCount?.waitingToConfirm ?? 0;
            break;
          case EventStatus.DENIED:
            count = eventCount?.denied ?? 0;
            break;
          case EventStatus.CONFIRMED:
            count = eventCount?.confirmed ?? 0;
            break;
        }

        return Tab(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Image.asset(
                        status.index == currentTab
                            ? status.activeIconAsset
                            : status.inactiveIconAsset,
                        color: status.index == currentTab ? null : AppColors.textCalendarOutSide,
                        fit: BoxFit.cover,
                        height: 32,
                      ),
                      if (count > 0)
                        Positioned(
                          top: -4,
                          right: -18,
                          child: Container(
                            decoration: BoxDecoration(
                              color: status.color,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            width: 15,
                            height: 15,
                            alignment: Alignment.center,
                            padding: const EdgeInsets.all(1),
                            child: Text(
                              '${count > 99 ? 99 : count}',
                              style: TextStyle(fontSize: 10, color: Colors.white),
                            ),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 13),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildContent() {
    return ScrollConfiguration(
      behavior: const ScrollBehavior(),
      child: TabBarView(
        controller: _tabController,
        children: _displayedStatuses
            .map((e) => EventsTabView(
                  key: Key(e.name),
                  eventStatus: e,
                  onRefreshParent: (filterTypes) => _viewModel.fetchEventCount(filterTypes),
                ))
            .toList(),
      ),
    );
  }
}

class EventArguments {
  final int index;
  final String inactiveIcon;
  final String activeIcon;
  final Color color;

  const EventArguments({
    required this.index,
    required this.inactiveIcon,
    required this.activeIcon,
    required this.color,
  });
}
