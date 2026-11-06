import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:two_dashboard/config/routes/app_route_config.dart';
import 'package:two_dashboard/core/network/enums.dart';
import 'package:two_dashboard/core/widgets/animation/error_status_animation.dart';
import 'package:two_dashboard/core/widgets/animation/loading_status_animation.dart';
import 'package:two_dashboard/core/widgets/animation/unauthorized_status_animation.dart';
import 'package:two_dashboard/core/widgets/data-table/custom/posts-replies/loading_post_replies_table.dart';
import 'package:two_dashboard/core/widgets/data-table/custom/posts-replies/post_replies_table.dart';
import 'package:two_dashboard/core/widgets/dialog/status/error_dialog.dart';
import 'package:two_dashboard/core/widgets/dialog/status/loading_dialog.dart';
import 'package:two_dashboard/core/widgets/dialog/status/not_authorized_dialog.dart';
import 'package:two_dashboard/core/widgets/dialog/status/success_dialog.dart';
import 'package:two_dashboard/features/posts/presentation/bloc/post_bloc.dart';
import 'package:two_dashboard/features/posts/presentation/widgets/post_card.dart';

class PostsBlocStateHandling {
  // Get Post Table
  Widget getPostsGridView(PostState state, bool actriveSelected) {
    if (state.activePostsListStatus == CasualStatus.loading ||
        state.unActivePostsListStatus == CasualStatus.loading) {
      return Center(child: const LoadingStatusAnimation());
    } else if (state.activePostsListStatus == CasualStatus.success ||
        state.unActivePostsListStatus == CasualStatus.success) {
      if (actriveSelected) {
        return Expanded(
          child: GridView.builder(
            itemCount: state.activePostsList.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 0.9,
            ),
            itemBuilder:
                (context, index) =>
                    PostCard(postEntity: state.activePostsList[index]),
          ),
        );
      } else {
        return Expanded(
          child: GridView.builder(
            itemCount: state.unActivePostsList.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 0.9,
            ),
            itemBuilder:
                (context, index) =>
                    PostCard(postEntity: state.unActivePostsList[index]),
          ),
        );
      }
    } else if (state.activePostsListStatus == CasualStatus.failure ||
        state.unActivePostsListStatus == CasualStatus.failure) {
      return Center(child: ErrorStatusAnimation(errorMessage: state.message));
    } else {
      return const SizedBox();
    }
  }

  // Delete And Unactive
  void deletePost(PostState state, BuildContext context) {
    if (state.deletePostStatus == CasualStatus.loading) {
      showLoadingDialog(context);
    } else if (state.deletePostStatus == CasualStatus.success) {
      context.pop();
      context.read<PostBloc>().add(GetActivePostsEvent());
      showSuccessDialog(context, () {
        context.pop();
      });
      context.pop();
    } else if (state.deletePostStatus == CasualStatus.failure) {
      context.pop();
      showErrorDialog(context, state.message);
    } else if (state.deletePostStatus == CasualStatus.not_authorized) {
      context.pop();
      showNotAuthorizedDialog(context);
    }
  }

  void unActivePost(PostState state, BuildContext context) {
    if (state.unActivePostStatus == CasualStatus.loading) {
      showLoadingDialog(context);
    } else if (state.unActivePostStatus == CasualStatus.success) {
      context.pop();
      context.read<PostBloc>().add(GetActivePostsEvent());
      showSuccessDialog(context, () {
        context.pop();
      });
      context.pop();
    } else if (state.unActivePostStatus == CasualStatus.failure) {
      context.pop();
      showErrorDialog(context, state.message);
    } else if (state.unActivePostStatus == CasualStatus.not_authorized) {
      context.pop();
      showNotAuthorizedDialog(context);
    }
  }

  // Get posts replies table
  Widget getPostReplies(PostState state) {
    if (state.postsRepliesListStatus == CasualStatus.loading) {
      return const LoadingPostRepliesTable();
    } else if (state.postsRepliesListStatus == CasualStatus.success) {
      return PostRepliesTable(repliesList: state.postRepliesList);
    } else if (state.postsRepliesListStatus == CasualStatus.failure) {
      return Center(child: ErrorStatusAnimation(errorMessage: state.message));
    } else if (state.postsRepliesListStatus == CasualStatus.not_authorized) {
      return UnauthorizedStatusAnimation();
    } else {
      return const SizedBox();
    }
  }

  // Create Post
  void createPost(PostState state, BuildContext context) {
    if (state.createPostStatus == CasualStatus.loading) {
      showLoadingDialog(context);
    } else if (state.createPostStatus == CasualStatus.success) {
      context.pop();
      context.read<PostBloc>().add(GetActivePostsEvent());
      showSuccessDialog(context, () {
        context.pushReplacementNamed(AppRouteConfig.post);
        context.pop();
      });
    } else if (state.createPostStatus == CasualStatus.failure) {
      context.pop();
      showErrorDialog(context, state.message);
    } else if (state.createPostStatus == CasualStatus.not_authorized) {
      context.pop();
      showNotAuthorizedDialog(context);
    }
  }
}
