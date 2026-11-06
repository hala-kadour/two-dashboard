import 'package:dartz/dartz.dart';
import 'package:two_dashboard/core/error/failures.dart';
import 'package:two_dashboard/core/param/casule_param.dart';
import 'package:two_dashboard/core/usecases/use_case.dart';
import 'package:two_dashboard/features/about-us%20&%20why-us/domain/repos/why_us_repo.dart';

class DeleteWhyUsUsecase
    extends UseCase<Future<Either<Failure, Unit>>, TokenWithIdParam> {
  final WhyUsRepo whyUsRepo;

  DeleteWhyUsUsecase(this.whyUsRepo);

  @override
  Future<Either<Failure, Unit>> call(TokenWithIdParam param) {
    return whyUsRepo.deleteWhyUs(param);
  }
}
