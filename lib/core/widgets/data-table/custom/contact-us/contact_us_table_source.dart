import 'package:data_table_2/data_table_2.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:two_dashboard/config/constants/padding_config.dart';
import 'package:two_dashboard/config/theme/text_style.dart';
import 'package:two_dashboard/core/widgets/container/status-containers/field_status_container.dart';
import 'package:two_dashboard/features/contact-us/data/models/contact_us_model.dart';

import '../../../../../features/contact-us/presentation/bloc/contact_us_bloc.dart';
import '../../../../network/enums.dart';
import '../../../buttons/hovered-buttons/approved_button.dart';
import '../../../buttons/hovered-buttons/seen_button.dart';
import '../../../images/fetch_network_image.dart';

class ContactUsRows extends DataTableSource {
  final List<ContactUsModel?> contactUsList;
  BuildContext context;

  ContactUsRows({required this.contactUsList, required this.context});
  @override
  DataRow? getRow(int index) {
    final contactUs = contactUsList[index];
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
            imagePath: contactUs!.client.image,
          ),
        ),
        DataCell(
          Text(contactUs.client.name, style: AppTextStyle.dataTableCellStyle()),
        ),
        DataCell(
          Text(
            contactUs.client.email,
            style: AppTextStyle.dataTableCellStyle(),
          ),
        ),
        DataCell(
          Text(contactUs.phone, style: AppTextStyle.dataTableCellStyle()),
        ),
        DataCell(
          Text(contactUs.subject, style: AppTextStyle.dataTableCellStyle()),
        ),
        DataCell(
          (contactUs.seen == 1)
              ? FieldStatusContainer(fieldStatus: FieldStatus.seen)
              : FieldStatusContainer(fieldStatus: FieldStatus.nonSeen),
        ),
        DataCell(
          (contactUs.techApproved == 1)
              ? FieldStatusContainer(fieldStatus: FieldStatus.approved)
              : FieldStatusContainer(fieldStatus: FieldStatus.unApproved),
        ),
        DataCell(
          Row(
            children: [
              SeenButton(
                onTap: () {
                  context.read<ContactUsBloc>().add(
                    MarkContactUsAsSeenEvent(contactUsId: contactUs.id),
                  );
                  context.read<ContactUsBloc>().add(
                    GetContactUsWithSeenAndApprovedEvent(),
                  );
                },
              ),
              PaddingConfig.w16,
              ApprovedButton(
                onTap: () {
                  context.read<ContactUsBloc>().add(
                    MarkContactUsAsApprovedEvent(contactUsId: contactUs.id),
                  );
                  context.read<ContactUsBloc>().add(
                    GetContactUsWithSeenAndApprovedEvent(),
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
  int get rowCount => contactUsList.length;

  @override
  int get selectedRowCount => 0;
}
