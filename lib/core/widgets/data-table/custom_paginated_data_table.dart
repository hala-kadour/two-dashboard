import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:two_dashboard/config/constants/sizes_config.dart';
import 'package:two_dashboard/config/theme/color.dart';
import 'package:two_dashboard/config/theme/text_style.dart';
import 'package:two_dashboard/core/widgets/animation/empty_status_animation.dart';

class CustomPaginatedDataTable extends StatelessWidget {
  const CustomPaginatedDataTable({
    super.key,
    required this.columns,
    required this.source,
    this.rowsPerPage = 10,
    this.tableHeight = SizesConfig.tableHeight,
    this.onPageChanges,
    this.onRowsPerPageChanged,
    this.sortColumnIndex,
    this.dataRowHeight = SizesConfig.xl * 2,
    this.sortAsending = true,
    this.minWidth = SizesConfig.tablMinWidth,
  });
  // whether to sort the DataTable in ascending or descending order;
  final bool sortAsending;

  // Index of the column to sort by
  final int? sortColumnIndex;

  //Number of rows to display pre page
  final int rowsPerPage;

  // Data source for the DataTable
  final DataTableSource source;

  //List of the columns for the DataTable
  final List<DataColumn> columns;

  // callback function to handle page changes
  final Function(int)? onPageChanges;

  // On Row selected
  final void Function(int?)? onRowsPerPageChanged;

  // Height of each data row in the DataTable
  final double dataRowHeight;

  // Height of the entrie DataTable
  final double tableHeight;

  // Minimum width of the entire DataTable
  final double? minWidth;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: tableHeight,
      child: Theme(
        data: Theme.of(context).copyWith(
          cardTheme: CardThemeData(color: AppColors.white, elevation: 0),
        ),
        child: PaginatedDataTable2(
          source: source,

          // COLUMNS & ROWS
          columns: columns,
          columnSpacing: 12,
          minWidth: minWidth,
          dividerThickness: 0,
          horizontalMargin: 12,
          rowsPerPage: rowsPerPage,
          dataRowHeight: dataRowHeight,

          // CHECKBOX
          showCheckboxColumn: false,

          // PAGINATION
          showFirstLastButtons: true,
          onPageChanged: onPageChanges,
          renderEmptyRowsInTheEnd: false,
          onRowsPerPageChanged: (noOfRows) {},

          // HEADER DESIGN
          headingTextStyle: AppTextStyle.bodySm(),
          headingRowColor: WidgetStateColor.resolveWith(
            (states) => AppColors.blueShade1,
          ),
          headingRowDecoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(SizesConfig.borderRadiusMd),
              topRight: Radius.circular(SizesConfig.borderRadiusMd),
            ),
          ),
          empty: EmptyStatusAnimation(),

          // Data Style
          dataTextStyle: AppTextStyle.dataTableCellStyle(),

          // SORTING
          sortAscending: sortAsending,
          sortColumnIndex: sortColumnIndex,
          sortArrowBuilder: (ascending, sorted) {
            if (sorted) {
              return Icon(
                ascending ? Iconsax.arrow_up_3 : Iconsax.arrow_down,
                size: SizesConfig.iconsSm,
              );
            } else {
              return const Icon(Iconsax.arrow_3, size: SizesConfig.iconsSm);
            }
          },
        ),
      ),
    );
  }
}
