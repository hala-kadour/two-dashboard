import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:two_dashboard/config/constants/padding_config.dart';
import 'package:two_dashboard/config/routes/app_route_config.dart';
import 'package:two_dashboard/config/theme/color.dart';
import 'package:two_dashboard/config/theme/text_style.dart';
import 'package:two_dashboard/core/functions/bloc-state-handling/sprint_bloc_state_handling.dart';
import 'package:two_dashboard/core/widgets/buttons/out-line-buttons/start_sprint_out_line_button.dart';
import 'package:two_dashboard/core/widgets/container/custom_rounder_container.dart';
import 'package:two_dashboard/core/widgets/container/status-containers/duration_container.dart';
import 'package:two_dashboard/core/widgets/container/status-containers/dynamic_status_container.dart';
import 'package:two_dashboard/core/widgets/container/status-containers/priority_container.dart';
import 'package:two_dashboard/core/widgets/container/status-containers/task_status_container.dart';
import 'package:two_dashboard/core/widgets/images/fetch_network_image.dart';
import 'package:two_dashboard/core/widgets/menus/sprint_side_menu.dart';
import 'package:two_dashboard/features/sprints%20&%20tasks/data/models/sprint/sprint.dart';
import 'package:two_dashboard/features/sprints%20&%20tasks/data/models/task/task_model.dart';
import 'package:two_dashboard/features/sprints%20&%20tasks/domain/entity/sprint_entity.dart';
import 'package:two_dashboard/features/sprints%20&%20tasks/presentation/bloc/sprint_and_task_bloc.dart';

class BacklogCard extends StatelessWidget {
  const BacklogCard({
    super.key,
    required this.sprint,
    required this.projectId,
    required this.showButton,
  });
  final Sprint sprint;
  final int projectId;
  final bool showButton;

  @override
  Widget build(BuildContext context) {
    final GlobalKey iconKey = GlobalKey();

    return GestureDetector(
      onTap:
          () => context.pushNamed(
            AppRouteConfig.sprintDetails,
            extra: SprintEntity(
              id: sprint.id,
              projectId: sprint.projectId,
              label: sprint.label,
              description: sprint.description,
              goal: sprint.goal,
              start: sprint.start,
              end: sprint.end,
              sprintStatus: sprint.status,
              incompleteTasksCount: sprint.incompleteTasksCount,
            ),
          ),
      child: CustomRounderContainer(
        backgroundColor: AppColors.grayshade1,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Iconsax.arrow_down_1),
                    PaddingConfig.w8,
                    Text(sprint.label),
                    PaddingConfig.w8,
                    DynamicStatusContainer(status: sprint.status),
                  ],
                ),
                Row(
                  children: [
                    DynamicStatusContainer(
                      status:
                          sprint.tasks
                              .where(
                                (element) =>
                                    element.status.toLowerCase().contains('do'),
                              )
                              .toList()
                              .length
                              .toString(),
                      color: AppColors.yellowShade1,
                      fontColor: AppColors.yellowShade2,
                    ),
                    PaddingConfig.w8,
                    DynamicStatusContainer(
                      status:
                          sprint.tasks
                              .where(
                                (element) =>
                                    element.status.toLowerCase().contains('pr'),
                              )
                              .toList()
                              .length
                              .toString(),
                      color: AppColors.blueShade1,
                      fontColor: AppColors.blueShade2,
                    ),
                    PaddingConfig.w8,
                    DynamicStatusContainer(
                      status:
                          sprint.tasks
                              .where(
                                (element) =>
                                    element.status.toLowerCase().contains('co'),
                              )
                              .toList()
                              .length
                              .toString(),
                      color: AppColors.greenShade1,
                      fontColor: AppColors.greenShade2,
                    ),
                    PaddingConfig.w8,
                    if (showButton)
                      BlocListener<SprintAndTaskBloc, SprintAndTaskState>(
                        listener: (context, state) {
                          SprintBlocStateHandling().startSprintListener(
                            state,
                            context,
                            projectId,
                          );
                        },
                        listenWhen:
                            (previous, current) =>
                                previous.startSprintStatus !=
                                current.startSprintStatus,
                        child: StartSprintOutLineButton(
                          projectId: projectId,
                          sprintId: sprint.id,
                        ),
                      ),
                    PaddingConfig.w8,
                    Tooltip(
                      message: "More",
                      child: GestureDetector(
                        key: iconKey,
                        onTap: () {
                          showSprintCardSideMenu(
                            iconKey,
                            context,
                            SprintEntity(
                              id: sprint.id,
                              projectId: projectId,
                              label: sprint.label,
                              description: sprint.description,
                              goal: sprint.goal,
                              start: sprint.start,
                              end: sprint.end,
                              sprintStatus: sprint.status,
                              incompleteTasksCount: sprint.incompleteTasksCount,
                            ),
                            projectId.toString(),
                          );
                        },
                        child: const Icon(Iconsax.more),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            PaddingConfig.h16,
            SizedBox(
              height: 220,
              child: ListView.builder(
                itemCount: sprint.tasks.length,
                itemBuilder:
                    (context, index) =>
                        BacklogTaskListTile(task: sprint.tasks[index]),
              ),
            ),
            PaddingConfig.h16,
            GestureDetector(
              onTap:
                  () => context.pushNamed(
                    AppRouteConfig.createTask,
                    pathParameters: {
                      'pId': projectId.toString(),
                      'sId': sprint.id.toString(),
                    },
                  ),
              child: Row(
                children: [
                  Icon(Iconsax.add, color: AppColors.greenShade2),
                  PaddingConfig.w8,
                  Text(
                    "Create New Task",
                    style: AppTextStyle.buttonStyle(
                      color: AppColors.greenShade2,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BacklogTaskListTile extends StatelessWidget {
  const BacklogTaskListTile({super.key, required this.task});

  final TaskModel task;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.pushNamed(AppRouteConfig.taskDetails, extra: task),
      child: CustomRounderContainer(
        margin: EdgeInsets.only(bottom: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Iconsax.tag),
                PaddingConfig.w8,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(task.title),
                    PaddingConfig.h8,
                    Text(
                      task.description,
                      style: AppTextStyle.bodySm(
                        color: AppColors.fontLightGray,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            // Priority & Status & duration
            Row(
              children: [
                PriorityContainer(priority: task.taskPriority),
                PaddingConfig.w8,
                TaskStatusContainer(taskStatus: task.taskStatus),
                PaddingConfig.w8,
                DurationContainer(
                  startDate: task.startDate,
                  endDate: task.endDate,
                ),
              ],
            ),
            // image
            Row(
              children: [
                FetchNetworkImage(
                  height: 50,
                  width: 50,
                  shape: BoxShape.circle,
                  imagePath: task.assignedTo.image,
                ),
                PaddingConfig.w8,
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      task.assignedTo.name,
                      style: AppTextStyle.bodyMd(color: AppColors.fontDarkGray),
                    ),
                    Text(
                      task.assignedTo.role,
                      style: AppTextStyle.bodySm(
                        color: AppColors.fontLightGray,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Icon(Iconsax.more),
          ],
        ),
      ),
    );
  }
}
