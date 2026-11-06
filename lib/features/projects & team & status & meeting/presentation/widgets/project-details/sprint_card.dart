import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:two_dashboard/config/constants/padding_config.dart';
import 'package:two_dashboard/config/routes/app_route_config.dart';
import 'package:two_dashboard/config/theme/color.dart';
import 'package:two_dashboard/config/theme/text_style.dart';
import 'package:two_dashboard/core/functions/bloc-state-handling/sprint_bloc_state_handling.dart';
import 'package:two_dashboard/core/widgets/buttons/out-line-buttons/complete_sprint_out_line_button.dart';
import 'package:two_dashboard/core/widgets/buttons/out-line-buttons/start_sprint_out_line_button.dart';
import 'package:two_dashboard/core/widgets/container/custom_rounder_container.dart';
import 'package:two_dashboard/core/widgets/container/status-containers/dynamic_status_container.dart';
import 'package:two_dashboard/core/widgets/menus/sprint_side_menu.dart';
import 'package:two_dashboard/features/sprints%20&%20tasks/domain/entity/sprint_entity.dart';
import 'package:two_dashboard/features/sprints%20&%20tasks/presentation/bloc/sprint_and_task_bloc.dart';

class SprintCard extends StatelessWidget {
  const SprintCard({super.key, required this.sprintEntity});
  final SprintEntity sprintEntity;

  @override
  Widget build(BuildContext context) {
    final GlobalKey iconKey = GlobalKey();

    return GestureDetector(
      onTap:
          () => context.pushNamed(
            AppRouteConfig.sprintDetails,
            extra: sprintEntity,
          ),
      child: CustomRounderContainer(
        backgroundColor: AppColors.grayshade1,
        margin: EdgeInsets.only(bottom: 16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Iconsax.arrow_down_1),
                    PaddingConfig.w8,
                    Text(sprintEntity.label),
                    PaddingConfig.w8,
                    DynamicStatusContainer(status: sprintEntity.sprintStatus),
                  ],
                ),
                Row(
                  children: [
                    if (sprintEntity.sprintStatus.toLowerCase().contains("pen"))
                      BlocListener<SprintAndTaskBloc, SprintAndTaskState>(
                        listener: (context, state) {
                          SprintBlocStateHandling().startSprintListener(
                            state,
                            context,
                            sprintEntity.projectId,
                          );
                        },
                        listenWhen:
                            (previous, current) =>
                                previous.startSprintStatus !=
                                current.startSprintStatus,
                        child: StartSprintOutLineButton(
                          projectId: sprintEntity.projectId,
                          sprintId: sprintEntity.id,
                        ),
                      ),
                    if (!sprintEntity.sprintStatus.toLowerCase().contains(
                          "com",
                        ) &&
                        !sprintEntity.sprintStatus.toLowerCase().contains(
                          "pen",
                        ))
                      BlocListener<SprintAndTaskBloc, SprintAndTaskState>(
                        listener: (context, state) {
                          SprintBlocStateHandling().completeSprintListener(
                            state,
                            context,
                            sprintEntity.projectId,
                          );
                        },
                        listenWhen:
                            (previous, current) =>
                                previous.startSprintStatus !=
                                current.startSprintStatus,
                        child: CompleteSprintOutLineButton(
                          sprint: sprintEntity,
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
                            sprintEntity,
                            sprintEntity.projectId.toString(),
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
            Row(
              children: [
                Icon(Iconsax.paperclip, color: AppColors.fontLightGray),
                PaddingConfig.w8,
                Text(
                  sprintEntity.description,
                  style: AppTextStyle.bodySm(color: AppColors.fontLightGray),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
            PaddingConfig.h16,
            Row(
              children: [
                Icon(Iconsax.flag, color: AppColors.fontLightGray),
                PaddingConfig.w8,
                Text(
                  sprintEntity.goal,
                  style: AppTextStyle.bodySm(color: AppColors.fontLightGray),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
            PaddingConfig.h16,
            if (!sprintEntity.sprintStatus.toLowerCase().contains("com"))
              GestureDetector(
                onTap:
                    () => context.pushNamed(
                      AppRouteConfig.createTask,
                      pathParameters: {
                        'pId': sprintEntity.projectId.toString(),
                        'sId': sprintEntity.id.toString(),
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
