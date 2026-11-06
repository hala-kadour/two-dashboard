import 'package:dartz/dartz.dart';
import 'package:two_dashboard/core/error/failures.dart';
import 'package:two_dashboard/core/param/about_us_why_us_param.dart';
import 'package:two_dashboard/core/usecases/use_case.dart';
import 'package:two_dashboard/features/about-us%20&%20why-us/domain/entities/why_us_entity.dart';
import 'package:two_dashboard/features/about-us%20&%20why-us/domain/repos/why_us_repo.dart';

class CreateWhyUsUsecase
    extends UseCase<Future<Either<Failure, WhyUsEntity>>, CreateWhyUsParam> {
  final WhyUsRepo whyUsRepo;

  CreateWhyUsUsecase(this.whyUsRepo);

  @override
  Future<Either<Failure, WhyUsEntity>> call(CreateWhyUsParam param) {
    return whyUsRepo.createWhyUs(param);
  }
}
