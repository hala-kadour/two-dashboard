import 'package:dartz/dartz.dart';
import 'package:two_dashboard/core/error/failures.dart';
import 'package:two_dashboard/core/param/casule_param.dart';
import 'package:two_dashboard/core/usecases/use_case.dart';
import 'package:two_dashboard/features/posts/domain/repos/post_repo.dart';

class UnActivePostUsecase
    extends UseCase<Future<Either<Failure, Unit>>, TokenWithIdParam> {
  final PostRepo postRepo;

  UnActivePostUsecase(this.postRepo);

  @override
  Future<Either<Failure, Unit>> call(TokenWithIdParam param) {
    return postRepo.unActivePost(param);
  }
}
