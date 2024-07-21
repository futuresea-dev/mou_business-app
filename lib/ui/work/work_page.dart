import 'dart:math';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:mou_business_app/constants/constants.dart';
import 'package:mou_business_app/ui/base/base_widget.dart';
import 'package:mou_business_app/ui/widgets/app_body.dart';
import 'package:mou_business_app/ui/widgets/app_content.dart';
import 'package:mou_business_app/ui/widgets/app_menu_bar.dart';
import 'package:mou_business_app/ui/widgets/get_box_offset.dart';
import 'package:mou_business_app/ui/widgets/loading_full_screen.dart';
import 'package:mou_business_app/ui/work/work_tab/work_tab_view.dart';
import 'package:mou_business_app/ui/work/work_viewmodel.dart';
import 'package:mou_business_app/utils/app_colors.dart';
import 'package:mou_business_app/utils/app_images.dart';
import 'package:mou_business_app/utils/types/work_status.dart';
import 'package:provider/provider.dart';

class WorkPage extends StatefulWidget {
  const WorkPage({super.key});

  @override
  _WorkPageState createState() => _WorkPageState();
}

class _WorkPageState extends State<WorkPage> with TickerProviderStateMixin {
  late TabController _tabController;
  late AnimationController _animController;
  late final WorkViewModel _viewModel;
  final _displayedStatuses = WorkStatus.values;
  List<Offset> tabOffsets = [];
  List<Size> tabSizes = [];
  int currentTab = 1;
  int previousTab = 1;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      initialIndex: 1,
      length: _displayedStatuses.length,
      vsync: this,
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
    return BaseWidget<WorkViewModel>(
      viewModel: WorkViewModel(Provider.of(context), Provider.of(context)),
      onViewModelReady: (viewModel) => _viewModel = viewModel..onInit(),
      builder: (context, viewModel, child) {
        return Stack(
          children: [
            Scaffold(
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
                              .mapIndexed((index, projectStatus) => GetBoxOffset(
                                    child: _buildTabs(projectStatus),
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
                              left: tabOffsets[currentTab > previousTab ? previousTab : currentTab]
                                      .dx +
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
            ),
            StreamBuilder<bool>(
              stream: _viewModel.loadingSubject,
              builder: (context, snapshot) {
                final bool loading = snapshot.data ?? false;
                return loading
                    ? LoadingFullScreen(
                        loading: true,
                        backgroundColor: Colors.transparent,
                      )
                    : SizedBox();
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildTabs(WorkStatus status) {
    return Tab(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                status.index == currentTab ? status.activeIconAsset : status.inactiveIconAsset,
                color: status.index == currentTab ? null : AppColors.textCalendarOutSide,
                fit: BoxFit.cover,
                height: 32,
              ),
              const SizedBox(height: 13),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContent() {
    return ScrollConfiguration(
      behavior: const ScrollBehavior(),
      child: TabBarView(
        controller: _tabController,
        children: WorkStatus.values
            .map((workStatus) => WorkTabView(
                  key: Key(workStatus.name),
                  workStatus: workStatus,
                  onExportPressed: _viewModel.onExportProject,
                ))
            .toList(),
      ),
    );
  }
}
