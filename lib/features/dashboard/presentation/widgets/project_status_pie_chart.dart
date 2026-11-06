import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:two_dashboard/config/constants/padding_config.dart';
import 'package:two_dashboard/config/theme/color.dart';
import 'package:two_dashboard/config/theme/text_style.dart';
import 'package:two_dashboard/core/widgets/container/custom_circular_container.dart';
import 'package:two_dashboard/core/widgets/container/custom_rounder_container.dart';

class ProjectStatusPieChart extends StatelessWidget {
  const ProjectStatusPieChart({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomRounderContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Project Status", style: AppTextStyle.bodyXs()),
          PaddingConfig.h16,
          // Graph
          SizedBox(
            height: 350,
            child: PieChart(
              PieChartData(
                sections: List.generate(
                  6,
                  (index) => PieChartSectionData(
                    title: "$index",
                    value: 60,
                    radius: 100,
                    color: AppColors.greenShade1,
                  ),
                ),
                pieTouchData: PieTouchData(
                  touchCallback: (p0, p1) {},
                  enabled: true,
                ),
              ),
            ),
          ),
          PaddingConfig.h24,
          // show status and color meta
          SizedBox(
            width: double.infinity,
            child: DataTable(
              columns: const [
                DataColumn(label: Text("Status")),
                DataColumn(label: Text("Projects")),
                DataColumn(label: Text("Total")),
              ],
              rows: List.generate(
                4,
                (index) => DataRow(
                  cells: [
                    // Meta Color and the title
                    DataCell(
                      Row(
                        children: [
                          CustomCircularContainer(
                            width: 20,
                            height: 20,
                            baskgroundColor: AppColors.greenShade2,
                          ),
                          PaddingConfig.w8,
                          Expanded(child: Text("Done")),
                        ],
                      ),
                    ),
                    // Project Count
                    DataCell(Center(child: Text("20"))),
                    DataCell(Center(child: Text("120"))),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
