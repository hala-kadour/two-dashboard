import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:two_dashboard/config/constants/padding_config.dart';
import 'package:two_dashboard/config/constants/sizes_config.dart';
import 'package:two_dashboard/config/routes/app_route_config.dart';
import 'package:two_dashboard/core/functions/bloc-state-handling/posts_bloc_state_handling.dart';
import 'package:two_dashboard/core/widgets/breadcrumbs/breadcumbs_item.dart';
import 'package:two_dashboard/core/widgets/buttons/icon-buttons/back_button.dart';
import 'package:two_dashboard/core/widgets/buttons/icon-buttons/filter_button.dart';
import 'package:two_dashboard/core/widgets/dialog/filter/filter_post.dart';
import 'package:two_dashboard/core/widgets/texts/page_title.dart';
import 'package:two_dashboard/features/posts/presentation/bloc/post_bloc.dart';

class PostRepliesPage extends StatefulWidget {
  const PostRepliesPage({super.key, required this.postId});
  final String postId;

  @override
  State<PostRepliesPage> createState() => _PostRepliesPageState();
}

class _PostRepliesPageState extends State<PostRepliesPage> {
  ValueNotifier<bool> actriveSelected = ValueNotifier(true);
  @override
  void didChangeDependencies() {
    context.read<PostBloc>().add(
      GetPostsRepliesEvent(postId: int.parse(widget.postId)),
    );
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: BlocListener<PostBloc, PostState>(
          listener: (context, state) {},
          listenWhen:
              (previous, current) =>
                  (previous.acceptReplyStatus != current.acceptReplyStatus),
          child: Column(
            children: [
              const Breadcrumbs(
                paths: [AppRouteConfig.post, AppRouteConfig.postReplies],
                pages: ["Posts", "Post Replies"],
              ),
              PaddingConfig.h16,
              Row(
                children: [
                  const CustomBackButton(),
                  PaddingConfig.w8,
                  PageTitle(pageTitle: "Posts Replies"),
                ],
              ),
              PaddingConfig.h24,
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  FilterButton(
                    onPressed:
                        () => FilterPost().postRepliesFilter(
                          context,
                          actriveSelected,
                          widget.postId,
                        ),
                  ),
                ],
              ),
              const SizedBox(height: SizesConfig.spaceBtwSections),
              Flexible(
                child: BlocBuilder<PostBloc, PostState>(
                  buildWhen:
                      (previous, current) =>
                          previous.postsRepliesListStatus !=
                          current.postsRepliesListStatus,
                  builder: (context, state) {
                    return PostsBlocStateHandling().getPostReplies(state);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
