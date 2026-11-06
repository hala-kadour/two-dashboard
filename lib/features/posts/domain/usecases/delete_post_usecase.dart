import 'package:dartz/dartz.dart';
import 'package:two_dashboard/core/param/casule_param.dart';

import 'package:two_dashboard/core/usecases/use_case.dart';
import 'package:two_dashboard/features/posts/domain/repos/post_repo.dart';

import '../../../../core/error/failures.dart';

class DeletePostUsecase
    extends UseCase<Future<Either<Failure, Unit>>, TokenWithIdParam> {
  DeletePostUsecase(this.postRepo);
  final PostRepo postRepo;

  @override
  Future<Either<Failure, Unit>> call(TokenWithIdParam param) {
    return postRepo.deletePost(param);
  }
}
