import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:two_dashboard/config/constants/sizes_config.dart';
import 'package:two_dashboard/config/strings/text_strings.dart';
import 'package:two_dashboard/core/widgets/data-table/custom/project/assigned/assigned_project_table_source.dart';
import 'package:two_dashboard/core/widgets/data-table/custom_paginated_data_table.dart';
import 'package:two_dashboard/features/projects%20&%20team%20&%20status%20&%20meeting/data/models/project/project_assign_request_model.dart';

class AssignedProjectTable extends StatelessWidget {
  const AssignedProjectTable({super.key, required this.projectList});
  final List<ProjectAssignRequestModel> projectList;

  @override
  Widget build(BuildContext context) {
    return CustomPaginatedDataTable(
      tableHeight: 500,
      dataRowHeight: SizesConfig.xl * 2.2,
      columns: [
        DataColumn2(label: Text(TextStrings.type)),
        DataColumn2(label: Text(TextStrings.status)),
        DataColumn2(label: Text(TextStrings.visibility)),
        DataColumn2(label: Text(TextStrings.description)),
        DataColumn2(label: Text(TextStrings.coopertion)),
        DataColumn2(label: Text(TextStrings.documents)),
        DataColumn2(label: Text(TextStrings.actions)),
      ],
      source: AssignedProjectRows(
        assignProjectList: projectList,
        context: context,
      ),
    );
  }
}
