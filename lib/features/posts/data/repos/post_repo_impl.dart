import 'package:dartz/dartz.dart';
import 'package:two_dashboard/core/error/failures.dart';
import 'package:two_dashboard/core/network/network_connection_checker.dart';
import 'package:two_dashboard/core/param/casule_param.dart';
import 'package:two_dashboard/core/param/post_param.dart';
import 'package:two_dashboard/features/posts/data/datasources/posts_local_datasource.dart';
import 'package:two_dashboard/features/posts/data/datasources/posts_remote_datasource.dart';
import 'package:two_dashboard/features/posts/domain/entities/post_entity.dart';
import 'package:two_dashboard/features/posts/domain/entities/reply_entity.dart';
import 'package:two_dashboard/features/posts/domain/repos/post_repo.dart';

class PostRepoImpl extends PostRepo {
  final PostRemoteDatasource postRemoteDatasource;
  final PostsLocalDatasource postsLocalDatasource;
  final NetworkInfo networkInfo;

  PostRepoImpl(
    this.postRemoteDatasource,
    this.postsLocalDatasource,
    this.networkInfo,
  );

  @override
  Future<Either<Failure, Unit>> acceptReply(TokenWithIdParam reply) {
    return wrapHandling(
      tryCall: () async {
        postRemoteDatasource.acceptReply(reply);
        return const Right(unit);
      },
    );
  }

  @override
  Future<Either<Failure, PostEntity>> createPost(CreatePostParam param) {
    return wrapHandling(
      tryCall: () async {
        final result = await postRemoteDatasource.createPost(param);
        return Right(result.data);
      },
    );
  }

  @override
  Future<Either<Failure, Unit>> deletePost(TokenWithIdParam post) {
    return wrapHandling(
      tryCall: () async {
        postRemoteDatasource.deletePost(post);
        return const Right(unit);
      },
    );
  }

  @override
  Future<Either<Failure, ReplyEntity>> replyToPost(ReplyToPostParam param) {
    return wrapHandling(
      tryCall: () async {
        final result = await postRemoteDatasource.replyToPost(param);
        return Right(result.data);
      },
    );
  }

  @override
  Future<Either<Failure, List<ReplyEntity>>> showPostAcceptedReplies(
    TokenWithIdParam post,
  ) {
    return wrapHandling(
      tryCall: () async {
        if (await networkInfo.isConnected) {
          final remoteAcceptedReplies = await postRemoteDatasource
              .showPostAcceptedReplies(post);
          postsLocalDatasource.cachePostsAcceptedReply(
            remoteAcceptedReplies.data,
          );
          return Right(remoteAcceptedReplies.data);
        } else {
          final localReplies =
              await postsLocalDatasource.getCachedAcceptedPostReplies();
          return Right(localReplies);
        }
      },
    );
  }

  @override
  Future<Either<Failure, List<ReplyEntity>>> showPostReplies(
    TokenWithIdParam post,
  ) {
    return wrapHandling(
      tryCall: () async {
        if (await networkInfo.isConnected) {
          final remoteReplies = await postRemoteDatasource.showPostReplies(
            post,
          );
          postsLocalDatasource.cachePostsReply(remoteReplies.data);
          return Right(remoteReplies.data);
        } else {
          final localReplies =
              await postsLocalDatasource.getCachedPostReplies();
          return Right(localReplies);
        }
      },
    );
  }

  @override
  Future<Either<Failure, List<PostEntity>>> showActivePosts() {
    return wrapHandling(
      tryCall: () async {
        final result = await postRemoteDatasource.showActivePosts();
        return Right(result.data);
        // if (await networkInfo.isConnected) {
        //   final remotePosts = await postRemoteDatasource.showActivePosts();
        //   postsLocalDatasource.cacheActivePosts(remotePosts.data);
        //   return Right(remotePosts.data);
        // } else {
        //   final localPosts = await postsLocalDatasource.getActiveCachedPosts();
        //   return Right(localPosts);
        // }
      },
    );
  }

  @override
  Future<Either<Failure, List<PostEntity>>> showUnActivePosts() {
    return wrapHandling(
      tryCall: () async {
        if (await networkInfo.isConnected) {
          final remotePosts = await postRemoteDatasource.showUnActivePosts();
          postsLocalDatasource.cacheUnActivePosts(remotePosts.data);
          return Right(remotePosts.data);
        } else {
          final localPosts =
              await postsLocalDatasource.getUnActiveCachedPosts();
          return Right(localPosts);
        }
      },
    );
  }

  @override
  Future<Either<Failure, Unit>> unActivePost(TokenWithIdParam post) {
    return wrapHandling(
      tryCall: () async {
        postRemoteDatasource.unActivePost(post);
        return const Right(unit);
      },
    );
  }
}
