import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:two_dashboard/config/theme/color.dart';
import 'package:two_dashboard/core/widgets/dialog/global/confirm_deletion_dialog.dart';
import 'package:two_dashboard/core/widgets/menus/custom_side_menu_item.dart';
import 'package:two_dashboard/features/projects%20&%20team%20&%20status%20&%20meeting/presentation/bloc/project_status_team_meeting_bloc.dart';

void showStatusSideMenu(
  GlobalKey<State<StatefulWidget>> iconKey,
  BuildContext context,
  int statusId,
  int projectId,
) async {
  final RenderBox renderBox =
      iconKey.currentContext!.findRenderObject() as RenderBox;
  final Offset offset = renderBox.localToGlobal(Offset.zero);
  final Size size = renderBox.size;
  showMenu(
    context: context,
    position: RelativeRect.fromLTRB(
      offset.dx,
      offset.dy - 37,
      offset.dx + size.width,
      0,
    ),
    items: [
      PopupMenuItem<int>(
        value: 0,
        child: CustomSideMenuItem(
          icon: Iconsax.trash,
          color: AppColors.redShade2,
          action: "Delete",
        ),
      ),
    ],
  ).then((value) {
    if (value == 0) {
      confirmDeletionDialog(context, "this status", () {
        context.read<ProjectStatusTeamMeetingBloc>().add(
          DeleteStatusEvent(projectId: projectId, statusId: statusId),
        );
        context.read<ProjectStatusTeamMeetingBloc>().add(
          ShowProjectStatusEvent(projectId: projectId),
        );
        context.pop();
      });
    }
  });
}
