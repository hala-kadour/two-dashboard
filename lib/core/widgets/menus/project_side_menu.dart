import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:two_dashboard/config/routes/app_route_config.dart';
import 'package:two_dashboard/config/theme/color.dart';
import 'package:two_dashboard/core/widgets/menus/custom_side_menu_item.dart';
import 'package:two_dashboard/features/projects%20&%20team%20&%20status%20&%20meeting/domain/entity/project_entity.dart';

void showPendedProjectActionSideMenu(
  GlobalKey<State<StatefulWidget>> iconKey,
  BuildContext context,
  ProjectEntity project,
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
          icon: Iconsax.edit,
          color: AppColors.blueShade3,
          action: "Edit",
        ),
      ),
      PopupMenuItem<int>(
        value: 1,
        child: CustomSideMenuItem(
          icon: Iconsax.add,
          color: AppColors.greenShade2,
          action: (project.team == null) ? "Add Team" : "Add New Members",
        ),
      ),
    ],
  ).then((value) {
    if (value == 0) {
    } else if (value == 1) {
      context.pushNamed(
        AppRouteConfig.selectTeam,
        pathParameters: {'project-id': project.id.toString()},
      );
    }
  });
}
