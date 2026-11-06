import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:two_dashboard/config/constants/sizes_config.dart';
import 'package:two_dashboard/config/strings/text_strings.dart';
import 'package:two_dashboard/core/widgets/data-table/custom/why-us/why_us_table_source.dart';
import 'package:two_dashboard/core/widgets/data-table/custom_paginated_data_table.dart';
import 'package:two_dashboard/features/about-us%20&%20why-us/domain/entities/why_us_entity.dart';

class WhyUsTable extends StatelessWidget {
  const WhyUsTable({super.key, required this.whyUsList});
  final List<WhyUsEntity?> whyUsList;

  @override
  Widget build(BuildContext context) {
    return CustomPaginatedDataTable(
      minWidth: 700,
      tableHeight: 500,
      dataRowHeight: SizesConfig.xl * 1.2,
      columns: [
        DataColumn2(label: Text(TextStrings.id)),
        DataColumn2(label: Text(TextStrings.title)),
        DataColumn2(label: Text(TextStrings.actions)),
      ],
      source: WhyUsRows(whyUsList: whyUsList, context: context),
    );
  }
}
