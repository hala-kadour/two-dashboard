import 'package:flutter/material.dart';
import 'package:two_dashboard/config/constants/padding_config.dart';
import 'package:two_dashboard/config/routes/app_route_config.dart';
import 'package:two_dashboard/core/widgets/breadcrumbs/breadcumbs_item.dart';
import 'package:two_dashboard/core/widgets/buttons/icon-buttons/back_button.dart';
import 'package:two_dashboard/core/widgets/divider/custom_page_divider.dart';
import 'package:two_dashboard/core/widgets/layouts/templates/page_template.dart';
import 'package:two_dashboard/core/widgets/texts/page_title.dart';
import 'package:two_dashboard/features/sprints%20&%20tasks/presentation/widgets/create_sprint_form.dart';

class CreateSprintPage extends StatelessWidget {
  const CreateSprintPage({super.key, required this.projectId});
  final String projectId;

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
                AppRouteConfig.createSprint,
              ],
              pages: ["All Project", "Project Details", "Create Sprint"],
            ),
            PaddingConfig.h16,
            Row(
              children: [
                const CustomBackButton(),
                PaddingConfig.w8,
                PageTitle(pageTitle: "Create Sprint"),
              ],
            ),
            CustomPageDivider(),
            PaddingConfig.h24,
            CreateSprintForm(projectId: int.parse(projectId)),
          ],
        ),
      ),
    );
  }
}
