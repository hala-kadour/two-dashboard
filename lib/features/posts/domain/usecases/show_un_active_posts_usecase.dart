import 'package:dartz/dartz.dart';
import 'package:two_dashboard/core/error/failures.dart';
import 'package:two_dashboard/core/usecases/no_param_use_case.dart';
import 'package:two_dashboard/features/posts/domain/entities/post_entity.dart';
import 'package:two_dashboard/features/posts/domain/repos/post_repo.dart';

class ShowUnActivePostsUsecase
    extends NoParamUseCase<Future<Either<Failure, List<PostEntity>>>> {
  final PostRepo postRepo;

  ShowUnActivePostsUsecase(this.postRepo);

  @override
  Future<Either<Failure, List<PostEntity>>> call() {
    return postRepo.showUnActivePosts();
  }
}
