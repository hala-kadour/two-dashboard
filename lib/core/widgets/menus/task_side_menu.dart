import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:two_dashboard/config/theme/color.dart';
import 'package:two_dashboard/core/widgets/dialog/global/confirm_deletion_dialog.dart';
import 'package:two_dashboard/core/widgets/menus/custom_side_menu_item.dart';
import 'package:two_dashboard/features/sprints%20&%20tasks/presentation/bloc/sprint_and_task_bloc.dart';

void showTaskCardSideMenu(
  GlobalKey<State<StatefulWidget>> iconKey,
  BuildContext context,
  int taskId,
) async {
  final RenderBox renderBox =
      iconKey.currentContext!.findRenderObject() as RenderBox;
  final Offset offset = renderBox.localToGlobal(Offset.zero);
  final Size size = renderBox.size;
  showMenu(
    context: context,
    position: RelativeRect.fromLTRB(
      offset.dx,
      offset.dy - 40,
      offset.dx + size.width,
      0,
    ),
    items: [
      PopupMenuItem<int>(
        value: 1,
        child: CustomSideMenuItem(
          icon: Iconsax.trash,
          color: AppColors.redShade2,
          action: "Delete",
        ),
      ),
    ],
  ).then((value) {
    confirmDeletionDialog(
      context,
      "this task",
      () => context.read<SprintAndTaskBloc>().add(
        DeleteTaskEvent(taskId: taskId),
      ),
    );
  });
}
