import 'package:dartz/dartz.dart';
import 'package:two_dashboard/core/error/failures.dart';
import 'package:two_dashboard/core/error/handling_exception_manager.dart';
import 'package:two_dashboard/core/param/casule_param.dart';
import 'package:two_dashboard/core/param/post_param.dart';
import 'package:two_dashboard/features/posts/domain/entities/post_entity.dart';
import 'package:two_dashboard/features/posts/domain/entities/reply_entity.dart';

abstract class PostRepo with HandlingExceptionManager {
  Future<Either<Failure, PostEntity>> createPost(CreatePostParam param);
  Future<Either<Failure, Unit>> deletePost(TokenWithIdParam post);
  Future<Either<Failure, List<PostEntity>>> showActivePosts();
  Future<Either<Failure, List<PostEntity>>> showUnActivePosts();
  Future<Either<Failure, Unit>> unActivePost(TokenWithIdParam post);
  Future<Either<Failure, ReplyEntity>> replyToPost(ReplyToPostParam param);
  Future<Either<Failure, List<ReplyEntity>>> showPostReplies(
    TokenWithIdParam post,
  );
  Future<Either<Failure, Unit>> acceptReply(TokenWithIdParam reply);
  Future<Either<Failure, List<ReplyEntity>>> showPostAcceptedReplies(
    TokenWithIdParam post,
  );
}
