import 'package:flutter/material.dart';
import 'package:two_dashboard/config/constants/padding_config.dart';
import 'package:two_dashboard/config/routes/app_route_config.dart';
import 'package:two_dashboard/core/widgets/breadcrumbs/breadcumbs_item.dart';
import 'package:two_dashboard/core/widgets/buttons/icon-buttons/back_button.dart';
import 'package:two_dashboard/core/widgets/divider/custom_page_divider.dart';
import 'package:two_dashboard/core/widgets/layouts/templates/page_template.dart';
import 'package:two_dashboard/core/widgets/texts/page_title.dart';
import 'package:two_dashboard/features/sprints%20&%20tasks/presentation/widgets/create_task_form.dart';

class CreateTaskPage extends StatelessWidget {
  const CreateTaskPage({
    super.key,
    required this.projectId,
    required this.sprintId,
  });
  final String projectId;
  final String sprintId;

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      child: SingleChildScrollView(
        child: Column(
          children: [
            const Breadcrumbs(
              paths: [
                AppRouteConfig.allProjects,
                AppRouteConfig.projectDetails,
                AppRouteConfig.sprintDetails,
                AppRouteConfig.createTask,
              ],
              pages: [
                "All Project",
                "Project Details",
                "Sprint Details",
                "Create Task",
              ],
            ),
            PaddingConfig.h16,
            Row(
              children: [
                const CustomBackButton(),
                PaddingConfig.w8,
                PageTitle(pageTitle: "Create Task"),
              ],
            ),
            CustomPageDivider(),
            PaddingConfig.h24,
            CreateTaskForm(
              projectId: int.parse(projectId),
              sprintId: int.parse(sprintId),
            ),
          ],
        ),
      ),
    );
  }
}
