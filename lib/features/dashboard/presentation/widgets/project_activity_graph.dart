import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../../../config/theme/color.dart';

class ProjectActivityGraph extends StatelessWidget {
  const ProjectActivityGraph({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 600,
      height: 200,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
      ),
      child: LineChart(
        LineChartData(
          titlesData: FlTitlesData(show: false),
          gridData: FlGridData(show: false),
          borderData: FlBorderData(show: false),
          lineBarsData: [
            LineChartBarData(
              isCurved: true,
              spots: const [
                FlSpot(0, 10),
                FlSpot(1, 14),
                FlSpot(2, 8),
                FlSpot(3, 16),
                FlSpot(4, 12),
                FlSpot(5, 17),
                FlSpot(6, 15),
              ],
              dotData: FlDotData(show: false),
              color: AppColors.grayShade2,
              barWidth: 3,
            ),
          ],
        ),
      ),
    );
  }
}
