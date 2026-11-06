import 'package:dartz/dartz.dart';
import 'package:two_dashboard/core/error/failures.dart';
import 'package:two_dashboard/core/param/about_us_why_us_param.dart';
import 'package:two_dashboard/core/usecases/use_case.dart';
import 'package:two_dashboard/features/about-us%20&%20why-us/domain/repos/about_us_repo.dart';

class UpdateAboutUsUsecase
    extends UseCase<Future<Either<Failure, Unit>>, UpdateAboutUsParam> {
  final AboutUsRepo aboutUsRepol;

  UpdateAboutUsUsecase(this.aboutUsRepol);

  @override
  Future<Either<Failure, Unit>> call(UpdateAboutUsParam param) {
    return aboutUsRepol.updateAboutUs(param);
  }
}
