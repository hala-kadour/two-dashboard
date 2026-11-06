import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:two_dashboard/config/constants/padding_config.dart';
import 'package:two_dashboard/config/routes/app_route_config.dart';
import 'package:two_dashboard/config/theme/color.dart';
import 'package:two_dashboard/config/theme/text_style.dart';
import 'package:two_dashboard/core/helper/helper_functions.dart';
import 'package:two_dashboard/core/widgets/buttons/hovered-buttons/delete_button.dart';
import 'package:two_dashboard/core/widgets/buttons/hovered-buttons/edit_button.dart';
import 'package:two_dashboard/core/widgets/container/status-containers/dynamic_status_container.dart';
import 'package:two_dashboard/core/widgets/container/status-containers/priority_container.dart';
import 'package:two_dashboard/core/widgets/container/status-containers/task_status_container.dart';
import 'package:two_dashboard/core/widgets/dialog/global/confirm_deletion_dialog.dart';
import 'package:two_dashboard/core/widgets/images/fetch_network_image.dart';
import 'package:two_dashboard/features/sprints%20&%20tasks/domain/entity/task_entity.dart';
import 'package:two_dashboard/features/sprints%20&%20tasks/presentation/bloc/sprint_and_task_bloc.dart';

class TaskRows extends DataTableSource {
  final List<TaskEntity> taskList;
  BuildContext context;

  TaskRows({required this.taskList, required this.context});
  @override
  DataRow? getRow(int index) {
    final task = taskList[index];
    return DataRow2(
      onTap: () => context.pushNamed(AppRouteConfig.taskDetails, extra: task),
      selected: false,
      onSelectChanged: (value) {},
      cells: [
        DataCell(Text("${task.id}", style: AppTextStyle.dataTableCellStyle())),
        DataCell(Text(task.title, style: AppTextStyle.dataTableCellStyle())),
        DataCell(
          Text(task.description, style: AppTextStyle.dataTableCellStyle()),
        ),
        DataCell(DynamicStatusContainer(status: task.sprintLabel ?? "Backlog")),
        DataCell(TaskStatusContainer(taskStatus: task.taskStatus)),
        DataCell(PriorityContainer(priority: task.taskPriority)),
        DataCell(
          Text(
            HelperFunctions.formatDate(task.endDate),
            style: AppTextStyle.dataTableCellStyle(),
          ),
        ),
        DataCell(
          Row(
            children: [
              // image
              FetchNetworkImage(
                height: 35,
                width: 35,
                shape: BoxShape.circle,
                imagePath: task.assignedUser.image,
              ),
              // Name and Role
              Text(
                "${task.assignedUser.name}(You)",
                style: AppTextStyle.bodyXs(color: AppColors.fontDarkGray),
              ),
            ],
          ),
        ),
        DataCell(
          Row(
            children: [
              EditButton(
                onTap:
                    () => context.pushNamed(
                      AppRouteConfig.updateTask,
                      extra: task,
                    ),
              ),
              PaddingConfig.w8,
              DeleteButton(
                onTap:
                    () => confirmDeletionDialog(
                      context,
                      "Task",
                      () => context.read<SprintAndTaskBloc>().add(
                        DeleteTaskEvent(taskId: task.id),
                      ),
                    ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => taskList.length;

  @override
  int get selectedRowCount => 0;
}
