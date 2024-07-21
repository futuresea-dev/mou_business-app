import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mou_business_app/ui/base/base_widget.dart';
import 'package:mou_business_app/ui/task_detail/task_detail_viewmodel.dart';
import 'package:mou_business_app/ui/widgets/app_body.dart';
import 'package:mou_business_app/ui/widgets/app_content.dart';
import 'package:mou_business_app/ui/widgets/app_header.dart';
import 'package:mou_business_app/ui/widgets/loading_full_screen.dart';
import 'package:mou_business_app/ui/widgets/app_menu_bar.dart';
import 'package:mou_business_app/utils/app_colors.dart';
import 'package:mou_business_app/utils/app_font_size.dart';
import 'package:mou_business_app/utils/app_images.dart';
import 'package:provider/provider.dart';

class TaskDetailPage extends StatelessWidget {
  final int taskId;
  final String taskName;

  TaskDetailPage({Key? key, required this.taskId, required this.taskName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseWidget<TaskDetailViewModel>(
      viewModel: TaskDetailViewModel(
        projectRepository: Provider.of(context),
        employeeDao: Provider.of(context),
      ),
      onViewModelReady: (viewModel) {
        if (this.taskId != -1) {
          viewModel.initData(this.taskId);
        }
      },
      builder: (context, viewModel, child) => GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          key: viewModel.scaffoldKey,
          body: AppBody(
            child: StreamBuilder<bool>(
              stream: viewModel.loadingSubject.stream,
              builder: (context, snapShot) {
                bool isLoading = snapShot.data ?? false;
                return LoadingFullScreen(
                  loading: isLoading,
                  child: AppContent(
                    headerBuilder: (_) => _buildHeader(context, viewModel),
                    childBuilder: (_) => _buildBody(context, viewModel),
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

  Widget _buildHeader(BuildContext context, TaskDetailViewModel viewModel) {
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
          Padding(
            padding: const EdgeInsets.only(bottom: 9),
            child: Text(
              this.taskName,
              style: TextStyle(
                  fontSize: AppFontSize.textTitlePage,
                  color: Colors.black,
                  fontWeight: FontWeight.normal),
            ),
          ),
          Spacer(flex: 1),
          SizedBox(width: 23.5)
        ],
      ),
    );
  }

  Widget _buildBody(BuildContext context, TaskDetailViewModel viewModel) {
    return Container(
      padding: const EdgeInsets.only(left: 38, right: 38),
      width: double.maxFinite,
      height: double.maxFinite,
      color: Color(0xfff4f7fa),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            const SizedBox(height: 10),
            _buildStartDateHour(context, viewModel),
            _buildEndDateHour(context, viewModel),
            _buildWriteADescription(context, viewModel),
            _buildTagSomeone(context, viewModel),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  Widget _buildStartDateHour(BuildContext context, TaskDetailViewModel viewModel) {
    return Container(
      height: 65,
      child: Row(
        children: <Widget>[
          Container(
            alignment: Alignment.centerLeft,
            width: 50,
            child: Image.asset(
              AppImages.icDateHour,
              width: 22,
              height: 22,
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
            child: StreamBuilder<String?>(
              stream: viewModel.startDateSubject,
              builder: (context, snapshot) {
                String startDate = snapshot.data ?? "";
                return Text(
                  startDate,
                  style: TextStyle(fontSize: AppFontSize.textDatePicker, color: AppColors.normal),
                );
              },
            ),
          )
        ],
      ),
    );
  }

  Widget _buildEndDateHour(BuildContext context, TaskDetailViewModel viewModel) {
    return StreamBuilder<String?>(
      stream: viewModel.endDateSubject,
      builder: (context, snapshot) {
        var endDate = snapshot.data ?? "";
        return endDate.isEmpty
            ? const SizedBox()
            : Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.only(left: 50, bottom: 15),
                child: Text(
                  endDate,
                  style: TextStyle(
                    fontSize: AppFontSize.textDatePicker,
                    color: AppColors.normal,
                  ),
                ),
              );
      },
    );
  }

  Widget _buildWriteADescription(BuildContext context, TaskDetailViewModel viewModel) {
    return Container(
      height: 65,
      child: Row(
        children: <Widget>[
          Container(
            alignment: Alignment.centerLeft,
            width: 50,
            child: Image.asset(
              AppImages.icComment,
              width: 27,
            ),
          ),
          Expanded(
            child: StreamBuilder<String?>(
              stream: viewModel.commentSubject,
              builder: (context, snapshot) {
                String comment = snapshot.data ?? "";
                return Text(
                  comment,
                  style: TextStyle(
                    fontSize: AppFontSize.textDatePicker,
                    color: AppColors.normal,
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }

  Widget _buildTagSomeone(BuildContext context, TaskDetailViewModel viewModel) {
    return Container(
      height: 65,
      child: Row(
        children: <Widget>[
          Container(
            alignment: Alignment.centerLeft,
            width: 50,
            child: Image.asset(
              AppImages.icTagSomeOne,
              height: 23,
              width: 20.5,
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
            child: StreamBuilder<String?>(
                stream: viewModel.employeeSubject,
                builder: (context, snapShot) {
                  var data = snapShot.data ?? "";
                  return Text(
                    data,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: AppFontSize.textDatePicker, color: AppColors.normal),
                  );
                }),
          )
        ],
      ),
    );
  }
}
