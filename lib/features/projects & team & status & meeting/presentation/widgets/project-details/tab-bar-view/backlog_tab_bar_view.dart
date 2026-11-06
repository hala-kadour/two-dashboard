import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:two_dashboard/config/constants/padding_config.dart';
import 'package:two_dashboard/config/routes/app_route_config.dart';
import 'package:two_dashboard/core/functions/bloc-state-handling/task_bloc_state_handling.dart';
import 'package:two_dashboard/core/widgets/buttons/elevated-buttons/create_elevated_button.dart';
import 'package:two_dashboard/features/projects%20&%20team%20&%20status%20&%20meeting/data/models/project/team.dart';
import 'package:two_dashboard/features/sprints%20&%20tasks/presentation/bloc/sprint_and_task_bloc.dart';

class BacklogTabBarView extends StatefulWidget {
  const BacklogTabBarView({
    super.key,
    required this.projectId,
    required this.team,
  });
  final int projectId;
  final Team? team;

  @override
  State<BacklogTabBarView> createState() => _BacklogTabBarViewState();
}

class _BacklogTabBarViewState extends State<BacklogTabBarView> {
  @override
  void didChangeDependencies() {
    context.read<SprintAndTaskBloc>().add(
      ShowProjectPendedSprintsEvent(projectId: widget.projectId),
    );
    context.read<SprintAndTaskBloc>().add(
      ShowProjectBacklogTasksEvent(projectId: widget.projectId),
    );
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsGeometry.symmetric(horizontal: 16.0),
      child: SingleChildScrollView(
        child: SizedBox(
          height: 900,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CreateElevatedButton(
                    addingType: "New Sprint",
                    onPressed:
                        () => context.pushNamed(
                          AppRouteConfig.createSprint,
                          pathParameters: {'id': widget.projectId.toString()},
                        ),
                  ),
                ],
              ),
              PaddingConfig.h32,
              SizedBox(
                height: 350,
                child: BlocBuilder<SprintAndTaskBloc, SprintAndTaskState>(
                  buildWhen:
                      (previous, current) =>
                          previous.projectPendedSprintsListStatus !=
                          current.projectPendedSprintsListStatus,
                  builder: (context, state) {
                    return TaskBlocStateHandling().getPendedSprintTasksList(
                      state,
                      widget.projectId,
                      widget.team,
                    );
                  },
                ),
              ),
              PaddingConfig.h32,
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CreateElevatedButton(
                    addingType: "Backlog Sprint",
                    onPressed:
                        () => context.pushNamed(
                          AppRouteConfig.createSprint,
                          pathParameters: {'id': widget.projectId.toString()},
                        ),
                  ),
                ],
              ),
              PaddingConfig.h32,
              BlocBuilder<SprintAndTaskBloc, SprintAndTaskState>(
                buildWhen:
                    (previous, current) =>
                        previous.backlogTasksListStatus !=
                        current.backlogTasksListStatus,
                builder: (context, state) {
                  return TaskBlocStateHandling().getBacklogTasksList(
                    state,
                    widget.projectId,
                  );
                },
              ),
              PaddingConfig.h40,
            ],
          ),
        ),
      ),
    );
  }
}
