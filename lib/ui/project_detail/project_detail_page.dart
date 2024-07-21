import 'dart:math';

import 'package:flutter/material.dart' hide MenuBar;
import 'package:intl/intl.dart';
import 'package:mou_business_app/core/models/task_detail.dart';
import 'package:mou_business_app/core/responses/project_detail/project_detail_response.dart';
import 'package:mou_business_app/helpers/translations.dart';
import 'package:mou_business_app/ui/base/base_widget.dart';
import 'package:mou_business_app/ui/project_detail/child_task_view/child_task_view.dart';
import 'package:mou_business_app/ui/project_detail/project_detail_viewmodel.dart';
import 'package:mou_business_app/ui/widgets/app_body.dart';
import 'package:mou_business_app/ui/widgets/app_content.dart';
import 'package:mou_business_app/ui/widgets/app_header.dart';
import 'package:mou_business_app/ui/widgets/app_menu_bar.dart';
import 'package:mou_business_app/utils/app_colors.dart';
import 'package:mou_business_app/utils/app_font_size.dart';
import 'package:mou_business_app/utils/app_images.dart';
import 'package:mou_business_app/utils/app_languages.dart';
import 'package:mou_business_app/utils/types/app_types.dart';
import 'package:provider/provider.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class ProjectDetailPage extends StatelessWidget {
  final ProjectDetailArgument? argument;

  ProjectDetailPage({this.argument});

  @override
  Widget build(BuildContext context) {
    return BaseWidget<ProjectDetailViewModel>(
      viewModel: ProjectDetailViewModel(
        projectRepository: Provider.of(context),
        projectId: argument?.projectId ?? 0,
      ),
      onViewModelReady: (viewModel) => viewModel.initData(),
      builder: (context, viewModel, child) => Scaffold(
        key: viewModel.scaffoldKey,
        backgroundColor: Color(0xfff4f7fa),
        body: AppBody(
          child: AppContent(
            headerBuilder: (_) => _buildHeader(context, viewModel),
            childBuilder: (_) => _buildBody(context, viewModel),
            menuBar: const AppMenuBar(),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, ProjectDetailViewModel viewModel) {
    return AppHeader(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: Transform.rotate(
              angle: 180 * pi / 180,
              child: IconButton(
                icon: Image.asset(AppImages.icArrowNext, color: Colors.black, width: 14),
                onPressed: viewModel.goBack,
              ),
            ),
          ),
          Spacer(flex: 1),
          Container(
            padding: const EdgeInsets.only(bottom: 5),
            child: Text(
              argument?.projectName ?? "",
              style: TextStyle(
                  fontSize: AppFontSize.textTitlePage,
                  color: Colors.black,
                  fontWeight: FontWeight.normal),
            ),
          ),
          Spacer(flex: 1),
          SizedBox(width: 35)
        ],
      ),
    );
  }

  Widget _buildBody(BuildContext context, ProjectDetailViewModel viewModel) {
    return Stack(
      alignment: Alignment.topRight,
      children: <Widget>[
        Container(
          color: Color(0xfff4f7fa),
          width: double.maxFinite,
          height: double.maxFinite,
          child: SingleChildScrollView(
            child: StreamBuilder<ProjectDetailResponse>(
                stream: viewModel.projectDetailSubject,
                builder: (context, snapshot) {
                  var projectDetail = snapshot.data;
                  if (projectDetail == null)
                    return Container(
                        padding: const EdgeInsets.only(top: 20),
                        alignment: Alignment.center,
                        child: LoadingAnimationWidget.staggeredDotsWave(
                            color: AppColors.menuBar, size: 40));
                  return _buildContent(projectDetail, context, viewModel);
                }),
          ),
        ),
        Positioned(
          top: 14,
          right: 20,
          child: InkWell(
            onTap: viewModel.showHiddenProjectInfo,
            child: StreamBuilder<bool>(
              stream: viewModel.hiddenProjectInfoSubject,
              builder: (context, snapShot) {
                var isHidden = snapShot.data ?? false;
                if (snapShot.data == null) return SizedBox();
                return Container(
                  alignment: Alignment.center,
                  height: 20,
                  child: Image.asset(
                    isHidden ? AppImages.icEye : AppImages.icEyeClose,
                    height: isHidden ? 13 : 17,
                  ),
                );
              },
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: StreamBuilder<bool>(
              stream: viewModel.isShowDescriptionSubject,
              builder: (context, snapShot) {
                var isShow = snapShot.data ?? false;
                if (!isShow) return SizedBox();
                return _buildDescriptionInfo(viewModel);
              }),
        )
      ],
    );
  }

  Widget _buildDescriptionInfo(ProjectDetailViewModel viewModel) {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
        color: Colors.white,
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: <Widget>[
            SizedBox(width: 15),
            this._buildDescriptionInfoItem(
              viewModel.getStatusColor(TaskStatus.DONE),
              allTranslations.text(AppLanguages.doneInTime),
            ),
            SizedBox(width: 15),
            this._buildDescriptionInfoItem(
              viewModel.getStatusColor(TaskStatus.NOT_DONE),
              allTranslations.text(AppLanguages.notDoneInTime),
            ),
            SizedBox(width: 15),
            this._buildDescriptionInfoItem(
              viewModel.getStatusColor(TaskStatus.IN_PROGRESS),
              allTranslations.text(AppLanguages.inProgress),
            ),
            SizedBox(width: 15),
            this._buildDescriptionInfoItem(
              viewModel.getStatusColor(TaskStatus.WAITING),
              allTranslations.text(AppLanguages.waitingToStart),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDescriptionInfoItem(Color statusColor, String description) {
    return Row(
      children: <Widget>[
        Container(
          height: 10,
          width: 10,
          decoration: BoxDecoration(
            color: statusColor,
            borderRadius: BorderRadius.circular(3),
          ),
        ),
        SizedBox(width: 2),
        Text(
          description,
          style: TextStyle(fontSize: 8, color: Colors.black),
        )
      ],
    );
  }

  Widget _buildContent(
    ProjectDetailResponse projectDetail,
    BuildContext context,
    ProjectDetailViewModel viewModel,
  ) {
    var companyName = projectDetail.companyName;
    var projectDate = viewModel.getProjectDate(projectDetail.tasks ?? []);
    var description = projectDetail.description;
    var client = projectDetail.client;
    var responsible = projectDetail.employeeResponsible?.name;
    var teams = viewModel.getTeams(projectDetail.teams ?? []);

    return Column(
      children: <Widget>[
        StreamBuilder<bool>(
          stream: viewModel.hiddenProjectInfoSubject,
          builder: (context, snapShot) {
            var isHidden = snapShot.data ?? false;
            if (isHidden) return SizedBox();
            return Container(
              padding: const EdgeInsets.only(top: 10, left: 43, right: 43),
              child: Column(
                children: <Widget>[
                  _buildItemProject(companyName ?? "", AppImages.icCorp, 22, 29),
                  _buildItemProject(projectDate, AppImages.icDateHour, 22, 22),
                  _buildItemMultiLineProject(
                      context, description ?? "", AppImages.icComment, 24, 13),
                  _buildItemProject(client ?? "", AppImages.icAddClient, 22, 24),
                  _buildItemProject(responsible ?? "", AppImages.icAddTagResponsible, 26, 26),
                  _buildItemMultiLineProject(context, teams, AppImages.icTagTeam, 22, 22),
                ],
              ),
            );
          },
        ),
        InkWell(
          onTap: viewModel.showHiddenDescription,
          child: Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.only(top: 20, left: 25),
            child: Image.asset(
              AppImages.icInfo,
              width: 14,
              height: 14,
              fit: BoxFit.cover,
            ),
          ),
        ),
        this._buildListTask(context, projectDetail.tasks ?? [], viewModel),
      ],
    );
  }

  Widget _buildItemProject(String content, String assetName, double width, double height) {
    return Container(
      child: Row(
        children: <Widget>[
          Container(
            height: 50,
            child: Row(
              children: <Widget>[
                Container(
                  alignment: Alignment.centerLeft,
                  width: 50,
                  child: Image.asset(assetName, width: width, height: height),
                ),
                Text(content,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: AppFontSize.textButton, color: AppColors.normal))
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildItemMultiLineProject(BuildContext context, String content, String assetName,
      double widthImage, double heightImage) {
    final width = MediaQuery.sizeOf(context).width;
    return Container(
      padding: const EdgeInsets.only(top: 15, bottom: 13),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            alignment: Alignment.centerLeft,
            width: 50,
            child: Image.asset(
              assetName,
              width: widthImage,
              height: heightImage,
            ),
          ),
          Container(
            width: width - 136,
            child: Text(content,
                style: TextStyle(fontSize: AppFontSize.textButton, color: AppColors.normal)),
          )
        ],
      ),
    );
  }

  Widget _buildListTask(
      BuildContext context, List<TaskDetail> tasks, ProjectDetailViewModel viewModel) {
    return Container(
      padding: const EdgeInsets.only(left: 25, right: 25, top: 6),
      child: Column(
        children: List.generate(tasks.length, (index) {
          return this._buildItemTaskRow(tasks[index], index, viewModel);
        }),
      ),
    );
  }

  Widget _buildItemTaskRow(TaskDetail task, int index, ProjectDetailViewModel viewModel) {
    var startDate = task.startDate != null ? DateTime.parse(task.startDate ?? "") : null;
    var endDate = task.endDate != null ? DateTime.parse(task.endDate ?? "") : null;
    var colorStatus = viewModel.getStatusColor(task.status ?? "");
    return Column(
      children: <Widget>[
        StreamBuilder<int>(
            stream: viewModel.indexShowTaskAddSubject,
            builder: (context, snapshot) {
              var indexItem = snapshot.data ?? -1;
              return InkWell(
                onTap: () {
                  if (indexItem == index) {
                    viewModel.indexShowTaskAddSubject.add(-1);
                  } else {
                    viewModel.indexShowTaskAddSubject.add(index);
                  }
                },
                child: indexItem == index
                    ? Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ChildTaskView(task: task),
                      )
                    : _buildItemTask(task, startDate ?? DateTime.now(), endDate ?? DateTime.now(),
                        index, colorStatus, viewModel),
              );
            }),
        SizedBox(height: 6),
      ],
    );
  }

  Widget _buildItemTask(
    TaskDetail task,
    DateTime startDate,
    DateTime endDate,
    int index,
    Color colorStatus,
    ProjectDetailViewModel viewModel,
  ) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Container(
            height: 26,
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.only(left: 7),
            decoration: new BoxDecoration(
                color: colorStatus,
                borderRadius: new BorderRadius.only(
                  topLeft: const Radius.circular(8.0),
                  bottomLeft: const Radius.circular(8.0),
                )),
            child: Text(
              task.title ?? "",
              maxLines: 1,
              style: TextStyle(color: Colors.black, fontSize: AppFontSize.textButton),
            ),
          ),
        ),
        SizedBox(width: 1),
        Container(
          height: 26,
          width: 51,
          alignment: Alignment.center,
          color: colorStatus,
          child: Text(
            DateFormat("dd-MM").format(startDate),
            style: TextStyle(color: Colors.black, fontSize: AppFontSize.textButton),
          ),
        ),
        SizedBox(width: 1),
        Container(
          height: 26,
          width: 51,
          alignment: Alignment.center,
          color: colorStatus,
          child: Text(
            DateFormat("dd-MM").format(endDate),
            style: TextStyle(color: Colors.black, fontSize: AppFontSize.textButton),
          ),
        ),
        SizedBox(width: 1),
        Container(
          height: 26,
          width: 51,
          alignment: Alignment.center,
          decoration: new BoxDecoration(
              color: colorStatus,
              borderRadius: new BorderRadius.only(
                topRight: const Radius.circular(8.0),
                bottomRight: const Radius.circular(8.0),
              )),
          child: Text(
            "Abc",
            maxLines: 1,
            style: TextStyle(color: Colors.white, fontSize: AppFontSize.textButton),
          ),
        ),
      ],
    );
  }
}

class ProjectDetailArgument {
  final int projectId;
  final String projectName;

  ProjectDetailArgument(this.projectId, this.projectName);
}
