import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:two_dashboard/config/constants/padding_config.dart';
import 'package:two_dashboard/config/routes/app_route_config.dart';
import 'package:two_dashboard/config/theme/color.dart';
import 'package:two_dashboard/config/theme/text_style.dart';
import 'package:two_dashboard/core/functions/bloc-state-handling/project_bloc_state_handling.dart';
import 'package:two_dashboard/core/functions/device_utility.dart';
import 'package:two_dashboard/core/widgets/buttons/elevated-buttons/complete_project_elevated_button.dart';
import 'package:two_dashboard/core/widgets/buttons/elevated-buttons/update_elevated_button.dart';
import 'package:two_dashboard/core/widgets/buttons/hovered-buttons/add_button.dart';
import 'package:two_dashboard/core/widgets/buttons/hovered-buttons/edit_button.dart';
import 'package:two_dashboard/core/widgets/container/status-containers/cooperation_type_container.dart';
import 'package:two_dashboard/core/widgets/container/status-containers/dynamic_status_container.dart';
import 'package:two_dashboard/core/widgets/container/status-containers/project_type_status_container.dart';
import 'package:two_dashboard/core/widgets/container/status-containers/visibility_status_container.dart';
import 'package:two_dashboard/core/widgets/dialog/project/add_project_deadline_dialog.dart';
import 'package:two_dashboard/features/projects%20&%20team%20&%20status%20&%20meeting/domain/entity/project_entity.dart';
import 'package:two_dashboard/features/projects%20&%20team%20&%20status%20&%20meeting/presentation/bloc/project_status_team_meeting_bloc.dart';

class SummaryTabBarView extends StatelessWidget {
  const SummaryTabBarView({super.key, required this.projectEntity});
  final ProjectEntity projectEntity;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                BlocListener<
                  ProjectStatusTeamMeetingBloc,
                  ProjectStatusTeamMeetingState
                >(
                  listenWhen:
                      (previous, current) =>
                          (previous.projectManagerCompleteProjectStatus !=
                              current.projectManagerCompleteProjectStatus) ||
                          (previous.projectManagerUpdateProjectDateStatus !=
                              current.projectManagerUpdateProjectDateStatus),
                  listener: (context, state) {
                    ProjectBlocStateHandling().completeProject(state, context);
                    ProjectBlocStateHandling().updateDeadline(state, context);
                  },
                  child: CompleteProjectElevatedButton(
                    projectId: projectEntity.id,
                  ),
                ),
                PaddingConfig.w8,
                UpdateElevatedButton(
                  updateType: "Project",
                  onPressed:
                      () => context.pushNamed(
                        AppRouteConfig.updateProject,
                        extra: projectEntity,
                      ),
                ),
              ],
            ),
            PaddingConfig.h24,
            Wrap(
              alignment: WrapAlignment.spaceBetween,
              runSpacing: 16,
              spacing: 12,
              children: [
                SizedBox(
                  width:
                      DeviceUtility.isMobileScreen(context)
                          ? double.infinity
                          : MediaQuery.of(context).size.width / 2.5 - 32,
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Iconsax.brush, color: AppColors.blueShade2),
                          PaddingConfig.w8,
                          Text(
                            "Project Type",
                            style: AppTextStyle.bodyMd(
                              color: AppColors.blueShade2,
                            ),
                          ),
                          SizedBox(width: 84),
                          ProjectTypeStatusContainer(
                            projectType: projectEntity.pType,
                          ),
                        ],
                      ),
                      PaddingConfig.h24,
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Iconsax.people, color: AppColors.blueShade2),
                          PaddingConfig.w8,
                          Text(
                            "Cooperation Type",
                            style: AppTextStyle.bodyMd(
                              color: AppColors.blueShade2,
                            ),
                          ),
                          SizedBox(width: 44),
                          CooperationTypeContainer(
                            cooperationType: projectEntity.cType,
                          ),
                        ],
                      ),
                      PaddingConfig.h24,
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Iconsax.eye, color: AppColors.blueShade2),
                          PaddingConfig.w8,
                          Text(
                            "Visibilty",
                            style: AppTextStyle.bodyMd(
                              color: AppColors.blueShade2,
                            ),
                          ),
                          SizedBox(width: 120),
                          VisibilityStatusContainer(
                            visibility: projectEntity.visibility,
                          ),
                        ],
                      ),
                      PaddingConfig.h24,
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Iconsax.status, color: AppColors.blueShade2),
                          PaddingConfig.w8,
                          Text(
                            "Project Status",
                            style: AppTextStyle.bodyMd(
                              color: AppColors.blueShade2,
                            ),
                          ),
                          SizedBox(width: 80),
                          DynamicStatusContainer(status: projectEntity.status),
                        ],
                      ),
                      PaddingConfig.h24,
                    ],
                  ),
                ),

                PaddingConfig.w16,

                SizedBox(
                  width:
                      DeviceUtility.isMobileScreen(context)
                          ? double.infinity
                          : MediaQuery.of(context).size.width / 2.5 - 32,
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Iconsax.brush_1, color: AppColors.blueShade2),
                          PaddingConfig.w8,
                          Text(
                            "Project Descreption",
                            style: AppTextStyle.bodyMd(
                              color: AppColors.blueShade2,
                            ),
                          ),
                          PaddingConfig.w24,
                          Flexible(
                            child: SizedBox(
                              width: 200,
                              child: Text(
                                projectEntity.projectDescription,
                                style: AppTextStyle.bodySm(
                                  color: AppColors.fontLightGray,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      PaddingConfig.h24,
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Iconsax.receipt_2_1,
                            color: AppColors.blueShade2,
                          ),
                          PaddingConfig.w8,
                          Text(
                            "Project Requirdment",
                            style: AppTextStyle.bodyMd(
                              color: AppColors.blueShade2,
                            ),
                          ),
                          PaddingConfig.w24,
                          Flexible(
                            child: SizedBox(
                              width: 200,
                              child: Text(
                                projectEntity.requirements,
                                style: AppTextStyle.bodySm(
                                  color: AppColors.fontLightGray,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      PaddingConfig.h24,
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(Iconsax.calendar, color: AppColors.blueShade2),
                          PaddingConfig.w8,
                          Text(
                            "Project Deadline",
                            style: AppTextStyle.bodyMd(
                              color: AppColors.blueShade2,
                            ),
                          ),
                          PaddingConfig.w56,
                          Text(
                            projectEntity.end ?? "undefined",
                            style: AppTextStyle.bodySm(
                              color: AppColors.fontLightGray,
                            ),
                          ),
                          PaddingConfig.w16,
                          if (projectEntity.end == null)
                            AddButton(
                              onTap:
                                  () => addProjectDeadlineDialog(
                                    context,
                                    projectEntity.id,
                                  ),
                            ),
                          if (projectEntity.end != null)
                            EditButton(
                              onTap:
                                  () => addProjectDeadlineDialog(
                                    context,
                                    projectEntity.id,
                                  ),
                            ),
                        ],
                      ),
                      PaddingConfig.h24,
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Iconsax.star, color: AppColors.blueShade2),
                          PaddingConfig.w8,
                          Text(
                            "Project Rate",
                            style: AppTextStyle.bodyMd(
                              color: AppColors.blueShade2,
                            ),
                          ),
                          PaddingConfig.w96,
                          Text(
                            "${projectEntity.review}",
                            style: AppTextStyle.bodySm(
                              color: AppColors.fontLightGray,
                            ),
                          ),
                        ],
                      ),
                      PaddingConfig.h24,
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
