import 'package:animation_list/animation_list.dart';
import 'package:flutter/material.dart';
import 'package:mou_business_app/core/databases/app_database.dart';
import 'package:mou_business_app/core/databases/dao/event_dao.dart';
import 'package:mou_business_app/helpers/translations.dart';
import 'package:mou_business_app/ui/base/base_widget.dart';
import 'package:mou_business_app/ui/widgets/app_loading.dart';
import 'package:mou_business_app/ui/widgets/filters/filter_button.dart';
import 'package:mou_business_app/ui/widgets/filters/filter_button_content.dart';
import 'package:mou_business_app/ui/widgets/item_layout/item_layout.dart';
import 'package:mou_business_app/ui/widgets/load_more_builder.dart';
import 'package:mou_business_app/ui/work/work_tab/work_tab_viewmodel.dart';
import 'package:mou_business_app/utils/app_colors.dart';
import 'package:mou_business_app/utils/app_constants.dart';
import 'package:mou_business_app/utils/app_font_size.dart';
import 'package:mou_business_app/utils/app_languages.dart';
import 'package:mou_business_app/utils/types/event_task_type.dart';
import 'package:mou_business_app/utils/types/work_status.dart';
import 'package:provider/provider.dart';

const _onButtonSize = Size(160, 38);

class WorkTabView extends StatefulWidget {
  final WorkStatus workStatus;
  final ValueChanged<int> onExportPressed;

  const WorkTabView({
    super.key,
    required this.workStatus,
    required this.onExportPressed,
  });

  @override
  _WorkTabViewState createState() => _WorkTabViewState();
}

class _WorkTabViewState extends State<WorkTabView> with AutomaticKeepAliveClientMixin {
  late WorkTabViewModel _viewModel;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final EventDao eventDao = Provider.of(context);
    return BaseWidget<WorkTabViewModel>(
      viewModel: WorkTabViewModel(
        workStatus: widget.workStatus,
        eventRepository: Provider.of(context),
      ),
      onViewModelReady: (viewModel) => _viewModel = viewModel..onInit(),
      builder: (context, viewModel, child) => GestureDetector(
        onTap: () => viewModel.filterMenuVisibleSubject.add(false),
        behavior: HitTestBehavior.opaque,
        child: Container(
          constraints: const BoxConstraints.expand(),
          child: StreamBuilder<List<EventTaskType>>(
            stream: viewModel.unselectedFiltersSubject,
            initialData: [],
            builder: (context, snapshot) {
              final unselectedFilters = snapshot.data!;
              final selectedFilters = viewModel.selectedFilters.map((e) => e.name).toList();

              return Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 4, 24, 8),
                    child: StreamBuilder<bool>(
                      stream: _viewModel.filterMenuVisibleSubject,
                      initialData: false,
                      builder: (context, snapshot) {
                        return FilterButton(
                          onExpanded: _viewModel.onFilterButtonPressed,
                          expanded: snapshot.data!,
                          filterOptions: StreamBuilder<List<EventTaskType>>(
                            stream: _viewModel.unselectedFiltersSubject,
                            initialData: [],
                            builder: (context, snapshot) {
                              return FilterButtonContent(
                                iconAssets: EventTaskType.filterTypes
                                    .map((e) => (e.activeIcon, e.inactiveIcon))
                                    .toList(),
                                selectedIndexes:
                                    _viewModel.selectedFilters.map((e) => e.index).toList(),
                                onFilterOptionPressed: (index) => _viewModel
                                    .onFilterModePressed(EventTaskType.filterTypes[index]),
                                size: _onButtonSize,
                              );
                            },
                          ),
                        );
                      },
                    ),
                  ),
                  Expanded(
                    child: LoadMoreBuilder<Event>(
                      viewModel: viewModel,
                      stream: unselectedFilters.isNotEmpty
                          ? eventDao.watchWorksByTypeAndStatus(
                              widget.workStatus,
                              selectedFilters,
                            )
                          : eventDao.watchWorksByStatus(widget.workStatus),
                      builder: (context, snapshot, isLoadMore) {
                        List<Event> events = snapshot.data ?? [];

                        return RefreshIndicator(
                          color: AppColors.normal,
                          backgroundColor: Colors.white,
                          onRefresh: _viewModel.onRefresh,
                          child: events.isNotEmpty
                              ? ScrollConfiguration(
                                  behavior: ScrollBehavior(),
                                  child: AnimationList(
                                    duration: AppConstants.ANIMATION_LIST_DURATION,
                                    reBounceDepth: AppConstants.ANIMATION_LIST_RE_BOUNCE_DEPTH,
                                    padding: const EdgeInsets.fromLTRB(5, 0, 10, 24),
                                    children: [
                                      ...events.map((e) => _buildItem(e, context)).toList(),
                                      if (isLoadMore) AppLoadingIndicator(),
                                    ],
                                  ),
                                )
                              : Center(
                                  child: Text(
                                    allTranslations.text(AppLanguages.noData),
                                    style: TextStyle(
                                      fontSize: AppFontSize.textButton,
                                      color: AppColors.normal,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                        );
                      },
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildItem(Event event, BuildContext context) {
    final EventTaskType? type = event.type;
    if (type == null) return const SizedBox();
    switch (type) {
      case EventTaskType.EVENT:
        return const SizedBox();
      case EventTaskType.PROJECT_TASK:
        return _buildProjectItem(event, context);
      case EventTaskType.TASK:
        return _buildTaskItem(event, context);
      case EventTaskType.ROSTER:
        return _buildRosterItem(event, context);
    }
  }

  Widget _buildProjectItem(Event event, BuildContext context) {
    return ProjectItem(
      event: event,
      eventRepository: Provider.of(context),
      showSnackBar: _viewModel.showSnackBar,
      onRefreshList: _viewModel.onRefresh,
      showInWorkPage: true,
      onExportPressed: () => widget.onExportPressed(event.id),
    );
  }

  Widget _buildTaskItem(Event event, BuildContext context) {
    return TaskItem(
      event: event,
      repository: Provider.of(context),
      showSnackBar: _viewModel.showSnackBar,
      onRefreshList: _viewModel.onRefresh,
    );
  }

  Widget _buildRosterItem(Event event, BuildContext context) {
    return RosterItem(
      event: event,
      repository: Provider.of(context),
      showSnackBar: _viewModel.showSnackBar,
      onRefreshList: _viewModel.onRefresh,
    );
  }

  @override
  bool get wantKeepAlive => false;
}
