import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:two_dashboard/config/constants/padding_config.dart';
import 'package:two_dashboard/config/theme/color.dart';
import 'package:two_dashboard/core/functions/bloc-state-handling/status_bloc_state_handling.dart';
import 'package:two_dashboard/core/network/enums.dart';
import 'package:two_dashboard/core/widgets/container/custom_rounder_container.dart';
import 'package:two_dashboard/features/projects%20&%20team%20&%20status%20&%20meeting/presentation/bloc/project_status_team_meeting_bloc.dart';
import 'package:two_dashboard/features/sprints%20&%20tasks/domain/entity/sprint_entity.dart';
import 'package:two_dashboard/features/sprints%20&%20tasks/presentation/bloc/sprint_and_task_bloc.dart';

class BoardTabBarView extends StatefulWidget {
  const BoardTabBarView({super.key, required this.projectId});
  final int projectId;

  @override
  State<BoardTabBarView> createState() => _BoardTabBarViewState();
}

class _BoardTabBarViewState extends State<BoardTabBarView> {
  ValueNotifier<List<int>> selectedSprintIds = ValueNotifier([]);

  Widget _buildSprintFilterList(List<SprintEntity> sprints) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children:
          sprints.map((sprint) {
            return ValueListenableBuilder<List<int>>(
              valueListenable: selectedSprintIds,
              builder: (context, value, child) {
                final isSelected = value.contains(sprint.id);
                return ListTile(
                  dense: true,
                  leading: Radio<bool>(
                    value: true,
                    groupValue: isSelected,
                    onChanged: (val) {
                      if (isSelected) {
                        // إلغاء التحديد
                        selectedSprintIds.value.removeWhere(
                          (id) => id == sprint.id,
                        );
                      } else {
                        // إضافة sprint جديد
                        selectedSprintIds.value = [...value, sprint.id];
                      }
                      print("*****************");
                      print(selectedSprintIds.value);
                      print("*****************");
                      // تحديث البورد
                      context.read<ProjectStatusTeamMeetingBloc>().add(
                        ShowProjectBoardEvent(
                          projectId: widget.projectId,
                          sprintsIdList: selectedSprintIds.value,
                        ),
                      );
                    },
                    activeColor: AppColors.blueShade2,
                  ),
                  title: Text(sprint.label),
                  onTap: () {
                    if (isSelected) {
                      selectedSprintIds.value =
                          value.where((id) => id != sprint.id).toList();
                    } else {
                      selectedSprintIds.value = [...value, sprint.id];
                    }
                    context.read<ProjectStatusTeamMeetingBloc>().add(
                      ShowProjectBoardEvent(
                        projectId: widget.projectId,
                        sprintsIdList: selectedSprintIds.value,
                      ),
                    );
                  },
                );
              },
            );
          }).toList(),
    );
  }

  @override
  void didChangeDependencies() {
    context.read<SprintAndTaskBloc>().add(
      ShowProjectSprintsEvent(projectId: widget.projectId),
    );
    context.read<ProjectStatusTeamMeetingBloc>().add(
      ShowProjectBoardEvent(
        projectId: widget.projectId,
        sprintsIdList: selectedSprintIds.value,
      ),
    );
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsGeometry.symmetric(horizontal: 16.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            PaddingConfig.h32,
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PaddingConfig.w8,
                CustomRounderContainer(
                  height: 200,
                  width: 200,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          Icon(Iconsax.filter),
                          PaddingConfig.w8,
                          Text("Filter By Sprint:"),
                        ],
                      ),
                      PaddingConfig.h16,
                      BlocBuilder<SprintAndTaskBloc, SprintAndTaskState>(
                        builder: (context, state) {
                          if (state.projectSprintsListStatus ==
                              CasualStatus.loading) {
                            return Center(
                              child: const CircularProgressIndicator(
                                color: AppColors.blueShade2,
                              ),
                            );
                          } else if (state.projectSprintsListStatus ==
                              CasualStatus.success) {
                            if (state.projectSprintsList.isEmpty) {
                              return Text("Empty");
                            } else {
                              //return Text("Susss");
                              return _buildSprintFilterList(
                                state.projectSprintsList,
                              );
                            }
                          } else {
                            return const Text("No sprints available");
                          }
                        },
                      ),
                    ],
                  ),
                ),
                PaddingConfig.w16,
                Expanded(
                  child: BlocConsumer<
                    ProjectStatusTeamMeetingBloc,
                    ProjectStatusTeamMeetingState
                  >(
                    listenWhen:
                        (previous, current) =>
                            previous.deleteStatus != current.deleteStatus,
                    listener: (context, state) {
                      StatusBlocStateHandling().deleteStatusListener(
                        state,
                        context,
                        widget.projectId,
                      );
                    },
                    buildWhen:
                        (previous, current) =>
                            previous.projectBoardListStatus !=
                            current.projectBoardListStatus,
                    builder: (context, state) {
                      return StatusBlocStateHandling().getProjectBoardList(
                        state,
                        widget.projectId,
                      );
                    },
                  ),
                ),
              ],
            ),
            PaddingConfig.h48,
          ],
        ),
      ),
    );
  }
}
