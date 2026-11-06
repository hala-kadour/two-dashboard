import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:two_dashboard/config/routes/app_route_config.dart';
import 'package:two_dashboard/config/theme/text_style.dart';
import 'package:two_dashboard/core/widgets/buttons/hovered-buttons/sign_button.dart';
import 'package:two_dashboard/core/widgets/container/status-containers/dynamic_status_container.dart';
import 'package:two_dashboard/core/widgets/dialog/contract/contract_details_dialog.dart';
import 'package:two_dashboard/core/widgets/texts/linked_text.dart';
import 'package:two_dashboard/features/contracts/data/models/contract_model.dart';

class AdminContractTableSource extends DataTableSource {
  final List<ContractModel?> contractList;
  BuildContext context;

  AdminContractTableSource({required this.contractList, required this.context});
  @override
  DataRow? getRow(int index) {
    final contract = contractList[index];
    return DataRow2(
      onTap:
          () => showDialog(
            context: context,
            builder: (context) => ContractDetailsDialog(contract: contract),
          ),
      selected: false,
      onSelectChanged: (value) {},
      cells: [
        DataCell(
          Text("${contract!.id}", style: AppTextStyle.dataTableCellStyle()),
        ),
        DataCell(LinkedText(link: contract.contract)),
        DataCell(
          DynamicStatusContainer(
            status: contract.status == 0 ? "Not Approved" : "Approved",
          ),
        ),
        DataCell(
          DynamicStatusContainer(
            status: contract.adminSign == 0 ? "Un Signed" : "Signed",
          ),
        ),
        DataCell(
          SignButton(
            onTap:
                () => context.pushNamed(
                  AppRouteConfig.addSign,
                  pathParameters: {
                    'cId': contract.id.toString(),
                    'pId': contract.project.id.toString(),
                  },
                ),
          ),
        ),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => contractList.length;

  @override
  int get selectedRowCount => 0;
}
