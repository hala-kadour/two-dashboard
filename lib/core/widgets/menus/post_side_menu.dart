import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:two_dashboard/config/routes/app_route_config.dart';
import 'package:two_dashboard/config/theme/color.dart';
import 'package:two_dashboard/core/widgets/dialog/global/confirm_deletion_dialog.dart';
import 'package:two_dashboard/core/widgets/menus/custom_side_menu_item.dart';
import 'package:two_dashboard/features/posts/domain/entities/post_entity.dart';
import 'package:two_dashboard/features/posts/presentation/bloc/post_bloc.dart';

void showPostCardSideMenu(
  GlobalKey<State<StatefulWidget>> iconKey,
  BuildContext context,
  PostEntity post,
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
      if (post.active == 1)
        PopupMenuItem<int>(
          value: 0,
          child: CustomSideMenuItem(
            icon: Iconsax.eye_slash,
            color: AppColors.yellowShade2,
            action: "Un Active",
          ),
        ),
      PopupMenuItem<int>(
        value: 1,
        child: CustomSideMenuItem(
          icon: Iconsax.trash,
          color: AppColors.redShade2,
          action: "Delete",
        ),
      ),
      PopupMenuItem<int>(
        value: 2,
        child: CustomSideMenuItem(
          icon: Iconsax.message,
          color: AppColors.blueShade2,
          action: "Replies",
        ),
      ),
    ],
  ).then((value) {
    if (value == 0) {
      context.read<PostBloc>().add(UnActivePostEvent(postId: post.postId));
    } else if (value == 1) {
      confirmDeletionDialog(context, "this post", () {
        context.read<PostBloc>().add(DeletePostEvent(postId: post.postId));
        context.read<PostBloc>().add(GetActivePostsEvent());
        context.pop();
      });
    } else if (value == 2) {
      context.pushNamed(
        AppRouteConfig.postReplies,
        pathParameters: {'id': post.postId.toString()},
      );
    }
  });
}
