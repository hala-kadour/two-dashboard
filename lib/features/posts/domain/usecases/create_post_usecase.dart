// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:dartz/dartz.dart';
import 'package:two_dashboard/core/param/post_param.dart';

import 'package:two_dashboard/core/usecases/use_case.dart';
import 'package:two_dashboard/features/posts/domain/entities/post_entity.dart';
import 'package:two_dashboard/features/posts/domain/repos/post_repo.dart';

import '../../../../core/error/failures.dart';

class CreatePostUsecase
    extends UseCase<Future<Either<Failure, PostEntity>>, CreatePostParam> {
  CreatePostUsecase(this.postRepo);
  final PostRepo postRepo;
  @override
  Future<Either<Failure, PostEntity>> call(CreatePostParam param) {
    return postRepo.createPost(param);
  }
}
