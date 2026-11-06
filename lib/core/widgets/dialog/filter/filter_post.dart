import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:two_dashboard/config/constants/padding_config.dart';
import 'package:two_dashboard/config/constants/sizes_config.dart';
import 'package:two_dashboard/config/strings/text_strings.dart';
import 'package:two_dashboard/core/widgets/buttons/text-buttons/apply_text_button.dart';
import 'package:two_dashboard/core/widgets/buttons/text-buttons/cancel_text_button.dart';
import 'package:two_dashboard/core/widgets/dialog/filter/filter_custom_widgets.dart';
import 'package:two_dashboard/features/posts/presentation/bloc/post_bloc.dart';

class FilterPost {
  // Posts Filter By  Activation //
  void filterPosts(BuildContext context, ValueNotifier<bool> actriveSelected) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: FilterByText(),
            content: SizedBox(
              height: SizesConfig.dialogHightXs,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FilterOptionTitle(
                    title: TextStrings.activation,
                    iconData: Iconsax.activity,
                  ),
                  PaddingConfig.h16,
                  Row(
                    children: [
                      FilterOption(
                        option: TextStrings.active,
                        valueNotifier: actriveSelected,
                      ),
                      PaddingConfig.w8,
                      FilterOption(
                        option: TextStrings.notActive,
                        valueNotifier: actriveSelected,
                        isOposite: true,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            actions: [
              const CancelTextButton(),
              ApplyTextButton(
                onPressed: () {
                  if (actriveSelected.value) {
                    context.read<PostBloc>().add(GetActivePostsEvent());
                  } else {
                    context.read<PostBloc>().add(GetUnActivePostsEvent());
                  }
                  context.pop();
                },
              ),
            ],
          ),
    );
  }

  // Posts Replies Filter By Acceptance //
  Future<dynamic> postRepliesFilter(
    BuildContext context,
    ValueNotifier<bool> acceptedSelected,
    String postId,
  ) {
    return showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: FilterByText(),
            content: SizedBox(
              height: SizesConfig.dialogHightXs,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FilterOptionTitle(
                    title: "Acceptance",
                    iconData: Iconsax.activity,
                  ),
                  PaddingConfig.h8,
                  Row(
                    children: [
                      FilterOption(
                        option: "accepted",
                        valueNotifier: acceptedSelected,
                      ),
                      PaddingConfig.w8,
                      FilterOption(
                        option: "not accepted",
                        valueNotifier: acceptedSelected,
                        isOposite: true,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            actions: [
              const CancelTextButton(),
              ApplyTextButton(
                onPressed: () {
                  context.read<PostBloc>().add(
                    acceptedSelected.value
                        ? GetPostsAcceptedRepliesEvent(
                          postId: int.parse(postId),
                        )
                        : GetPostsRepliesEvent(postId: int.parse(postId)),
                  );
                  context.pop();
                },
              ),
            ],
          ),
    );
  }
}
