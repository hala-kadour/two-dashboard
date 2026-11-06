import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:two_dashboard/config/constants/padding_config.dart';
import 'package:two_dashboard/config/theme/text_style.dart';
import 'package:two_dashboard/core/helper/helper_functions.dart';
import 'package:two_dashboard/core/network/enums.dart';
import 'package:two_dashboard/core/widgets/buttons/hovered-buttons/approved_button.dart';
import 'package:two_dashboard/core/widgets/buttons/hovered-buttons/reject_button.dart';
import 'package:two_dashboard/core/widgets/container/status-containers/dynamic_status_container.dart';
import 'package:two_dashboard/core/widgets/container/status-containers/visibility_status_container.dart';
import 'package:two_dashboard/core/widgets/dialog/project/project_details_dialog.dart';
import 'package:two_dashboard/core/widgets/dialog/project/sent_reject_project_message_dialog.dart';
import 'package:two_dashboard/core/widgets/texts/linked_text.dart';
import 'package:two_dashboard/features/projects%20&%20team%20&%20status%20&%20meeting/data/models/project/project_assign_request_model.dart';
import 'package:two_dashboard/features/projects%20&%20team%20&%20status%20&%20meeting/domain/entity/project_entity.dart';
import 'package:two_dashboard/features/projects%20&%20team%20&%20status%20&%20meeting/presentation/bloc/project_status_team_meeting_bloc.dart';

class AssignedProjectRows extends DataTableSource {
  final List<ProjectAssignRequestModel> assignProjectList;
  BuildContext context;

  AssignedProjectRows({required this.assignProjectList, required this.context});
  @override
  DataRow? getRow(int index) {
    final project = assignProjectList[index];
    final message = TextEditingController();
    return DataRow2(
      onTap:
          () => showDialog(
            context: context,
            builder:
                (context) => ProjectDetailsDialog(
                  project: ProjectEntity(
                    id: project.id,
                    cType: HelperFunctions.getCooperationTypeByName(
                      project.cooperationType,
                    ),
                    pType: HelperFunctions.getProjectTypeByName(
                      project.projectType,
                    ),
                    requirements: project.requirements.join('\n'),
                    visibility: HelperFunctions.getVisibilityByNum(
                      project.private,
                    ),
                    status: project.status,
                    contactTime: project.contactTime,
                  ),
                ),
          ),
      selected: false,
      onSelectChanged: (value) {},
      cells: [
        DataCell(DynamicStatusContainer(status: project.projectType)),
        DataCell(DynamicStatusContainer(status: project.status)),
        DataCell(
          VisibilityStatusContainer(
            visibility:
                project.private == 0
                    ? ProjectVisibility.public
                    : ProjectVisibility.private,
          ),
        ),
        DataCell(
          Text(
            project.projectDescription,
            style: AppTextStyle.dataTableCellStyle(),
          ),
        ),
        DataCell(
          Text(
            project.cooperationType,
            style: AppTextStyle.dataTableCellStyle(),
          ),
        ),
        DataCell(LinkedText(link: project.document)),
        DataCell(
          Row(
            children: [
              if (project.status.toLowerCase().contains("pen"))
                ApprovedButton(
                  onTap: () {
                    context.read<ProjectStatusTeamMeetingBloc>().add(
                      ProjectManagerAcceptProjectEvent(projectId: project.id),
                    );
                  },
                ),
              PaddingConfig.w8,
              if (project.status.toLowerCase().contains("pen"))
                RejectButton(
                  onTap: () {
                    sentRejectProjectMessageDialog(
                      context,
                      project.id,
                      message,
                    );
                  },
                ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => assignProjectList.length;

  @override
  int get selectedRowCount => 0;
}
