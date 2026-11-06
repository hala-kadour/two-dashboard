import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:two_dashboard/config/routes/app_route_config.dart';
import 'package:two_dashboard/config/theme/text_style.dart';
import 'package:two_dashboard/core/widgets/buttons/hovered-buttons/assign_team_button.dart';
import 'package:two_dashboard/core/widgets/container/status-containers/cooperation_type_container.dart';
import 'package:two_dashboard/core/widgets/container/status-containers/dynamic_status_container.dart';
import 'package:two_dashboard/core/widgets/container/status-containers/project_type_status_container.dart';
import 'package:two_dashboard/core/widgets/container/status-containers/visibility_status_container.dart';
import 'package:two_dashboard/core/widgets/dialog/project/project_details_dialog.dart';
import 'package:two_dashboard/features/projects%20&%20team%20&%20status%20&%20meeting/domain/entity/project_entity.dart';

class PendedProjectRows extends DataTableSource {
  final List<ProjectEntity> projectList;
  BuildContext context;

  PendedProjectRows({required this.projectList, required this.context});
  @override
  DataRow? getRow(int index) {
    final GlobalKey iconKey = GlobalKey();

    final project = projectList[index];
    return DataRow2(
      onTap:
          () => showDialog(
            context: context,
            builder: (context) => ProjectDetailsDialog(project: project),
          ),
      selected: false,
      onSelectChanged: (value) {},
      cells: [
        DataCell(ProjectTypeStatusContainer(projectType: project.pType)),
        DataCell(DynamicStatusContainer(status: project.status)),
        DataCell(VisibilityStatusContainer(visibility: project.visibility)),
        DataCell(CooperationTypeContainer(cooperationType: project.cType)),
        // DataCell(
        //   Text(
        //     HelperFunctions.formatDate(project.endDate),
        //     style: AppTextStyle.dataTableCellStyle(),
        //   ),
        // ),
        // DataCell(
        //   Text(
        //     HelperFunctions.projectDurationText(
        //       project.startDate,
        //       project.endDate,
        //     ),
        //     style: AppTextStyle.dataTableCellStyle(),
        //   ),
        // ),
        DataCell(
          Text(
            project.team?.name ?? "No Team Selected",
            style: AppTextStyle.dataTableCellStyle(),
          ),
        ),
        DataCell(
          AssignTeamButton(
            key: iconKey,
            onTap: () {
              context.pushNamed(
                AppRouteConfig.selectTeam,
                pathParameters: {'id': project.id.toString()},
              );
            },
          ),
        ),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => projectList.length;

  @override
  int get selectedRowCount => 0;
}
