import 'package:flutter/material.dart';
import 'package:mou_business_app/core/models/employee.dart';
import 'package:mou_business_app/core/models/task_detail.dart';
import 'package:mou_business_app/utils/app_colors.dart';
import 'package:mou_business_app/utils/app_font_size.dart';
import 'package:mou_business_app/utils/app_images.dart';

class ChildTaskView extends StatelessWidget {
  final TaskDetail task;

  ChildTaskView({required this.task});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Column(
            children: <Widget>[
              this._buildWriteTitle(context),
              this._buildStartDateHour(context),
              this._buildEndDateHour(context),
              this._buildWriteADescription(context),
              this._buildTagSomeone(context)
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildWriteTitle(BuildContext context) {
    return Container(
      height: 45,
      child: Row(
        children: <Widget>[
          Container(
            alignment: Alignment.centerLeft,
            width: 50,
            child: Image.asset(
              AppImages.icChildTaskTitle,
              height: 18.5,
              width: 16,
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
            child: Container(
              child: Text(
                this.task.title ?? "",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: AppFontSize.textButton,
                  color: AppColors.normal,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildStartDateHour(BuildContext context) {
    return Container(
      height: 45,
      child: Row(
        children: <Widget>[
          Container(
            alignment: Alignment.centerLeft,
            width: 50,
            child: Image.asset(
              AppImages.icChildTaskDateTime,
              height: 15.5,
              width: 15.5,
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
            child: Container(
              child: Text(
                this.task.startDate ?? "",
                style: TextStyle(
                    fontSize: AppFontSize.textButton, color: AppColors.normal),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildEndDateHour(BuildContext context) {
    var endDate = this.task.endDate ?? "";
    return endDate.isEmpty
        ? SizedBox()
        : Container(
            padding: const EdgeInsets.only(bottom: 12),
            alignment: Alignment.topLeft,
            child: Row(
              children: <Widget>[
                SizedBox(width: 50),
                Expanded(
                  child: Container(
                    child: Text(
                      endDate,
                      style: TextStyle(
                          fontSize: AppFontSize.textButton,
                          color: AppColors.normal),
                    ),
                  ),
                )
              ],
            ),
          );
  }

  Widget _buildWriteADescription(BuildContext context) {
    return Container(
      height: 45,
      child: Row(
        children: <Widget>[
          Container(
            alignment: Alignment.centerLeft,
            width: 50,
            child: Image.asset(
              AppImages.icChildTaskDescription,
              height: 8.5,
              width: 16.5,
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
              child: Text(
            this.task.comment ?? "",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: AppFontSize.textButton,
              color: AppColors.normal,
            ),
          ))
        ],
      ),
    );
  }

  Widget _buildTagSomeone(BuildContext context) {
    String employeesString = "";
    List<EmployeeDetail> employeesDetail = task.employees ?? [];

    var employeeNames = employeesDetail.map((e) => e.name).toList();
    var employeeNameJoin = employeeNames.join(", ");
    employeesString = employeeNameJoin;

    return Container(
      height: 45,
      child: Row(
        children: <Widget>[
          Container(
            alignment: Alignment.centerLeft,
            width: 50,
            child: Image.asset(
              AppImages.icChildTaskTagSomeone,
              width: 14.5,
              height: 16,
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
            child: Container(
              child: Text(
                employeesString,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontSize: AppFontSize.textButton,
                    color: employeesString == ""
                        ? AppColors.textPlaceHolder
                        : AppColors.normal),
              ),
            ),
          )
        ],
      ),
    );
  }
}
