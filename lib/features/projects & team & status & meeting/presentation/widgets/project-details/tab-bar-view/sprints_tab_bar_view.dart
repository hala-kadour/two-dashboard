import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:two_dashboard/config/constants/padding_config.dart';
import 'package:two_dashboard/config/routes/app_route_config.dart';
import 'package:two_dashboard/config/theme/color.dart';
import 'package:two_dashboard/config/theme/text_style.dart';
import 'package:two_dashboard/core/functions/bloc-state-handling/sprint_bloc_state_handling.dart';
import 'package:two_dashboard/core/widgets/buttons/elevated-buttons/create_elevated_button.dart';
import 'package:two_dashboard/core/widgets/container/custom_rounder_container.dart';
import 'package:two_dashboard/features/sprints%20&%20tasks/domain/entity/sprint_entity.dart';
import 'package:two_dashboard/features/sprints%20&%20tasks/presentation/bloc/sprint_and_task_bloc.dart';

class SprintsTabBarView extends StatefulWidget {
  const SprintsTabBarView({super.key, required this.projectId});
  final int projectId;

  @override
  State<SprintsTabBarView> createState() => _SprintsTabBarViewState();
}

class _SprintsTabBarViewState extends State<SprintsTabBarView> {
  ValueNotifier<int> filter = ValueNotifier(0);

  late final List<SprintEntity> allSprints;
  late final List<SprintEntity> startedSprints;
  late final List<SprintEntity> uncompletedSprints;

  @override
  void initState() {
    super.initState();
    // All Sprints
    context.read<SprintAndTaskBloc>().add(
      ShowProjectSprintsEvent(projectId: widget.projectId),
    );
  }

  Widget _buildRadio(int value, String label) {
    return Row(
      children: [
        ValueListenableBuilder(
          valueListenable: filter,
          builder:
              (_, vv, _) => Radio<int>(
                value: value,
                groupValue: filter.value,
                activeColor: AppColors.blueShade2,
                onChanged: (int? newValue) {
                  filter.value = newValue!;
                  if (newValue == 1) {
                    // Started Sprints
                    context.read<SprintAndTaskBloc>().add(
                      ShowProjectStartedSprintsEvent(
                        projectId: widget.projectId,
                      ),
                    );
                  } else if (newValue == 2) {
                    // Un Completed Sprints
                    context.read<SprintAndTaskBloc>().add(
                      ShowProjectUnCompleteSprintsEvent(
                        projectId: widget.projectId,
                      ),
                    );
                  } else {
                    // All Sprints
                    context.read<SprintAndTaskBloc>().add(
                      ShowProjectSprintsEvent(projectId: widget.projectId),
                    );
                  }
                },
              ),
        ),
        Text(label, style: AppTextStyle.bodySm()),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
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
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PaddingConfig.w8,
                CustomRounderContainer(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          Icon(Iconsax.filter),
                          PaddingConfig.w8,
                          Text("Filter :"),
                        ],
                      ),
                      PaddingConfig.h16,
                      _buildRadio(0, "All Sprints"),
                      PaddingConfig.h8,
                      _buildRadio(1, "Started Sprints"),
                      PaddingConfig.h8,
                      _buildRadio(2, "Un Completed Sprints"),
                    ],
                  ),
                ),
                PaddingConfig.w16,
                Expanded(
                  child: ValueListenableBuilder<int>(
                    valueListenable: filter,
                    builder: (_, value, __) {
                      if (value == 1) {
                        // Started Sprints
                        return BlocBuilder<
                          SprintAndTaskBloc,
                          SprintAndTaskState
                        >(
                          buildWhen:
                              (previous, current) =>
                                  previous.projectStartedSprintsListStatus !=
                                  current.projectStartedSprintsListStatus,
                          builder: (context, state) {
                            return SprintBlocStateHandling()
                                .getStartedSprintsList(state);
                          },
                        );
                      } else if (value == 2) {
                        // Un Completed Sprints
                        return BlocBuilder<
                          SprintAndTaskBloc,
                          SprintAndTaskState
                        >(
                          buildWhen:
                              (previous, current) =>
                                  previous.projectUnCompleteSprintsListStatus !=
                                  current.projectUnCompleteSprintsListStatus,
                          builder: (context, state) {
                            return SprintBlocStateHandling()
                                .getUnCompletedSprintsList(state);
                          },
                        );
                      } else {
                        // All Sprints
                        return BlocBuilder<
                          SprintAndTaskBloc,
                          SprintAndTaskState
                        >(
                          buildWhen:
                              (previous, current) =>
                                  previous.projectSprintsListStatus !=
                                  current.projectSprintsListStatus,
                          builder: (context, state) {
                            return SprintBlocStateHandling().getAllSprintsList(
                              state,
                            );
                          },
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
