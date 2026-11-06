import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:two_dashboard/core/helper/helper_functions.dart';
import 'package:two_dashboard/core/widgets/menus/status_side_menu.dart';
import 'package:two_dashboard/features/projects%20&%20team%20&%20status%20&%20meeting/data/models/status/status_model.dart';
import 'package:two_dashboard/features/projects%20&%20team%20&%20status%20&%20meeting/presentation/bloc/project_status_team_meeting_bloc.dart';
import 'package:two_dashboard/features/projects%20&%20team%20&%20status%20&%20meeting/presentation/widgets/task_board_card.dart';
import 'package:two_dashboard/features/sprints%20&%20tasks/presentation/widgets/task_status_title_and_task_count.dart';

import '../../../../config/constants/padding_config.dart';
import '../../../../config/constants/sizes_config.dart';
import '../../../../config/theme/color.dart';

class StatusKanbanView extends StatefulWidget {
  const StatusKanbanView({
    super.key,
    required this.statusList,
    required this.projectId,
  });
  final List<StatusModel> statusList;
  final int projectId;

  @override
  State<StatusKanbanView> createState() => _StatusKanbanViewState();
}

class _StatusKanbanViewState extends State<StatusKanbanView> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double width = constraints.maxWidth;
        int columnsCount;

        if (width >= 1000) {
          columnsCount = 4; // ديسك توب
        } else if (width >= 600) {
          columnsCount = 2; // تابلت
        } else {
          columnsCount = 1; // موبايل
        }

        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: AlwaysScrollableScrollPhysics(),
          child: SizedBox(
            // constraints: BoxConstraints(
            //   minWidth: columnsCount * 300, // عرض الأعمدة
            // ),
            height: 600,
            width: double.maxFinite,
            child: ReorderableListView(
              scrollDirection: Axis.horizontal,
              onReorder:
                  (oldIndex, newIndex) => {
                    context.read<ProjectStatusTeamMeetingBloc>().add(
                      UpdateStatusOrderEvent(
                        projectId: widget.projectId,
                        statusId: widget.statusList[oldIndex].id,
                        newOrder: (newIndex + 1),
                      ),
                    ),
                    context.read<ProjectStatusTeamMeetingBloc>().add(
                      ShowProjectStatusEvent(projectId: widget.projectId),
                    ),
                  },
              children:
                  widget.statusList.map((status) {
                    return _buildKanbanColumn(
                      status,
                      width / columnsCount,
                      ValueKey(status),
                      widget.projectId,
                    );
                  }).toList(),
            ),
          ),
        );
      },
    );
  }

  // Kanban Column
  Widget _buildKanbanColumn(
    StatusModel projectStatus,
    double width,
    Key key,
    int projectId,
  ) {
    final GlobalKey iconKey = GlobalKey();
    return ReorderableDragStartListener(
      key: key,
      index: widget.statusList.indexOf(projectStatus),
      child: GestureDetector(
        onDoubleTap:
            () => showStatusSideMenu(
              iconKey,
              context,
              projectStatus.id,
              projectId,
            ),
        child: Container(
          key: iconKey,
          width: width,
          padding: EdgeInsets.all(SizesConfig.md),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(SizesConfig.borderRadiusSm),
            border: Border.all(color: AppColors.gray, width: 0.8),
            color: AppColors.white,
          ),
          child: Column(
            children: [
              // Project status and number
              TaskStatusTitleAndTaskCount(
                title: projectStatus.name,
                colorState: HelperFunctions.getTaskStatusColor(
                  HelperFunctions.getTaskStatusByName(projectStatus.name),
                ),
                count: projectStatus.tasks.length.toString(),
              ),
              PaddingConfig.h16,
              // Tasks List
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.7,
                child: ListView(
                  children: List.generate(
                    projectStatus.tasks.length,
                    (index) =>
                        TaskBoardCard(taskEntity: projectStatus.tasks[index]),
                  ),
                ),
              ),
              PaddingConfig.h16,
            ],
          ),
        ),
      ),
    );
  }
}
