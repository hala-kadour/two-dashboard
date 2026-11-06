import 'package:dartz/dartz.dart';
import 'package:two_dashboard/core/error/failures.dart';
import 'package:two_dashboard/core/usecases/use_case.dart';
import 'package:two_dashboard/features/profile/domain/entities/employee_entity.dart';
import 'package:two_dashboard/features/profile/domain/repos/profile_repo.dart';

class GetUserProfileUsecase
    extends UseCase<Future<Either<Failure, EmployeeEntity>>, String> {
  GetUserProfileUsecase(this.profileRepo);
  final ProfileRepo profileRepo;

  @override
  Future<Either<Failure, EmployeeEntity>> call(String param) {
    return profileRepo.getUserProfile(param);
  }
}
