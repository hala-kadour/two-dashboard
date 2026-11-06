import 'package:flutter/material.dart';
import 'package:two_dashboard/core/helper/helper_functions.dart';
import 'package:two_dashboard/core/widgets/menus/status_side_menu.dart';
import 'package:two_dashboard/features/projects%20&%20team%20&%20status%20&%20meeting/data/models/status/show_project_board_response_model.dart';
import 'package:two_dashboard/features/projects%20&%20team%20&%20status%20&%20meeting/presentation/widgets/task_board_card.dart';
import 'package:two_dashboard/features/sprints%20&%20tasks/presentation/widgets/task_status_title_and_task_count.dart';

import '../../../../config/constants/padding_config.dart';
import '../../../../config/constants/sizes_config.dart';
import '../../../../config/theme/color.dart';

class BoardKanbanView extends StatefulWidget {
  const BoardKanbanView({
    super.key,
    required this.statusList,
    required this.projectId,
  });
  final List<StatusBoardModel> statusList;
  final int projectId;

  @override
  State<BoardKanbanView> createState() => _BoardKanbanViewState();
}

class _BoardKanbanViewState extends State<BoardKanbanView> {
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
            height: 600,
            width: double.maxFinite,
            child: Row(
              children:
                  widget.statusList.map((status) {
                    return _buildKanbanColumn(
                      status,
                      width / columnsCount + 50,
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
    StatusBoardModel projectStatus,
    double width,
    Key key,
    int projectId,
  ) {
    final GlobalKey iconKey = GlobalKey();
    return GestureDetector(
      onDoubleTap:
          () =>
              showStatusSideMenu(iconKey, context, projectStatus.id, projectId),
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
              height: MediaQuery.of(context).size.height * 0.5,
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
    );
  }
}
