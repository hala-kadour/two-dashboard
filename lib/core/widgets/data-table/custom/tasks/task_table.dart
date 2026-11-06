import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:two_dashboard/config/constants/sizes_config.dart';
import 'package:two_dashboard/config/strings/text_strings.dart';
import 'package:two_dashboard/core/widgets/data-table/custom_paginated_data_table.dart';
import 'package:two_dashboard/core/widgets/data-table/custom/tasks/task_table_source.dart';
import 'package:two_dashboard/features/sprints%20&%20tasks/domain/entity/task_entity.dart';

class TaskTable extends StatelessWidget {
  const TaskTable({super.key, required this.taskEntityList});
  final List<TaskEntity> taskEntityList;

  @override
  Widget build(BuildContext context) {
    return CustomPaginatedDataTable(
      minWidth: 700,
      tableHeight: 500,
      dataRowHeight: SizesConfig.xl * 1.2,
      columns: [
        DataColumn2(label: Text(TextStrings.id)),
        DataColumn2(label: Text(TextStrings.title)),
        DataColumn2(label: Text(TextStrings.description)),
        DataColumn2(label: Text(TextStrings.sprint)),
        DataColumn2(label: Text(TextStrings.status)),
        DataColumn2(label: Text(TextStrings.priority)),
        DataColumn2(label: Text(TextStrings.deadLine)),
        DataColumn2(label: Text(TextStrings.assignedTo)),
        DataColumn2(label: Text(TextStrings.actions)),
      ],
      source: TaskRows(taskList: taskEntityList, context: context),
    );
  }
}
