import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:two_dashboard/core/widgets/container/custom_rounder_container.dart';

import '../../../../config/constants/padding_config.dart';
import '../../../../config/constants/sizes_config.dart';
import '../../../../config/theme/color.dart';
import '../../../../config/theme/text_style.dart';
import '../../../../core/functions/device_utility.dart';

class ProjectCategoryBarChart extends StatelessWidget {
  const ProjectCategoryBarChart({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomRounderContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Project Category", style: AppTextStyle.bodyXs()),
          PaddingConfig.h24,
          SizedBox(
            height: 300,
            child: BarChart(
              BarChartData(
                titlesData: buildFlTitleData(),
                borderData: FlBorderData(
                  show: true,
                  border: Border(top: BorderSide.none, right: BorderSide.none),
                ),
                gridData: FlGridData(
                  show: true,
                  drawHorizontalLine: true,
                  drawVerticalLine: true,
                  horizontalInterval: 200,
                ),
                barGroups: List.generate(
                  7,
                  (index) => BarChartGroupData(
                    x: index,
                    barRods: [
                      BarChartRodData(
                        toY: (20 * index).toDouble(),
                        width: 25,
                        color: AppColors.greenShade2,
                        borderRadius: BorderRadius.circular(
                          SizesConfig.borderRadiusSm,
                        ),
                      ),
                    ],
                  ),
                ),
                groupsSpace: SizesConfig.spaceBtwItems,
                barTouchData: BarTouchData(
                  touchTooltipData: BarTouchTooltipData(
                    getTooltipColor: (_) => AppColors.navy,
                  ),
                  touchCallback:
                      DeviceUtility.isDesktopScreen(context)
                          ? (p0, p1) {}
                          : null,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  FlTitlesData buildFlTitleData() => FlTitlesData(
    show: true,
    bottomTitles: AxisTitles(
      sideTitles: SideTitles(
        showTitles: true,
        getTitlesWidget: (value, meta) {
          // Map index to the desired day of the week
          final days = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];

          // calculte the index and ensure it wraps around for the correct day
          final index = value.toInt() % days.length;

          // Get the day corresponding to the calcuated index
          final day = days[index];
          return SideTitleWidget(space: 0, meta: meta, child: Text(day));
        },
      ),
    ),
    leftTitles: AxisTitles(
      sideTitles: SideTitles(showTitles: true, interval: 200, reservedSize: 50),
    ),
    rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
    topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
  );
}
