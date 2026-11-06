import 'package:flutter/material.dart';
import 'package:two_dashboard/config/constants/padding_config.dart';
import 'package:two_dashboard/config/theme/text_style.dart';
import 'package:two_dashboard/core/widgets/container/custom_rounder_container.dart';
import 'package:two_dashboard/core/widgets/texts/page_title.dart';
import 'package:two_dashboard/features/dashboard/presentation/widgets/project_status_pie_chart.dart';
import 'package:two_dashboard/features/dashboard/presentation/widgets/project_summary_card.dart';

import '../widgets/project_category_bar_chart.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: PaddingConfig.pagePadding,
          child: Column(
            children: [
              // Heading
              PageTitle(pageTitle: "Dashboard"),
              PaddingConfig.h16,
              // Cards
              ProjectSummaryCard(),
              PaddingConfig.h16,
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Bar Graph
                        ProjectCategoryBarChart(),
                        PaddingConfig.h24,
                        // Tasks
                        CustomRounderContainer(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "To-Day Tasks",
                                style: AppTextStyle.bodyXs(),
                              ),
                              PaddingConfig.h16,
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  PaddingConfig.w32,
                  // Pie chart
                  Expanded(child: ProjectStatusPieChart()),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
