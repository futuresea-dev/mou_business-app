import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:lottie/lottie.dart';
import 'package:mou_business_app/core/databases/app_database.dart';
import 'package:mou_business_app/helpers/translations.dart';
import 'package:mou_business_app/ui/add_project/add_child_task/add_child_task_viewModel.dart';
import 'package:mou_business_app/ui/base/base_widget.dart';
import 'package:mou_business_app/ui/widgets/bottom_sheet_custom.dart';
import 'package:mou_business_app/ui/widgets/employee_list_dialog/employee_list_dialog.dart';
import 'package:mou_business_app/ui/widgets/range_date_picker/range_date_picker_dialog.dart';
import 'package:mou_business_app/ui/widgets/word_counter_textfield.dart';
import 'package:mou_business_app/utils/app_colors.dart';
import 'package:mou_business_app/utils/app_font_size.dart';
import 'package:mou_business_app/utils/app_images.dart';
import 'package:mou_business_app/utils/app_languages.dart';
import 'package:provider/provider.dart';

class AddChildTaskView extends StatefulWidget {
  final int projectId;
  final Task? task;
  final VoidCallback cancelCallback;
  final Function(Task task) approveCallback;
  final Function(bool isVisible) onKeyboardChanged;

  AddChildTaskView({
    super.key,
    this.projectId = 0,
    required this.task,
    required this.cancelCallback,
    required this.approveCallback,
    required this.onKeyboardChanged,
  });

  @override
  State<AddChildTaskView> createState() => _AddChildTaskViewState();
}

class _AddChildTaskViewState extends State<AddChildTaskView> {
  late AddChildTaskViewModel _viewModel;
  bool isAdd = false;
  final ValueNotifier<bool> showAnimTitle = ValueNotifier(false);
  final ValueNotifier<bool> showAnimDate = ValueNotifier(false);
  final ValueNotifier<bool> showAnimDescription = ValueNotifier(false);
  final ValueNotifier<bool> showAnimTag = ValueNotifier(false);
  final keyboardVisibilityController = KeyboardVisibilityController();

  @override
  void initState() {
    super.initState();
    keyboardVisibilityController.onChange.listen((visible) {
      widget.onKeyboardChanged.call(visible);
    });
  }

  @override
  void dispose() {
    showAnimTitle.dispose();
    showAnimDate.dispose();
    showAnimDescription.dispose();
    showAnimTag.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant AddChildTaskView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if ((widget.task != null && !isAdd) || (isAdd && oldWidget.task != null)) {
      if (!isAdd && oldWidget.task == null) {
        _viewModel.initData(widget.task);
        setState(() {
          isAdd = true;
        });
      }
    }
  }

  _resetAnim() {
    showAnimTitle.value = false;
    showAnimDate.value = false;
    showAnimDescription.value = false;
    showAnimTag.value = false;
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardVisibilityBuilder(
      builder: (_, __) {
        return BaseWidget<AddChildTaskViewModel>(
          viewModel: AddChildTaskViewModel(employeeDao: Provider.of(context)),
          onViewModelReady: (viewModel) {
            _viewModel = viewModel;
            _viewModel.initData(widget.task);
          },
          builder: (context, _, __) {
            return GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
                showAnimTitle.value =
                    _viewModel.titleController.text.isNotEmpty;
                showAnimDescription.value =
                    _viewModel.commentController.text.isNotEmpty;
              },
              child: Column(
                children: <Widget>[
                  _buildHeader(context),
                  AnimatedSize(
                    duration: const Duration(milliseconds: 300),
                    alignment: Alignment.topCenter,
                    child: isAdd
                        ? Container(
                            margin: const EdgeInsets.only(top: 10),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                colors: [
                                  AppColors.menuBar.withOpacity(.6),
                                  Colors.white,
                                ],
                              ),
                              borderRadius: BorderRadius.circular(9),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2), // Adjust the color and opacity as needed
                                  blurRadius: 4,
                                  offset: Offset(2, 5),
                                )
                              ],
                            ),
                            width: double.infinity,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 12),
                              child: Column(
                                children: [
                                  _buildWriteTitle(context),
                                  _buildStartDateHour(context),
                                  _buildEndDateHour(context),
                                  _buildWriteADescription(context),
                                  _buildTagSomeone(context)
                                ],
                              ),
                            ),
                          )
                        : const SizedBox(),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 3),
      child: Row(
        children: <Widget>[
          InkWell(
            onTap: () {
              setState(() {
                isAdd = !isAdd;
              });
              _viewModel.clearData();
              _resetAnim();
              widget.cancelCallback.call();
            },
            child: Container(
              width: 40,
              alignment: Alignment.centerLeft,
              child: AnimatedRotation(
                duration: const Duration(milliseconds: 350),
                turns: (isAdd ? 0 : -45) / 360,
                child: Image.asset(
                  AppImages.icClose,
                  height: 15,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
          Expanded(
            child: AnimatedAlign(
              alignment: isAdd ? Alignment.center : Alignment.centerLeft,
              duration: const Duration(milliseconds: 350),
              child: Text(
                allTranslations.text(widget.task != null && isAdd
                    ? AppLanguages.editTask
                    : AppLanguages.addTask),
                style: TextStyle(
                  fontSize: AppFontSize.textDatePicker,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey.shade700,
                ),
              ),
            ),
          ),
          if (isAdd)
            InkWell(
              onTap: () {
                if (_viewModel.validate) {
                  setState(() {
                    isAdd = !isAdd;
                  });
                  widget.approveCallback(_viewModel.getTask(widget.task));
                  _resetAnim();
                  _viewModel.clearData();
                }
              },
              child: Container(
                alignment: Alignment.centerRight,
                width: 50,
                child: Image.asset(
                  AppImages.icAccept,
                  height: 13,
                  fit: BoxFit.cover,
                ),
              ),
            )
        ],
      ),
    );
  }

  Widget _buildWriteTitle(BuildContext context) {
    return Container(
      height: 38,
      child: Row(
        children: <Widget>[
          Container(
            alignment: Alignment.centerLeft,
            width: 35,
            padding: const EdgeInsets.only(bottom: 6),
            child: ValueListenableBuilder<bool>(
              valueListenable: showAnimTitle,
              builder: (_, value, __) {
                return value
                    ? Lottie.asset(
                        AppImages.animTask,
                        width: 18,
                        repeat: false,
                      )
                    : Image.asset(
                        AppImages.icChildTaskTitle,
                        width: 16,
                        fit: BoxFit.cover,
                      );
              },
            ),
          ),
          Expanded(
            child: WordCounterTextField(
              controller: _viewModel.titleController,
              focusNode: _viewModel.titleFocusNode,
              hintText: allTranslations.text(AppLanguages.taskTitle),
              hintStyle: TextStyle(
                fontSize: AppFontSize.textButton,
                color: AppColors.header,
              ),
              onFieldSubmitted: (_) {
                showAnimTitle.value =
                    _viewModel.titleController.text.isNotEmpty;
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStartDateHour(BuildContext context) {
    return SizedBox(
      height: 38,
      child: Row(
        children: <Widget>[
          Container(
            width: 35,
            alignment: Alignment.centerLeft,
            child: ValueListenableBuilder<bool>(
              valueListenable: showAnimDate,
              builder: (_, value, __) {
                return value
                    ? Lottie.asset(
                        AppImages.animDate,
                        width: 18,
                        repeat: false,
                      )
                    : Image.asset(
                        AppImages.icChildTaskDateTime,
                        width: 18,
                        fit: BoxFit.cover,
                      );
              },
            ),
          ),
          Expanded(
            child: InkWell(
              onTap: () => _showDatePicker(context),
              child: StreamBuilder<String>(
                stream: _viewModel.startDateHourSubject,
                builder: (context, snapshot) {
                  String startDate = snapshot.data ?? "";
                  return Text(
                    startDate == ""
                        ? allTranslations.text(AppLanguages.addDate)
                        : startDate,
                    style: TextStyle(
                      fontSize: AppFontSize.textButton,
                      color:
                          startDate == "" ? AppColors.header : AppColors.normal,
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

  Widget _buildEndDateHour(BuildContext context) {
    return StreamBuilder<String>(
      stream: _viewModel.endDateHourSubject,
      builder: (context, snapshot) {
        var endDate = snapshot.data ?? "";
        return endDate.isEmpty
            ? const SizedBox()
            : Container(
                padding: const EdgeInsets.only(bottom: 12, left: 35),
                alignment: Alignment.topLeft,
                child: InkWell(
                  onTap: () => _showDatePicker(context),
                  child: Text(
                    endDate,
                    style: TextStyle(
                      fontSize: AppFontSize.textButton,
                      color: AppColors.normal,
                    ),
                  ),
                ),
              );
      },
    );
  }

  Widget _buildWriteADescription(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 4),
      height: 45,
      child: Row(
        children: <Widget>[
          Container(
            alignment: Alignment.centerLeft,
            width: 35,
            padding: const EdgeInsets.only(bottom: 5),
            child: ValueListenableBuilder<bool>(
              valueListenable: showAnimDescription,
              builder: (_, value, __) {
                return value
                    ? Lottie.asset(
                        AppImages.animDescription,
                        width: 24,
                        repeat: false,
                      )
                    : Image.asset(
                        AppImages.icChildTaskDescription,
                        width: 24,
                        fit: BoxFit.cover,
                      );
              },
            ),
          ),
          Expanded(
            child: WordCounterTextField(
              controller: _viewModel.commentController,
              focusNode: _viewModel.commentFocusNode,
              hintText: allTranslations.text(AppLanguages.writeADescription),
              hintStyle: TextStyle(
                fontSize: AppFontSize.textButton,
                color: AppColors.header,
              ),
              onFieldSubmitted: (_) {
                showAnimDescription.value =
                    _viewModel.commentController.text.isNotEmpty;
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTagSomeone(BuildContext context) {
    return SizedBox(
      height: 30,
      child: Row(
        children: <Widget>[
          Container(
            alignment: Alignment.centerLeft,
            width: 35,
            child: ValueListenableBuilder<bool>(
              valueListenable: showAnimTag,
              builder: (_, value, __) {
                return value
                    ? Lottie.asset(
                        AppImages.animTagSomeOne,
                        width: 20,
                        repeat: false,
                      )
                    : Image.asset(
                        AppImages.icChildTaskTagSomeone,
                        width: 16,
                        fit: BoxFit.cover,
                      );
              },
            ),
          ),
          Expanded(
            child: InkWell(
              onTap: () => _showEmployeesDialog(context),
              child: StreamBuilder<String>(
                stream: _viewModel.employeeSubject,
                builder: (context, snapShot) {
                  var data = snapShot.data ?? "";
                  return Text(
                    data.isEmpty
                        ? allTranslations.text(AppLanguages.tagSomeone)
                        : data,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: AppFontSize.textButton,
                      color: data.isEmpty ? AppColors.header : AppColors.normal,
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

  void _showEmployeesDialog(BuildContext context) {
    FocusScope.of(context).unfocus();
    showModalBottomSheetCustom(
      context: context,
      builder: (context) => EmployeeListDialog(
        isEmployee: true,
        employeesSelected: _viewModel.employees ?? [],
        onCallBack: (employee) {
          FocusScope.of(context).unfocus();
          _viewModel.setEmployees(employee);
          showAnimTag.value = employee.isNotEmpty;
        },
      ),
    );
  }

  void _showDatePicker(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      backgroundColor: AppColors.bgColor,
      context: context,
      builder: (BuildContext context) {
        var startDate = _viewModel.startDateHour ?? DateTime.now();
        var endDate = _viewModel.endDateHour;
        _viewModel.setDate(
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
          onCallBack:
              (startDay, startMonth, startYear, endDay, endMonth, endYear) {
            _viewModel.setDate(
              startDay,
              startMonth,
              startYear,
              endDay,
              endMonth,
              endYear,
            );
          },
        );
      },
    ).then((_) {
      showAnimDate.value = _viewModel.startDateHour != null;
    });
  }
}
