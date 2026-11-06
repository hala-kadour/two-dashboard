import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:two_dashboard/config/constants/padding_config.dart';
import 'package:two_dashboard/config/theme/color.dart';
import 'package:two_dashboard/config/theme/text_style.dart';
import 'package:two_dashboard/core/functions/bloc-state-handling/task_bloc_state_handling.dart';
import 'package:two_dashboard/core/widgets/container/custom_rounder_container.dart';
import 'package:two_dashboard/features/sprints%20&%20tasks/presentation/bloc/sprint_and_task_bloc.dart';

class TasksTabBarView extends StatefulWidget {
  const TasksTabBarView({super.key, required this.projectId});
  final int projectId;

  @override
  State<TasksTabBarView> createState() => _TasksTabBarViewState();
}

class _TasksTabBarViewState extends State<TasksTabBarView> {
  ValueNotifier<int> taskFilter = ValueNotifier(0);
  ValueNotifier<String> proirityFilter = ValueNotifier("Low");

  Widget _buildTaskRadio(int value, String label) {
    return Row(
      children: [
        ValueListenableBuilder(
          valueListenable: taskFilter,
          builder:
              (_, v, _) => Radio<int>(
                value: value,
                groupValue: taskFilter.value,
                activeColor: AppColors.blueShade2,
                onChanged: (int? newValue) {
                  taskFilter.value = newValue!;
                  if (newValue == 1) {
                    // My Tasks
                    context.read<SprintAndTaskBloc>().add(
                      ShowMyProjectTasksEvent(
                        projectId: widget.projectId,
                        proirity: proirityFilter.value,
                      ),
                    );
                  } else {
                    // All Tasks
                    context.read<SprintAndTaskBloc>().add(
                      ShowProjectTasksEvent(projectId: widget.projectId),
                    );
                  }
                },
              ),
        ),
        Text(label, style: AppTextStyle.bodySm()),
      ],
    );
  }

  Widget _buildProirityRadio(String value, String label) {
    return Row(
      children: [
        ValueListenableBuilder(
          valueListenable: proirityFilter,
          builder:
              (_, v, _) => Radio<String>(
                value: value,
                groupValue: proirityFilter.value,
                activeColor: AppColors.blueShade2,
                onChanged: (String? newValue) {
                  proirityFilter.value = newValue!;
                  context.read<SprintAndTaskBloc>().add(
                    ShowMyProjectTasksEvent(
                      projectId: widget.projectId,
                      proirity: proirityFilter.value,
                    ),
                  );
                },
              ),
        ),
        Text(label, style: AppTextStyle.bodySm()),
      ],
    );
  }

  @override
  void didChangeDependencies() {
    context.read<SprintAndTaskBloc>().add(
      ShowProjectTasksEvent(projectId: widget.projectId),
    );
    context.read<SprintAndTaskBloc>().add(
      ShowMyProjectTasksEvent(
        projectId: widget.projectId,
        proirity: proirityFilter.value,
      ),
    );
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PaddingConfig.w8,
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomRounderContainer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Icon(Iconsax.filter),
                      PaddingConfig.w8,
                      Text(" Tasks Filter:"),
                    ],
                  ),
                  PaddingConfig.h16,
                  _buildTaskRadio(0, "All Tasks"),
                  PaddingConfig.h8,
                  _buildTaskRadio(1, "My Tasks"),
                ],
              ),
            ),
            PaddingConfig.h16,
            ValueListenableBuilder(
              valueListenable: taskFilter,
              builder:
                  (context, value, child) => Visibility(
                    visible: value == 1 ? true : false,
                    child: CustomRounderContainer(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            children: [
                              Icon(Iconsax.filter),
                              PaddingConfig.w8,
                              Text("Priority Filter :"),
                            ],
                          ),
                          PaddingConfig.h16,
                          _buildProirityRadio("Low", "Low"),
                          PaddingConfig.h8,
                          _buildProirityRadio("Mid", "Mideum"),
                          PaddingConfig.h8,
                          _buildProirityRadio("High", "High"),
                        ],
                      ),
                    ),
                  ),
            ),
          ],
        ),
        PaddingConfig.w16,
        Expanded(
          child: ValueListenableBuilder(
            valueListenable: taskFilter,
            builder: (_, value, _) {
              if (value == 1) {
                // My Tasks
                return BlocBuilder<SprintAndTaskBloc, SprintAndTaskState>(
                  buildWhen:
                      (previous, current) =>
                          previous.myProjectTasksListStatus !=
                          current.myProjectTasksListStatus,
                  builder: (context, state) {
                    return TaskBlocStateHandling()
                        .getMyTaskListInsideTheProject(state);
                  },
                );
              } else {
                // All Tasks
                return BlocBuilder<SprintAndTaskBloc, SprintAndTaskState>(
                  buildWhen:
                      (previous, current) =>
                          previous.projectTasksListStatus !=
                          current.projectTasksListStatus,
                  builder: (context, state) {
                    return TaskBlocStateHandling()
                        .getAllTaskListInsideTheProject(state);
                  },
                );
              }
            },
          ),
        ),
      ],
    );
  }
}
