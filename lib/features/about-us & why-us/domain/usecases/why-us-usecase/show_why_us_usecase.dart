import 'package:dartz/dartz.dart';
import 'package:two_dashboard/core/error/failures.dart';
import 'package:two_dashboard/core/usecases/no_param_use_case.dart';
import 'package:two_dashboard/features/about-us%20&%20why-us/domain/entities/why_us_entity.dart';
import 'package:two_dashboard/features/about-us%20&%20why-us/domain/repos/why_us_repo.dart';

class ShowWhyUsUsecase
    extends NoParamUseCase<Future<Either<Failure, List<WhyUsEntity?>>>> {
  final WhyUsRepo whyUsRepo;

  ShowWhyUsUsecase(this.whyUsRepo);

  @override
  Future<Either<Failure, List<WhyUsEntity?>>> call() {
    return whyUsRepo.showWhyUs();
  }
}
