import 'package:dartz/dartz.dart';
import 'package:two_dashboard/core/error/failures.dart';
import 'package:two_dashboard/core/usecases/no_param_use_case.dart';
import 'package:two_dashboard/features/about-us%20&%20why-us/domain/entities/about_us_entity.dart';
import 'package:two_dashboard/features/about-us%20&%20why-us/domain/repos/about_us_repo.dart';

class ShowAboutUsUsecase
    extends NoParamUseCase<Future<Either<Failure, AboutUsEntity>>> {
  final AboutUsRepo aboutUsRepo;

  ShowAboutUsUsecase(this.aboutUsRepo);

  @override
  Future<Either<Failure, AboutUsEntity>> call() {
    return aboutUsRepo.showAboutUs();
  }
}
