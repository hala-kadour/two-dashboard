import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:two_dashboard/config/routes/app_route_config.dart';
import 'package:two_dashboard/config/theme/color.dart';
import 'package:two_dashboard/core/widgets/menus/custom_side_menu_item.dart';

void showPendedProjectActionSideMenu(
  GlobalKey<State<StatefulWidget>> iconKey,
  BuildContext context,
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
          icon: Iconsax.like_1,
          color: AppColors.blueShade2,
          action: "Specify Team",
        ),
      ),
    ],
  ).then((value) {
    if (value == 0) {
      context.pushReplacementNamed(
        AppRouteConfig.selectTeam,
        pathParameters: {'id': projectId.toString()},
      );
    }
    // if (value == 0) {
    //   context.read<ProjectStatusTeamBloc>().add(
    //     ApproveProjectsEvent(projectId: project.id),
    //   );
    //   context.read<ProjectStatusTeamBloc>().add(ShowPendedProjectsEvent());
    // } else if (value == 1) {
    //   sentRejectProjectMessageDialog(context, project.id);
    // }
  });
}
