import 'package:dartz/dartz.dart';
import 'package:two_dashboard/core/error/failures.dart';
import 'package:two_dashboard/core/param/profile_param.dart';
import 'package:two_dashboard/core/usecases/use_case.dart';
import 'package:two_dashboard/features/profile/domain/repos/profile_repo.dart';

class UpdateEmployeeProfileUsecase
    extends UseCase<Future<Either<Failure, Unit>>, UpdateEmployeeProfileParam> {
  final ProfileRepo profileRepo;

  UpdateEmployeeProfileUsecase(this.profileRepo);

  @override
  Future<Either<Failure, Unit>> call(UpdateEmployeeProfileParam param) {
    return profileRepo.updateEmployeeProfile(param);
  }
}
