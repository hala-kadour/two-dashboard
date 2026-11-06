import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:two_dashboard/config/constants/sizes_config.dart';
import 'package:two_dashboard/config/strings/text_strings.dart';
import 'package:two_dashboard/core/widgets/data-table/custom/contracts/cm_contract_table_source.dart';
import 'package:two_dashboard/core/widgets/data-table/custom_paginated_data_table.dart';
import 'package:two_dashboard/features/contracts/data/models/contract_model.dart';

class CMContractTable extends StatelessWidget {
  const CMContractTable({super.key, required this.contractList});
  final List<ContractModel?> contractList;

  @override
  Widget build(BuildContext context) {
    return CustomPaginatedDataTable(
      minWidth: 700,
      tableHeight: 500,
      dataRowHeight: SizesConfig.xl * 2.2,
      columns: [
        DataColumn2(label: Text(TextStrings.id)),
        DataColumn2(label: Text(TextStrings.contract)),
        DataColumn2(label: Text(TextStrings.contractManagerApprovment)),
        DataColumn2(label: Text(TextStrings.projectManagerApprovment)),
        DataColumn2(label: Text(TextStrings.status)),
        DataColumn2(label: Text(TextStrings.doesNeedEdit)),
        DataColumn2(label: Text(TextStrings.adminSign)),
        DataColumn2(label: Text(TextStrings.actions)),
      ],
      source: CMContractRows(contractList: contractList, context: context),
    );
  }
}
