import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:two_dashboard/config/theme/text_style.dart';
import 'package:two_dashboard/core/widgets/dialog/why-us-about-us/update_why_us_dialog.dart';
import 'package:two_dashboard/features/about-us%20&%20why-us/domain/entities/why_us_entity.dart';

import '../../../../../config/constants/padding_config.dart';
import '../../../../../features/about-us & why-us/presentation/bloc/about_us_why_us_bloc.dart';
import '../../../buttons/hovered-buttons/delete_button.dart';
import '../../../buttons/hovered-buttons/edit_button.dart';
import '../../../dialog/global/confirm_deletion_dialog.dart';

class WhyUsRows extends DataTableSource {
  final List<WhyUsEntity?> whyUsList;
  BuildContext context;
  WhyUsRows({required this.whyUsList, required this.context});
  @override
  DataRow? getRow(int index) {
    final whyUs = whyUsList[index];
    return DataRow2(
      onTap: () {},
      selected: false,
      onSelectChanged: (value) {},
      cells: [
        DataCell(
          Text("${whyUs!.whyUsId}", style: AppTextStyle.dataTableCellStyle()),
        ),
        DataCell(
          Text(whyUs.whyUsDoc, style: AppTextStyle.dataTableCellStyle()),
        ),
        DataCell(
          Row(
            children: [
              EditButton(
                onTap: () {
                  updateWhyUsDialog(
                    context,
                    TextEditingController(text: whyUsList[index]!.whyUsDoc),
                    whyUsList[index]!.whyUsId,
                  );
                },
              ),
              PaddingConfig.w16,
              DeleteButton(
                onTap: () {
                  confirmDeletionDialog(
                    context,
                    whyUsList[index]!.whyUsDoc,
                    () {
                      context.read<AboutUsWhyUsBloc>().add(
                        DeleteWhyUsEvent(whyUsId: whyUsList[index]!.whyUsId),
                      );
                      context.pop();
                    },
                  );
                },
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
  int get rowCount => whyUsList.length;

  @override
  int get selectedRowCount => 0;
}
