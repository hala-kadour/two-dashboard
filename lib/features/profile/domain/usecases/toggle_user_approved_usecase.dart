import 'package:dartz/dartz.dart';
import 'package:two_dashboard/core/error/failures.dart';
import 'package:two_dashboard/core/param/casule_param.dart';
import 'package:two_dashboard/core/usecases/use_case.dart';
import 'package:two_dashboard/features/profile/domain/repos/profile_repo.dart';

class ToggleUserApprovedUsecase
    extends UseCase<Future<Either<Failure, Unit>>, TokenWithIdParam> {
  ToggleUserApprovedUsecase(this.profileRepo);
  final ProfileRepo profileRepo;

  @override
  Future<Either<Failure, Unit>> call(TokenWithIdParam param) {
    return profileRepo.toggleUserApproved(param);
  }
}
