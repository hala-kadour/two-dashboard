import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:two_dashboard/config/constants/padding_config.dart';
import 'package:two_dashboard/config/routes/app_route_config.dart';
import 'package:two_dashboard/config/theme/text_style.dart';
import 'package:two_dashboard/core/network/enums.dart';
import 'package:two_dashboard/core/widgets/buttons/hovered-buttons/approved_button.dart';
import 'package:two_dashboard/core/widgets/buttons/hovered-buttons/edit_button.dart';
import 'package:two_dashboard/core/widgets/container/status-containers/dynamic_status_container.dart';
import 'package:two_dashboard/core/widgets/container/status-containers/field_status_container.dart';
import 'package:two_dashboard/core/widgets/dialog/contract/contract_details_dialog.dart';
import 'package:two_dashboard/core/widgets/texts/linked_text.dart';
import 'package:two_dashboard/features/contracts/data/models/contract_model.dart';
import 'package:two_dashboard/features/contracts/presentation/bloc/contract_bloc.dart';

class CMContractRows extends DataTableSource {
  final List<ContractModel?> contractList;
  BuildContext context;

  CMContractRows({required this.contractList, required this.context});
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
          FieldStatusContainer(
            fieldStatus:
                (contract.contractManagerStatus == 0 ||
                        contract.contractManagerStatus == null)
                    ? FieldStatus.unApproved
                    : FieldStatus.approved,
          ),
        ),
        DataCell(
          FieldStatusContainer(
            fieldStatus:
                (contract.projectManagerStatus == 0 ||
                        contract.projectManagerStatus == null)
                    ? FieldStatus.unApproved
                    : FieldStatus.approved,
          ),
        ),
        DataCell(
          DynamicStatusContainer(
            status: contract.status == 0 ? "Not Approved" : "Approved",
          ),
        ),
        DataCell(
          FieldStatusContainer(
            fieldStatus:
                (contract.needEdit == 0 || contract.needEdit == null)
                    ? FieldStatus.nonNeeded
                    : FieldStatus.needed,
          ),
        ),
        DataCell(
          DynamicStatusContainer(
            status: contract.adminSign == 0 ? "Un Signed" : "Signed",
          ),
        ),
        DataCell(
          Row(
            children: [
              ApprovedButton(
                onTap: () {
                  context.read<ContractBloc>().add(
                    ContractManagerApproveContractEvent(
                      contractId: contract.id,
                      projectId: contract.project.id,
                    ),
                  );
                },
              ),
              PaddingConfig.w8,
              EditButton(
                onTap:
                    () => context.pushNamed(
                      AppRouteConfig.cmUpdateContract,
                      pathParameters: {'id': contract.id.toString()},
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
  int get rowCount => contractList.length;

  @override
  int get selectedRowCount => 0;
}
