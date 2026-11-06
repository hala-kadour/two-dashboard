import 'package:dartz/dartz.dart';
import 'package:two_dashboard/core/param/post_param.dart';

import 'package:two_dashboard/core/usecases/use_case.dart';
import 'package:two_dashboard/features/posts/domain/repos/post_repo.dart';

import '../../../../core/error/failures.dart';
import '../entities/reply_entity.dart';

class ReplyToPostUsecase
    extends UseCase<Future<Either<Failure, ReplyEntity>>, ReplyToPostParam> {
  ReplyToPostUsecase(this.postRepo);
  final PostRepo postRepo;
  @override
  Future<Either<Failure, ReplyEntity>> call(ReplyToPostParam param) {
    return postRepo.replyToPost(param);
  }
}
