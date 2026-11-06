import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:two_dashboard/config/theme/text_style.dart';
import 'package:two_dashboard/core/network/enums.dart';
import 'package:two_dashboard/core/widgets/buttons/hovered-buttons/accept_button.dart';
import 'package:two_dashboard/core/widgets/container/status-containers/field_status_container.dart';
import 'package:two_dashboard/core/widgets/texts/linked_text.dart';
import 'package:two_dashboard/features/posts/domain/entities/reply_entity.dart';
import 'package:two_dashboard/features/posts/presentation/bloc/post_bloc.dart';

class PostRepliesRows extends DataTableSource {
  final List<ReplyEntity> repliesList;
  BuildContext context;

  PostRepliesRows({required this.repliesList, required this.context});
  @override
  DataRow? getRow(int index) {
    final reply = repliesList[index];
    return DataRow2(
      onTap: () {},
      selected: false,
      onSelectChanged: (value) {},
      cells: [
        DataCell(
          Text(reply.fullName, style: AppTextStyle.dataTableCellStyle()),
        ),
        DataCell(Text(reply.email, style: AppTextStyle.dataTableCellStyle())),
        DataCell(Text(reply.phone, style: AppTextStyle.dataTableCellStyle())),
        DataCell(LinkedText(link: reply.cvFile)),
        DataCell(FieldStatusContainer(fieldStatus: FieldStatus.unApproved)),
        DataCell(
          AcceptButton(
            onTap: () {
              context.read<PostBloc>().add(
                AcceptReplyEvent(replyId: repliesList[index].id),
              );
            },
          ),
        ),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => repliesList.length;

  @override
  int get selectedRowCount => 0;
}
