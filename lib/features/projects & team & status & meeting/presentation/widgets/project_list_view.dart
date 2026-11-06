import 'package:flutter/material.dart';
import 'package:two_dashboard/config/constants/padding_config.dart';
import 'package:two_dashboard/config/constants/sizes_config.dart';
import 'package:two_dashboard/config/theme/color.dart';
import 'package:two_dashboard/core/helper/helper_functions.dart';
import 'package:two_dashboard/core/network/enums.dart';
import 'package:two_dashboard/features/projects%20&%20team%20&%20status%20&%20meeting/presentation/widgets/project_list_tile.dart';

import '../../../sprints & tasks/presentation/widgets/task_status_title_and_task_count.dart';

class ProjectListView extends StatefulWidget {
  const ProjectListView({super.key, required this.colorStatus});
  final Color colorStatus;

  @override
  State<ProjectListView> createState() => _ProjectListViewState();
}

class _ProjectListViewState extends State<ProjectListView> {
  TaskStatus selectedStatus = TaskStatus.pended;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            _getTaskStatusBox(TaskStatus.pended, "9"),
            _getTaskStatusBox(TaskStatus.inProgress, "9"),
            _getTaskStatusBox(TaskStatus.inReview, "9"),
            _getTaskStatusBox(TaskStatus.completed, "9"),
          ],
        ),
        PaddingConfig.h16,
        Expanded(
          flex: 6,
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.white,
              border: Border.all(color: AppColors.gray, width: 0.7),
              borderRadius: BorderRadius.circular(SizesConfig.borderRadiusMd),
            ),
            padding: EdgeInsets.all(16.0),
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: 10,
              itemBuilder:
                  (context, index) =>
                      ProjectListTile(colorStatus: widget.colorStatus),
            ),
          ),
        ),
      ],
    );
  }

  Widget _getTaskStatusBox(TaskStatus projectStatus, String count) {
    bool isSelected = selectedStatus == projectStatus;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedStatus = projectStatus;
        });
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 250),
        curve: Curves.easeInOut,
        width: 150,
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
        decoration: BoxDecoration(
          color:
              isSelected
                  ? HelperFunctions.getTaskStatusBackgroundColor(projectStatus)
                  : AppColors.white,
          borderRadius: BorderRadius.circular(SizesConfig.borderRadiusSm),
          border: Border.all(
            color:
                isSelected
                    ? HelperFunctions.getTaskStatusColor(projectStatus)
                    : AppColors.gray,
            width: isSelected ? 1.8 : 0.8,
          ),
        ),
        child: TaskStatusTitleAndTaskCount(
          title: HelperFunctions.getTaskStatusTitle(projectStatus),
          colorState: HelperFunctions.getTaskStatusColor(projectStatus),
          count: count,
        ),
      ),
    );
  }
}
