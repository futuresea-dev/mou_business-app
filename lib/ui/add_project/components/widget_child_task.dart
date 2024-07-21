import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mou_business_app/core/databases/app_database.dart';
import 'package:mou_business_app/core/databases/dao/employee_dao.dart';
import 'package:mou_business_app/ui/widgets/slidable/app_slidable.dart';
import 'package:mou_business_app/ui/widgets/widget_image_network.dart';
import 'package:mou_business_app/utils/app_colors.dart';
import 'package:mou_business_app/utils/app_font_size.dart';
import 'package:mou_business_app/utils/app_images.dart';
import 'package:mou_business_app/utils/types/slidable_action_type.dart';
import 'package:provider/provider.dart';

class WidgetChildTask extends StatefulWidget {
  const WidgetChildTask({
    super.key,
    required this.task,
    required this.onEdit,
    required this.onDelete,
  });

  final Task task;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  @override
  State<WidgetChildTask> createState() => _WidgetChildTaskState();
}

class _WidgetChildTaskState extends State<WidgetChildTask> {
  Task get task => widget.task;

  List get employees => task.employees ?? [];

  DateTime? get startDate =>
      task.startDate?.isNotEmpty == true ? DateTime.parse(task.startDate ?? "") : null;

  DateTime? get endDate =>
      task.endDate?.isNotEmpty == true ? DateTime.parse(task.endDate ?? "") : null;

  Stream<List<Employee>> watchAllEmployees() {
    final EmployeeDao employeeDao = Provider.of(context);
    return employeeDao.watchAllEmployees();
  }

  @override
  Widget build(BuildContext context) {
    return AppSlidable<SlidableActionType>(
      key: ValueKey(widget.task.id),
      actions: [
        SlidableActionType.EDIT,
        SlidableActionType.DELETE,
      ],
      onActionPressed: (type) {
        return switch (type) {
          SlidableActionType.EXPORT => null,
          SlidableActionType.EDIT => widget.onEdit.call(),
          SlidableActionType.DELETE => widget.onDelete.call(),
          SlidableActionType.ACCEPT => null,
          SlidableActionType.DENY => null,
        };
      },
      child: Container(
        padding: const EdgeInsets.only(top: 9, bottom: 9, left: 14, right: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              AppColors.menuBar.withOpacity(.6),
              Colors.white,
            ],
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    task.title,
                    style: TextStyle(
                      fontSize: AppFontSize.textButton,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey.shade700,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  startDate != null ? DateFormat("dd/MM").format(startDate!) : "",
                  style: TextStyle(color: Colors.grey.shade700),
                ),
                const SizedBox(width: 10),
                Text(
                  endDate != null ? DateFormat("dd/MM").format(endDate!) : "",
                  style: TextStyle(color: Colors.grey.shade700),
                ),
              ],
            ),
            const SizedBox(height: 6),
            SizedBox(
              height: 31,
              child: Row(
                children: [
                  Expanded(
                    child: StreamBuilder<List<Employee>>(
                      stream: watchAllEmployees(),
                      builder: (context, snapshot) {
                        List<Employee> localEmployees = snapshot.data ?? [];

                        return ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: employees.length,
                          separatorBuilder: (context, index) => const SizedBox(width: 8),
                          itemBuilder: (context, index) {
                            final employee = localEmployees
                                .firstWhereOrNull((e) => e.id == employees[index].id);
                            final contact = employee?.contact;

                            return contact != null
                                ? WidgetImageNetwork(url: contact["avatar"] ?? '')
                                : const SizedBox();
                          },
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: 10),
                  if (task.comment?.isNotEmpty ?? false)
                    Tooltip(
                      key: ValueKey('comment ${task.id}'),
                      message: task.comment,
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      showDuration: const Duration(seconds: 3),
                      verticalOffset: 12,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.9),
                        borderRadius: BorderRadius.circular(9),
                        border: Border.all(color: AppColors.textPlaceHolder),
                      ),
                      textStyle: TextStyle(color: AppColors.normal),
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      child: Image.asset(
                        AppImages.icCommentActive,
                        color: const Color(0xFF919090),
                        width: 28,
                        fit: BoxFit.cover,
                      ),
                      triggerMode: TooltipTriggerMode.tap,
                    ),
                  const SizedBox(width: 10),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
