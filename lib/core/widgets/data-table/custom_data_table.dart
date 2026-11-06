import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:two_dashboard/config/constants/sizes_config.dart';
import 'package:two_dashboard/config/theme/color.dart';
import 'package:two_dashboard/config/theme/text_style.dart';
import 'package:two_dashboard/core/widgets/animation/empty_status_animation.dart';

class CustomDataTable extends StatelessWidget {
  const CustomDataTable({super.key, required this.columns, required this.rows});
  final List<DataColumn> columns;
  final List<DataRow> rows;

  @override
  Widget build(BuildContext context) {
    return DataTable2(
      clipBehavior: Clip.antiAlias,
      empty: const EmptyStatusAnimation(),
      isVerticalScrollBarVisible: true,
      isHorizontalScrollBarVisible: true,
      horizontalMargin: 16.0,
      columnSpacing: 16.0,
      dataRowHeight: 72.0,
      minWidth: 1000,
      dividerThickness: 0,
      headingRowHeight: 64.0,
      headingTextStyle: AppTextStyle.bodyMd(),
      headingRowColor: WidgetStateColor.resolveWith(
        (states) => AppColors.blueShade1,
      ),
      headingRowDecoration: const BoxDecoration(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(SizesConfig.borderRadiusSm),
        ),
      ),
      datarowCheckboxTheme: CheckboxThemeData(),
      border: TableBorder(
        horizontalInside: BorderSide(color: AppColors.white, width: 2),
      ),
      dataRowColor: WidgetStateColor.resolveWith((states) => AppColors.gray),
      columns: columns,
      rows: rows,
    );
  }
}
