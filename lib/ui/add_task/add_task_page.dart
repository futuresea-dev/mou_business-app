import 'package:flutter/material.dart' hide MenuBar;
import 'package:lottie/lottie.dart';
import 'package:mou_business_app/core/databases/app_database.dart';
import 'package:mou_business_app/helpers/translations.dart';
import 'package:mou_business_app/ui/add_task/add_task_viewmodel.dart';
import 'package:mou_business_app/ui/add_task/components/store_dialog.dart';
import 'package:mou_business_app/ui/add_task/components/store_input.dart';
import 'package:mou_business_app/ui/base/base_widget.dart';
import 'package:mou_business_app/ui/widgets/app_body.dart';
import 'package:mou_business_app/ui/widgets/app_content.dart';
import 'package:mou_business_app/ui/widgets/app_header.dart';
import 'package:mou_business_app/ui/widgets/bottom_sheet_custom.dart';
import 'package:mou_business_app/ui/widgets/employee_list_dialog/employee_list_dialog.dart';
import 'package:mou_business_app/ui/widgets/loading_full_screen.dart';
import 'package:mou_business_app/ui/widgets/app_menu_bar.dart';
import 'package:mou_business_app/ui/widgets/range_date_picker/range_date_picker_dialog.dart';
import 'package:mou_business_app/ui/widgets/word_counter_textfield.dart';
import 'package:mou_business_app/utils/app_colors.dart';
import 'package:mou_business_app/utils/app_constants.dart';
import 'package:mou_business_app/utils/app_font_size.dart';
import 'package:mou_business_app/utils/app_images.dart';
import 'package:mou_business_app/utils/app_languages.dart';
import 'package:mou_business_app/utils/app_utils.dart';
import 'package:provider/provider.dart';

class AddTaskPage extends StatelessWidget {
  final int? taskId;

  const AddTaskPage({this.taskId});

  @override
  Widget build(BuildContext context) {
    return BaseWidget<AddTaskViewModel>(
      viewModel: AddTaskViewModel(
        projectRepository: Provider.of(context),
        employeeDao: Provider.of(context),
      ),
      onViewModelReady: (viewModel) {
        if (taskId != null) {
          viewModel.initData(taskId!);
        }
        viewModel.setFocus();
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
                    headerBuilder: (hasInternet) => _buildHeader(context, viewModel, hasInternet),
                    childBuilder: (hasInternet) => _buildBody(context, viewModel, hasInternet),
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

  Widget _buildHeader(BuildContext context, AddTaskViewModel viewModel, bool hasInternet) {
    return AppHeader(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(bottom: 25, left: 12),
            child: IconButton(
              icon: Image.asset(AppImages.icClose, width: 16),
              onPressed: viewModel.goBack,
            ),
          ),
          const Spacer(flex: 1),
          Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: Container(
              height: 65,
              alignment: Alignment.center,
              child: IconButton(
                icon: Hero(
                  tag: 'imageTask',
                  child: Image.asset(AppImages.task_new_header),
                ),
                iconSize: 50,
                padding: const EdgeInsets.only(bottom: 22),
                onPressed: hasInternet ? () => AppUtils.openLink(AppConstants.taskScopeLink) : null,
              ),
            ),
          ),
          const Spacer(flex: 1),
          IconButton(
            iconSize: 50,
            onPressed: hasInternet ? viewModel.createUpdateTask : null,
            icon: hasInternet
                ? ValueListenableBuilder<int>(
                    valueListenable: viewModel.totalDeny,
                    builder: (_, value, __) {
                      return Image.asset(
                        value > 0 ? AppImages.icReAccept : AppImages.icAccept,
                        width: 24,
                        fit: BoxFit.cover,
                      );
                    },
                  )
                : const SizedBox(height: 15),
            padding: const EdgeInsets.only(bottom: 25, right: 12),
          )
        ],
      ),
    );
  }

  Widget _buildBody(BuildContext context, AddTaskViewModel viewModel, bool hasInternet) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      width: double.maxFinite,
      height: double.maxFinite,
      child: hasInternet
          ? SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  const SizedBox(height: 10),
                  _buildWriteTitle(context, viewModel),
                  _buildStartDateHour(context, viewModel),
                  _buildEndDateHour(context, viewModel),
                  _buildWriteADescription(context, viewModel),
                  _buildTagSomeone(context, viewModel),
                  StreamBuilder<Shop?>(
                    stream: viewModel.shopSubject,
                    builder: (context, snapshot) {
                      final shop = snapshot.data;
                      return StoreInput(
                        name: shop?.name ?? '',
                        onTap: () {
                          final height = MediaQuery.sizeOf(context).height;
                          showModalBottomSheetCustom(
                            context: context,
                            builder: (context) {
                              return SizedBox(
                                height: height - 480,
                                child: StoreDialog(
                                  selectedShop: viewModel.shopSubject.valueOrNull,
                                  onTap: (shop) {
                                    viewModel.updateShopSelected(shop);
                                  },
                                ),
                              );
                            },
                          );
                        },
                      );
                    },
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            )
          : const SizedBox(),
    );
  }

  Widget _buildWriteTitle(BuildContext context, AddTaskViewModel viewModel) {
    return SizedBox(
      height: 65,
      child: Row(
        children: <Widget>[
          StreamBuilder<bool?>(
            stream: viewModel.isTypingTaskTitle,
            builder: (context, snapshot) {
              bool isShowAnim = snapshot.data ?? false;
              return Container(
                alignment: Alignment.centerLeft,
                width: 40,
                padding: const EdgeInsets.only(bottom: 6),
                child: isShowAnim
                    ? Lottie.asset(
                        AppImages.animTask,
                        width: 21,
                        repeat: false,
                      )
                    : Image.asset(
                        AppImages.icWriteTask,
                        width: 21,
                      ),
              );
            },
          ),
          Expanded(
            child: WordCounterTextField(
              controller: viewModel.titleController,
              focusNode: viewModel.titleFocusNode,
              maxLength: 20,
              style: TextStyle(
                fontSize: AppFontSize.textDatePicker,
                color: AppColors.normal,
              ),
              hintText: allTranslations.text(AppLanguages.taskTitle),
              hintStyle: TextStyle(
                fontSize: AppFontSize.textDatePicker,
                color: AppColors.textPlaceHolder,
              ),
              onFieldSubmitted: (e) {
                viewModel.titleFocusNode.unfocus();
                viewModel.isTypingTaskTitle.add(e.trim().isNotEmpty);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStartDateHour(BuildContext context, AddTaskViewModel viewModel) {
    return SizedBox(
      height: 65,
      child: Row(
        children: <Widget>[
          StreamBuilder<bool?>(
            stream: viewModel.isTypingDate,
            builder: (context, snapshot) {
              bool isShowAnim = snapshot.data ?? false;
              return Container(
                alignment: Alignment.centerLeft,
                width: 40,
                child: isShowAnim
                    ? Lottie.asset(
                        AppImages.animDate,
                        width: 21,
                        repeat: false,
                      )
                    : Image.asset(
                        AppImages.icDateHour,
                        width: 22,
                        height: 22,
                        fit: BoxFit.cover,
                      ),
              );
            },
          ),
          Expanded(
            child: InkWell(
              onTap: () {
                _showDatePicker(context, viewModel);
              },
              child: StreamBuilder<String>(
                stream: viewModel.startDateHourSubject,
                builder: (context, snapshot) {
                  String startDate = snapshot.data ?? "";
                  return Text(
                    startDate.isEmpty ? allTranslations.text(AppLanguages.addDate) : startDate,
                    style: TextStyle(
                      fontSize: AppFontSize.textDatePicker,
                      color: startDate.isEmpty ? AppColors.textPlaceHolder : AppColors.normal,
                    ),
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildEndDateHour(BuildContext context, AddTaskViewModel viewModel) {
    return StreamBuilder<String>(
      stream: viewModel.endDateHourSubject,
      builder: (context, snapshot) {
        var endDate = snapshot.data ?? "";
        return endDate.isEmpty
            ? const SizedBox.shrink()
            : Transform.translate(
                offset: const Offset(0, -10),
                child: Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.only(left: 40),
                  child: InkWell(
                    onTap: () => _showDatePicker(context, viewModel),
                    child: Text(
                      endDate,
                      style: TextStyle(
                        fontSize: AppFontSize.textDatePicker,
                        color: AppColors.normal,
                      ),
                    ),
                  ),
                ),
              );
      },
    );
  }

  Widget _buildWriteADescription(BuildContext context, AddTaskViewModel viewModel) {
    return SizedBox(
      height: 65,
      child: Row(
        children: <Widget>[
          StreamBuilder<bool?>(
            stream: viewModel.isTypingDescription,
            builder: (context, snapshot) {
              bool isShowAnim = snapshot.data ?? false;
              return Container(
                alignment: Alignment.centerLeft,
                width: 40,
                padding: const EdgeInsets.only(bottom: 6),
                child: isShowAnim
                    ? Lottie.asset(
                        AppImages.animDescription,
                        width: 27,
                        repeat: false,
                      )
                    : Image.asset(
                        AppImages.icComment,
                        width: 27,
                      ),
              );
            },
          ),
          Expanded(
            child: WordCounterTextField(
              controller: viewModel.commentController,
              focusNode: viewModel.commentFocusNode,
              style: TextStyle(
                fontSize: AppFontSize.textDatePicker,
                color: AppColors.normal,
              ),
              maxLength: 100,
              hintText: allTranslations.text(AppLanguages.writeADescription),
              hintStyle: TextStyle(
                fontSize: AppFontSize.textDatePicker,
                color: AppColors.textPlaceHolder,
              ),
              onFieldSubmitted: (e) {
                viewModel.commentFocusNode.unfocus();
                viewModel.isTypingDescription.add(e.trim().isNotEmpty);
              },
            ),
          ),
        ],
      ),
    );
  }

//  Widget _buildRepeat(BuildContext context, AddTaskViewModel viewModel) {
//    return Container(
//      height: 65,
//      child: Row(
//        children: <Widget>[
//          Container(
//            alignment: Alignment.centerLeft,
//            width: 50,
//            child: Image.asset(
//              AppImages.icRepeat,
//              width: 22,
//              height: 22,
//              fit: BoxFit.cover,
//            ),
//          ),
//          Expanded(
//            child: InkWell(
//              onTap: () {
//                _showDaysInWeekDialog(context, viewModel);
//              },
//              child: Container(
//                child: StreamBuilder<List<DayInWeek>>(
//                    stream: viewModel.repeatSubject,
//                    builder: (context, snapshot) {
//                      var data = snapshot.data ?? null;
//                      return Text(
//                        data == null
//                            ? allTranslations.text(AppLanguages.repeat)
//                            : data
//                                .map<String>((item) => item.name ?? '')
//                                .toList()
//                                .join("; "),
//                        style: TextStyle(
//                            fontSize: AppFontSize.textDatePicker,
//                            color: data == null
//                                ? AppColors.textPlaceHolder
//                                : AppColors.normal),
//                      );
//                    }),
//              ),
//            ),
//          )
//        ],
//      ),
//    );
//  }

  Widget _buildTagSomeone(BuildContext context, AddTaskViewModel viewModel) {
    return SizedBox(
      height: 55,
      child: Row(
        children: <Widget>[
          StreamBuilder<bool?>(
            stream: viewModel.isTypingTagSomeOne,
            builder: (context, snapshot) {
              bool isShowAnim = snapshot.data ?? false;
              return Container(
                alignment: Alignment.centerLeft,
                width: 40,
                child: isShowAnim
                    ? Lottie.asset(
                        AppImages.animTagSomeOne,
                        width: 22,
                        repeat: false,
                      )
                    : Image.asset(
                        AppImages.icTagSomeOne,
                        height: 23,
                        width: 20.5,
                        fit: BoxFit.cover,
                      ),
              );
            },
          ),
          Expanded(
            child: InkWell(
              onTap: () {
                _showEmployeesDialog(context, viewModel);
              },
              child: StreamBuilder<String>(
                stream: viewModel.employeeSubject,
                builder: (context, snapShot) {
                  var data = snapShot.data ?? "";

                  return Text(
                    data.isEmpty ? allTranslations.text(AppLanguages.tagSomeone) : data,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: AppFontSize.textDatePicker,
                      color: data.isEmpty ? AppColors.textPlaceHolder : AppColors.normal,
                    ),
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }

  void _showEmployeesDialog(BuildContext context, AddTaskViewModel viewModel) {
    showModalBottomSheetCustom(
      context: context,
      builder: (context) => EmployeeListDialog(
        isEmployee: true,
        employeesSelected: viewModel.employees ?? [],
        onCallBack: (employee) {
          viewModel.setEmployees(employee);
          viewModel.isTypingTagSomeOne.add(employee.isNotEmpty);
        },
      ),
    );
  }

  void _showDatePicker(BuildContext context, AddTaskViewModel viewModel) {
    final height = MediaQuery.sizeOf(context).height;
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(15.0)),
      ),
      backgroundColor: AppColors.bgColor,
      context: context,
      builder: (BuildContext context) {
        var startDate = viewModel.startDateHour ?? DateTime.now();
        var endDate = viewModel.endDateHour;
        viewModel.setDate(
          startDate.day,
          startDate.month,
          startDate.year,
          endDate?.day ?? 0,
          endDate?.month ?? 0,
          endDate?.year ?? 0,
        );
        return RangeDatePickerDialog(
          height: height / 2,
          startDay: startDate.day,
          startMonth: startDate.month,
          startYear: startDate.year,
          endDay: endDate?.day ?? 0,
          endMonth: endDate?.month ?? 0,
          endYear: endDate?.year ?? 0,
          onCallBack: (startDay, startMonth, startYear, endDay, endMonth, endYear) {
            viewModel.setDate(startDay, startMonth, startYear, endDay, endMonth, endYear);
          },
        );
      },
    ).then((_) {
      viewModel.isTypingDate.add(viewModel.startDateHour != null);
    });
  }
}
