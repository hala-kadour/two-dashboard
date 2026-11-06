import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:two_dashboard/config/constants/padding_config.dart';
import 'package:two_dashboard/config/theme/text_style.dart';
import 'package:two_dashboard/core/widgets/buttons/hovered-buttons/add_somthing_button.dart';
import 'package:two_dashboard/core/widgets/images/fetch_network_image.dart';
import 'package:two_dashboard/features/profile/domain/entities/employee_entity.dart';

class SelectEmployeeRows extends DataTableSource {
  final List<EmployeeEntity> employeeList;
  final void Function(EmployeeEntity employee) onTapForManager;
  final void Function(EmployeeEntity employee) onTapForMember;
  BuildContext context;

  SelectEmployeeRows({
    required this.employeeList,
    required this.context,
    required this.onTapForManager,
    required this.onTapForMember,
  });
  @override
  DataRow? getRow(int index) {
    final employee = employeeList[index];
    return DataRow2(
      onTap: () {},
      selected: false,
      onSelectChanged: (value) {},
      cells: [
        DataCell(
          FetchNetworkImage(
            height: 50,
            width: 50,
            shape: BoxShape.circle,
            imagePath: employee.image,
          ),
        ),
        DataCell(Text(employee.name, style: AppTextStyle.dataTableCellStyle())),
        DataCell(Text(employee.role, style: AppTextStyle.dataTableCellStyle())),
        DataCell(
          Row(
            children: [
              AddSomthingButton(
                onTap: () => onTapForManager(employee),
                something: "AS Mgr",
              ),
              PaddingConfig.w8,
              AddSomthingButton(
                onTap: () => onTapForMember(employee),
                something: "As Mem",
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
  int get rowCount => employeeList.length;

  @override
  int get selectedRowCount => 0;
}
