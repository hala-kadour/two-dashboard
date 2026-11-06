import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:two_dashboard/config/constants/padding_config.dart';
import 'package:two_dashboard/config/routes/app_route_config.dart';
import 'package:two_dashboard/config/theme/color.dart';
import 'package:two_dashboard/config/theme/text_style.dart';
import 'package:two_dashboard/core/functions/bloc-state-handling/task_bloc_state_handling.dart';
import 'package:two_dashboard/core/functions/device_utility.dart';
import 'package:two_dashboard/core/helper/helper_functions.dart';
import 'package:two_dashboard/core/widgets/breadcrumbs/breadcumbs_item.dart';
import 'package:two_dashboard/core/widgets/buttons/elevated-buttons/delete_elevated_button.dart';
import 'package:two_dashboard/core/widgets/buttons/elevated-buttons/update_elevated_button.dart';
import 'package:two_dashboard/core/widgets/buttons/icon-buttons/back_button.dart';
import 'package:two_dashboard/core/widgets/container/status-containers/priority_container.dart';
import 'package:two_dashboard/core/widgets/container/status-containers/task_status_container.dart';
import 'package:two_dashboard/core/widgets/dialog/global/confirm_deletion_dialog.dart';
import 'package:two_dashboard/core/widgets/divider/custom_page_divider.dart';
import 'package:two_dashboard/core/widgets/images/fetch_network_image.dart';
import 'package:two_dashboard/core/widgets/layouts/templates/page_template.dart';
import 'package:two_dashboard/core/widgets/texts/page_title.dart';
import 'package:two_dashboard/features/projects%20&%20team%20&%20status%20&%20meeting/presentation/widgets/custom_progress_bar.dart';
import 'package:two_dashboard/features/sprints%20&%20tasks/domain/entity/task_entity.dart';
import 'package:two_dashboard/features/sprints%20&%20tasks/presentation/bloc/sprint_and_task_bloc.dart';

class TaskDetailsPage extends StatelessWidget {
  const TaskDetailsPage({super.key, required this.taskEntity});
  final TaskEntity taskEntity;

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
                AppRouteConfig.taskDetails,
              ],
              pages: [
                "All Project",
                "Project Details",
                "Sprint Details",
                "TaskDetails",
              ],
            ),
            PaddingConfig.h16,
            Row(
              children: [
                const CustomBackButton(),
                PaddingConfig.w8,
                PageTitle(pageTitle: "Task Details"),
              ],
            ),
            CustomPageDivider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                UpdateElevatedButton(
                  updateType: "Task",
                  onPressed: () {
                    context.pushNamed(
                      AppRouteConfig.updateTask,
                      extra: taskEntity,
                    );
                  },
                ),
                PaddingConfig.w8,
                BlocListener<SprintAndTaskBloc, SprintAndTaskState>(
                  listenWhen:
                      (previous, current) =>
                          previous.deleteTaskStatus != current.deleteTaskStatus,
                  listener: (context, state) {
                    TaskBlocStateHandling().deleteTaskListener(
                      state,
                      context,
                      taskEntity.projectId,
                    );
                  },
                  child: DeleteElevatedButton(
                    deleteType: "Task",
                    onPressed:
                        () => confirmDeletionDialog(
                          context,
                          "this task",
                          () => context.read<SprintAndTaskBloc>().add(
                            DeleteTaskEvent(taskId: taskEntity.id),
                          ),
                        ),
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
                          Icon(Iconsax.paperclip, color: AppColors.blueShade2),
                          PaddingConfig.w8,
                          Text(
                            "Task Title",
                            style: AppTextStyle.bodyMd(
                              color: AppColors.blueShade2,
                            ),
                          ),
                          SizedBox(width: 75),
                          Text(
                            taskEntity.title,
                            style: AppTextStyle.bodySm(
                              color: AppColors.fontLightGray,
                            ),
                          ),
                        ],
                      ),
                      PaddingConfig.h24,
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Iconsax.brush_1, color: AppColors.blueShade2),
                          PaddingConfig.w8,
                          Text(
                            "Task Descreption",
                            style: AppTextStyle.bodyMd(
                              color: AppColors.blueShade2,
                            ),
                          ),
                          PaddingConfig.w24,
                          Flexible(
                            child: SizedBox(
                              width: 200,
                              child: Text(
                                taskEntity.description,
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
                          Icon(Iconsax.brush, color: AppColors.blueShade2),
                          PaddingConfig.w8,
                          Text(
                            "Task Status",
                            style: AppTextStyle.bodyMd(
                              color: AppColors.blueShade2,
                            ),
                          ),
                          SizedBox(width: 72),
                          TaskStatusContainer(
                            taskStatus: taskEntity.taskStatus,
                          ),
                        ],
                      ),
                      PaddingConfig.h32,
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Iconsax.clock, color: AppColors.blueShade2),
                          PaddingConfig.w8,
                          Text(
                            "Start Date",
                            style: AppTextStyle.bodyMd(
                              color: AppColors.blueShade2,
                            ),
                          ),
                          PaddingConfig.w80,
                          Text(
                            HelperFunctions.formatDate(taskEntity.startDate),
                            style: AppTextStyle.bodySm(
                              color: AppColors.fontLightGray,
                            ),
                          ),
                        ],
                      ),
                      PaddingConfig.h24,
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Iconsax.clock, color: AppColors.blueShade2),
                          PaddingConfig.w8,
                          Text(
                            "End Date",
                            style: AppTextStyle.bodyMd(
                              color: AppColors.blueShade2,
                            ),
                          ),
                          PaddingConfig.w88,
                          Text(
                            HelperFunctions.formatDate(taskEntity.endDate),
                            // "${HelperFunctions.formatDate(DateTime.now())} - ${TimeOfDay.fromDateTime(DateTime.now()).format(context)}",
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
                PaddingConfig.w16,
                SizedBox(
                  width:
                      DeviceUtility.isMobileScreen(context)
                          ? double.infinity
                          : MediaQuery.of(context).size.width / 2.5 - 32,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Iconsax.frame_1, color: AppColors.blueShade2),
                          PaddingConfig.w8,
                          Text(
                            "Assigned To",
                            style: AppTextStyle.bodyMd(
                              color: AppColors.blueShade2,
                            ),
                          ),
                          SizedBox(width: 75),
                          // Assigned to
                          Row(
                            children: [
                              // image
                              FetchNetworkImage(
                                height: 50,
                                width: 50,
                                shape: BoxShape.circle,
                                imagePath: taskEntity.assignedUser.image,
                              ),
                              PaddingConfig.w8,
                              // Name and Email
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    taskEntity.assignedUser.name,
                                    style: AppTextStyle.bodyMd(
                                      color: AppColors.fontDarkGray,
                                    ),
                                  ),
                                  Text(
                                    taskEntity.assignedUser.role,
                                    style: AppTextStyle.bodySm(
                                      color: AppColors.fontLightGray,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                      PaddingConfig.h24,
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Iconsax.flag, color: AppColors.blueShade2),
                          PaddingConfig.w8,
                          Text(
                            "Task Prority",
                            style: AppTextStyle.bodyMd(
                              color: AppColors.blueShade2,
                            ),
                          ),
                          SizedBox(width: 72),
                          PriorityContainer(priority: taskEntity.taskPriority),
                        ],
                      ),
                      PaddingConfig.h24,
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Iconsax.flag, color: AppColors.blueShade2),
                          PaddingConfig.w8,
                          Text(
                            "Completion",
                            style: AppTextStyle.bodyMd(
                              color: AppColors.blueShade2,
                            ),
                          ),
                          SizedBox(width: 72),
                          CustomProgressBar(
                            lintWidth: 200,
                            value: taskEntity.taskCompletion,
                          ),
                        ],
                      ),
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
