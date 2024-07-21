import 'package:flutter/material.dart' hide MenuBar;
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:mou_business_app/core/databases/app_database.dart';
import 'package:mou_business_app/helpers/translations.dart';
import 'package:mou_business_app/ui/add_project/add_child_task/add_child_task_view.dart';
import 'package:mou_business_app/ui/add_project/add_project_viewmodel.dart';
import 'package:mou_business_app/ui/add_project/components/widget_child_task.dart';
import 'package:mou_business_app/ui/base/base_widget.dart';
import 'package:mou_business_app/ui/widgets/app_body.dart';
import 'package:mou_business_app/ui/widgets/app_content.dart';
import 'package:mou_business_app/ui/widgets/app_header.dart';
import 'package:mou_business_app/ui/widgets/app_menu_bar.dart';
import 'package:mou_business_app/ui/widgets/bottom_sheet_custom.dart';
import 'package:mou_business_app/ui/widgets/employee_dialog/employee_dialog.dart';
import 'package:mou_business_app/ui/widgets/loading_full_screen.dart';
import 'package:mou_business_app/ui/widgets/word_counter_textfield.dart';
import 'package:mou_business_app/utils/app_colors.dart';
import 'package:mou_business_app/utils/app_constants.dart';
import 'package:mou_business_app/utils/app_font_size.dart';
import 'package:mou_business_app/utils/app_images.dart';
import 'package:mou_business_app/utils/app_languages.dart';
import 'package:mou_business_app/utils/app_utils.dart';
import 'package:provider/provider.dart';

class AddProjectPage extends StatefulWidget {
  final int? projectId;

  const AddProjectPage({this.projectId});

  @override
  State<AddProjectPage> createState() => _AddProjectPageState();
}

class _AddProjectPageState extends State<AddProjectPage> {
  late AddProjectViewModel _viewModel;
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseWidget<AddProjectViewModel>(
      viewModel: AddProjectViewModel(
        projectRepository: Provider.of(context),
        employeeDao: Provider.of(context),
        employeeRepository: Provider.of(context),
        projectId: widget.projectId ?? 0,
      ),
      onViewModelReady: (viewModel) {
        _viewModel = viewModel;
        _viewModel.initData();
      },
      builder: (context, _viewModel, child) => Scaffold(
        key: _viewModel.scaffoldKey,
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
            _viewModel.isTypingTitle = _viewModel.titleController.text.isNotEmpty;
            _viewModel.isTypingScope = _viewModel.scopeController.text.isNotEmpty;
            _viewModel.isTypingClient = _viewModel.clientController.text.isNotEmpty;
          },
          child: AppBody(
            child: StreamBuilder<bool>(
              stream: _viewModel.loadingSubject.stream,
              builder: (context, snapShot) {
                bool isLoading = snapShot.data ?? false;
                return LoadingFullScreen(
                  loading: isLoading,
                  child: AppContent(
                    headerBuilder: (hasInternet) => _buildHeader(context, hasInternet),
                    childBuilder: (hasInternet) => _buildBody(context, hasInternet),
                    menuBar: const AppMenuBar(),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, bool hasInternet) {
    return AppHeader(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(bottom: 25, left: 12),
            child: IconButton(
              icon: Image.asset(AppImages.icClose, width: 16),
              onPressed: _viewModel.goBack,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: Container(
              height: 65,
              alignment: Alignment.center,
              child: IconButton(
                icon: Hero(
                  tag: 'imageProject',
                  child: Image.asset(AppImages.icProjectHeader),
                ),
                iconSize: 50,
                padding: const EdgeInsets.only(bottom: 20),
                onPressed:
                    hasInternet ? () => AppUtils.openLink(AppConstants.projectScopeLink) : null,
              ),
            ),
          ),
          IconButton(
            iconSize: 50,
            onPressed: hasInternet ? _viewModel.createProject : null,
            icon: hasInternet
                ? Image.asset(
                    _viewModel.totalDeny > 0 ? AppImages.icReAccept : AppImages.icAccept,
                    width: 24,
                    fit: BoxFit.cover,
                  )
                : const SizedBox(height: 15),
            padding: const EdgeInsets.only(bottom: 25, right: 12),
          ),
        ],
      ),
    );
  }

  Widget _buildBody(BuildContext context, bool hasInternet) {
    return SingleChildScrollView(
      controller: _scrollController,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _buildWriteTitle(context),
          _buildWriteAScope(context),
          _buildClient(context),
          _buildTagResponsible(context),
          _buildTagTheTeam(context),
          if (hasInternet)
            StreamBuilder<Task?>(
              stream: _viewModel.selectedTaskSubject,
              builder: (context, snapshot) {
                Task? task = snapshot.data;

                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: AddChildTaskView(
                    projectId: _viewModel.projectId,
                    task: task,
                    onKeyboardChanged: (isVisible) {
                      if (isVisible) {
                        Future.delayed(const Duration(milliseconds: 400), () {
                          if (_scrollController.hasClients) {
                            _scrollController.animateTo(
                              _scrollController.position.maxScrollExtent,
                              duration: const Duration(milliseconds: 100),
                              curve: Curves.fastOutSlowIn,
                            );
                          }
                        });
                      }
                    },
                    cancelCallback: () => _viewModel.selectedTaskSubject.add(null),
                    approveCallback: (task) => _viewModel.addOrUpdateTaskOfProject(task),
                  ),
                );
              },
            ),
          _buildListTask(context),
        ],
      ),
    );
  }

  Widget _buildWriteTitle(BuildContext context) {
    return Container(
      height: 65,
      child: Row(
        children: <Widget>[
          Container(
            alignment: Alignment.centerLeft,
            width: 40,
            padding: const EdgeInsets.only(bottom: 4),
            child: _viewModel.isTypingTitle
                ? Lottie.asset(
                    AppImages.animProject,
                    height: 38.5,
                    width: 24.5,
                    repeat: false,
                  )
                : Image.asset(
                    AppImages.icWriteProject,
                    height: 28.5,
                    width: 24.5,
                  ),
          ),
          Expanded(
            child: WordCounterTextField(
              controller: _viewModel.titleController,
              focusNode: _viewModel.titleFocusNode,
              style: TextStyle(
                fontSize: AppFontSize.textDatePicker,
                color: AppColors.normal,
              ),
              hintText: allTranslations.text(AppLanguages.projectTitle),
              hintStyle: TextStyle(
                fontSize: AppFontSize.textDatePicker,
                color: AppColors.textPlaceHolder,
              ),
              onFieldSubmitted: (_) {
                FocusScope.of(context).requestFocus(_viewModel.scopeFocusNode);
                _viewModel.isTypingTitle = _viewModel.titleController.text.isNotEmpty;
              },
              onTap: () {
                _viewModel.isTypingScope = _viewModel.scopeController.text.isNotEmpty;
                _viewModel.isTypingClient = _viewModel.clientController.text.isNotEmpty;
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWriteAScope(BuildContext context) {
    return Container(
      height: 65,
      child: Row(
        children: <Widget>[
          Container(
            alignment: Alignment.centerLeft,
            width: 40,
            padding: const EdgeInsets.only(bottom: 6),
            child: _viewModel.isTypingScope
                ? Lottie.asset(
                    AppImages.animScope,
                    width: 24,
                    repeat: false,
                  )
                : Image.asset(
                    AppImages.icScope,
                    width: 24,
                  ),
          ),
          Expanded(
            child: WordCounterTextField(
              controller: _viewModel.scopeController,
              focusNode: _viewModel.scopeFocusNode,
              style: TextStyle(
                fontSize: AppFontSize.textDatePicker,
                color: AppColors.normal,
              ),
              hintText: allTranslations.text(AppLanguages.writeAScope),
              hintStyle: TextStyle(
                fontSize: AppFontSize.textDatePicker,
                color: AppColors.textPlaceHolder,
              ),
              maxLength: 100,
              onFieldSubmitted: (e) {
                FocusScope.of(context).requestFocus(_viewModel.scopeFocusNode);
                _viewModel.isTypingScope = _viewModel.scopeController.text.isNotEmpty;
              },
              onTap: () {
                _viewModel.isTypingTitle = _viewModel.titleController.text.isNotEmpty;
                _viewModel.isTypingClient = _viewModel.clientController.text.isNotEmpty;
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildClient(BuildContext context) {
    return Container(
      height: 65,
      child: Row(
        children: <Widget>[
          Container(
            alignment: Alignment.centerLeft,
            width: 40,
            padding: const EdgeInsets.only(bottom: 8),
            child: _viewModel.isTypingClient
                ? Lottie.asset(
                    AppImages.animClient,
                    height: 38.5,
                    width: 21.5,
                    repeat: false,
                  )
                : Image.asset(
                    AppImages.icAddClient,
                    height: 38.5,
                    width: 21.5,
                  ),
          ),
          Expanded(
            child: WordCounterTextField(
              controller: _viewModel.clientController,
              focusNode: _viewModel.clientFocusNode,
              style: TextStyle(
                fontSize: AppFontSize.textDatePicker,
                color: AppColors.normal,
              ),
              hintText: allTranslations.text(AppLanguages.client),
              hintStyle: TextStyle(
                fontSize: AppFontSize.textDatePicker,
                color: AppColors.textPlaceHolder,
              ),
              onFieldSubmitted: (e) {
                FocusScope.of(context).requestFocus(_viewModel.clientFocusNode);
                _viewModel.isTypingClient = _viewModel.clientController.text.isNotEmpty;
              },
              onTap: () {
                _viewModel.isTypingTitle = _viewModel.titleController.text.isNotEmpty;
                _viewModel.isTypingScope = _viewModel.scopeController.text.isNotEmpty;
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTagResponsible(BuildContext context) {
    return StreamBuilder<String>(
      stream: _viewModel.tagResponsibleSubject,
      builder: (context, snapshot) {
        var data = snapshot.data ?? "";
        return Container(
          height: 65,
          child: Row(
            children: <Widget>[
              Container(
                alignment: Alignment.centerLeft,
                width: 40,
                child: data.isNotEmpty
                    ? Lottie.asset(
                        AppImages.animResponsible,
                        width: 26,
                        repeat: false,
                      )
                    : Image.asset(
                        AppImages.icAddTagResponsible,
                        width: 26,
                        fit: BoxFit.cover,
                      ),
              ),
              Expanded(
                child: InkWell(
                  onTap: () {
                    _viewModel.isTypingTitle = _viewModel.titleController.text.isNotEmpty;
                    _viewModel.isTypingScope = _viewModel.scopeController.text.isNotEmpty;
                    _viewModel.isTypingClient = _viewModel.clientController.text.isNotEmpty;
                    _showEmployeesDialog(context);
                  },
                  child: Text(
                    data.isEmpty ? allTranslations.text(AppLanguages.leader) : data,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: AppFontSize.textDatePicker,
                      color: data.isEmpty ? AppColors.textPlaceHolder : AppColors.normal,
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  Widget _buildTagTheTeam(BuildContext context) {
    return StreamBuilder<String>(
      stream: _viewModel.teamsSubject,
      builder: (context, snapshot) {
        var data = snapshot.data ?? "";

        return Container(
          height: 65,
          child: Row(
            children: <Widget>[
              Container(
                alignment: Alignment.centerLeft,
                width: 40,
                child: data.isNotEmpty
                    ? Lottie.asset(
                        AppImages.animTeam,
                        width: 22,
                        repeat: false,
                      )
                    : Image.asset(
                        AppImages.icTagTeam,
                        width: 22,
                        fit: BoxFit.cover,
                      ),
              ),
              Expanded(
                child: Text(
                  data.isEmpty ? allTranslations.text(AppLanguages.tagTheTeam) : data,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: AppFontSize.textDatePicker,
                    color: data.isEmpty ? AppColors.textPlaceHolder : AppColors.normal,
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  Widget _buildListTask(BuildContext context) {
    return StreamBuilder<Task?>(
      stream: _viewModel.selectedTaskSubject,
      builder: (context, snapshot) {
        final selectedTask = snapshot.data;
        return StreamBuilder<List<Task>>(
          stream: _viewModel.tasksSubject,
          builder: (context, snapShot) {
            final tasks = snapShot.data ?? <Task>[];
            return ListView.separated(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                Task task = tasks[index];
                if (selectedTask?.id == task.id) return SizedBox();
                return WidgetChildTask(
                  task: task,
                  onEdit: () {
                    FocusScope.of(context).unfocus();
                    _viewModel.selectedTaskSubject.add(task);
                  },
                  onDelete: () => _viewModel.deleteTask(task),
                );
              },
              separatorBuilder: (context, index) => SizedBox(height: 8),
            );
          },
        );
      },
    );
  }

  void _showEmployeesDialog(BuildContext context) {
    showModalBottomSheetCustom(
      context: context,
      builder: (context) => EmployeeDialog(
        isEmployee: true,
        employeeSelected: _viewModel.tagResponsible ?? Employee(id: 0), // TODO id is static
        onCallBack: (employee) {
          FocusScope.of(context).unfocus();
          _viewModel.setTagResponsible(employee);
        },
      ),
    );
  }
}
