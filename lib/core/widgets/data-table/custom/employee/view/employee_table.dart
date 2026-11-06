import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:two_dashboard/config/constants/sizes_config.dart';
import 'package:two_dashboard/config/strings/text_strings.dart';
import 'package:two_dashboard/core/widgets/data-table/custom/employee/view/employee_table_source.dart';
import 'package:two_dashboard/core/widgets/data-table/custom_paginated_data_table.dart';
import 'package:two_dashboard/features/profile/domain/entities/employee_entity.dart';

class EmployeeTable extends StatelessWidget {
  const EmployeeTable({super.key, required this.employeeList});
  final List<EmployeeEntity> employeeList;

  @override
  Widget build(BuildContext context) {
    return CustomPaginatedDataTable(
      minWidth: 700,
      tableHeight: 500,
      dataRowHeight: SizesConfig.xl * 2.2,
      columns: [
        DataColumn2(label: Text(TextStrings.id)),
        DataColumn2(label: Text(TextStrings.name)),
        DataColumn2(label: Text(TextStrings.email)),
        DataColumn2(label: Text(TextStrings.profile)),
        DataColumn2(label: Text(TextStrings.role)),
        DataColumn2(label: Text(TextStrings.cv)),
        DataColumn2(label: Text(TextStrings.status)),
        DataColumn2(label: Text(TextStrings.actions)),
      ],
      source: EmployeeRows(employeeList: employeeList, context: context),
    );
  }
}
