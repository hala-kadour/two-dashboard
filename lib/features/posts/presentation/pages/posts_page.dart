import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:two_dashboard/config/constants/padding_config.dart';
import 'package:two_dashboard/config/constants/sizes_config.dart';
import 'package:two_dashboard/config/routes/app_route_config.dart';
import 'package:two_dashboard/core/functions/bloc-state-handling/posts_bloc_state_handling.dart';
import 'package:two_dashboard/core/widgets/buttons/elevated-buttons/create_elevated_button.dart';
import 'package:two_dashboard/core/widgets/buttons/icon-buttons/filter_button.dart';
import 'package:two_dashboard/core/widgets/dialog/filter/filter_post.dart';
import 'package:two_dashboard/core/widgets/texts/page_title.dart';
import 'package:two_dashboard/features/posts/presentation/bloc/post_bloc.dart';

class PostsPage extends StatefulWidget {
  const PostsPage({super.key});

  @override
  State<PostsPage> createState() => _ShowPostsPageState();
}

class _ShowPostsPageState extends State<PostsPage> {
  ValueNotifier<bool> actriveSelected = ValueNotifier(true);
  @override
  void didChangeDependencies() {
    context.read<PostBloc>().add(GetActivePostsEvent());
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(SizesConfig.lg),

        child: Column(
          children: [
            const PageTitle(pageTitle: "Posts"),
            const SizedBox(height: SizesConfig.spaceBtwSections),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CreateElevatedButton(
                  addingType: "Post",
                  onPressed: () {
                    context.pushNamed(AppRouteConfig.createPost);
                  },
                ),
                PaddingConfig.w8,
                FilterButton(
                  onPressed: () {
                    FilterPost().filterPosts(context, actriveSelected);
                  },
                ),
              ],
            ),
            const SizedBox(height: SizesConfig.spaceBtwSections),
            BlocListener<PostBloc, PostState>(
              listener: (context, state) {
                PostsBlocStateHandling().deletePost(state, context);
                PostsBlocStateHandling().unActivePost(state, context);
              },
              listenWhen:
                  (previous, current) =>
                      (previous.deletePostStatus != current.deletePostStatus ||
                          previous.unActivePostStatus !=
                              current.unActivePostStatus),
              child: Expanded(
                child: BlocBuilder<PostBloc, PostState>(
                  buildWhen:
                      (previous, current) =>
                          (previous.activePostsListStatus !=
                                  current.activePostsListStatus ||
                              previous.unActivePostsListStatus !=
                                  current.unActivePostsListStatus),
                  builder: (context, state) {
                    return PostsBlocStateHandling().getPostsGridView(
                      state,
                      actriveSelected.value,
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
