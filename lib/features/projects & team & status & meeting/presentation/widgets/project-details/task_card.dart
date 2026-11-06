import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:two_dashboard/config/constants/padding_config.dart';
import 'package:two_dashboard/config/constants/sizes_config.dart';
import 'package:two_dashboard/config/routes/app_route_config.dart';
import 'package:two_dashboard/config/theme/color.dart';
import 'package:two_dashboard/config/theme/text_style.dart';
import 'package:two_dashboard/core/functions/bloc-state-handling/task_bloc_state_handling.dart';
import 'package:two_dashboard/core/functions/device_utility.dart';
import 'package:two_dashboard/core/helper/helper_functions.dart';
import 'package:two_dashboard/core/widgets/container/custom_rounder_container.dart';
import 'package:two_dashboard/core/widgets/container/status-containers/duration_container.dart';
import 'package:two_dashboard/core/widgets/container/status-containers/dynamic_status_container.dart';
import 'package:two_dashboard/core/widgets/container/status-containers/priority_container.dart';
import 'package:two_dashboard/core/widgets/container/status-containers/task_status_container.dart';
import 'package:two_dashboard/core/widgets/images/fetch_network_image.dart';
import 'package:two_dashboard/core/widgets/menus/task_side_menu.dart';
import 'package:two_dashboard/features/projects%20&%20team%20&%20status%20&%20meeting/presentation/widgets/custom_progress_bar.dart';
import 'package:two_dashboard/features/sprints%20&%20tasks/domain/entity/task_entity.dart';
import 'package:two_dashboard/features/sprints%20&%20tasks/presentation/bloc/sprint_and_task_bloc.dart';

class TaskCard extends StatelessWidget {
  const TaskCard({super.key, required this.taskEntity});
  final TaskEntity taskEntity;

  @override
  Widget build(BuildContext context) {
    final GlobalKey iconKey = GlobalKey();

    return GestureDetector(
      onTap:
          () =>
              context.pushNamed(AppRouteConfig.taskDetails, extra: taskEntity),
      child: CustomRounderContainer(
        key: iconKey,
        width: DeviceUtility.getScreenWidth(context) * 0.7,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // For --> View, Update, Delete
                BlocListener<SprintAndTaskBloc, SprintAndTaskState>(
                  listener: (context, state) {
                    TaskBlocStateHandling().deleteTaskListener(
                      state,
                      context,
                      taskEntity.projectId,
                    );
                  },
                  listenWhen:
                      (previous, current) =>
                          previous.deleteTaskStatus != current.deleteTaskStatus,
                  child: Tooltip(
                    message: "More",
                    child: GestureDetector(
                      onTap: () {
                        showTaskCardSideMenu(iconKey, context, taskEntity.id);
                      },
                      child: const Icon(Iconsax.more),
                    ),
                  ),
                ),
              ],
            ),
            PaddingConfig.h8,
            // Task Title
            Text(
              taskEntity.title,
              style: AppTextStyle.bodyLg(),
              overflow: TextOverflow.ellipsis,
            ),
            PaddingConfig.h16,
            // Task Description
            Text(
              taskEntity.description,
              style: AppTextStyle.bodySm(),
              overflow: TextOverflow.ellipsis,
            ),
            PaddingConfig.h16,
            // End Date
            Row(
              children: [
                Icon(
                  Iconsax.clock,
                  size: SizesConfig.iconsSm,
                  color: AppColors.iconColor,
                ),
                PaddingConfig.w8,
                Text(
                  "${HelperFunctions.formatDate(taskEntity.endDate)} - ${TimeOfDay.fromDateTime(taskEntity.endDate).format(context)}",
                  style: AppTextStyle.bodySm(color: AppColors.fontLightGray),
                ),
              ],
            ),
            PaddingConfig.h16,
            // Progress Bar
            CustomProgressBar(
              value: taskEntity.taskCompletion,
              lintWidth:
                  DeviceUtility.isMobileScreen(context)
                      ? DeviceUtility.getScreenWidth(context) * 0.45
                      : DeviceUtility.getScreenWidth(context) * 0.13,
            ),
            PaddingConfig.h16,
            // Priority & Status & duration
            Row(
              children: [
                PriorityContainer(priority: taskEntity.taskPriority),
                PaddingConfig.w8,
                TaskStatusContainer(taskStatus: taskEntity.taskStatus),
                PaddingConfig.w8,
                DurationContainer(
                  startDate: taskEntity.startDate,
                  endDate: taskEntity.endDate,
                ),
                PaddingConfig.w8,
                DynamicStatusContainer(
                  status: taskEntity.sprintLabel ?? "Backlog",
                ),
              ],
            ),
            PaddingConfig.h16,
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
                      style: AppTextStyle.bodyMd(color: AppColors.fontDarkGray),
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
      ),
    );
  }
}
