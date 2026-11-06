import 'package:dartz/dartz.dart';
import 'package:two_dashboard/core/error/failures.dart';
import 'package:two_dashboard/core/usecases/no_param_use_case.dart';
import 'package:two_dashboard/features/roles/data/models/role_response_model.dart';
import 'package:two_dashboard/features/roles/domain/repos/role_repo.dart';

class ShowRolesWithoutClientUsecase
    extends NoParamUseCase<Future<Either<Failure, List<RoleModel>>>> {
  final RoleRepo roleRepo;

  ShowRolesWithoutClientUsecase(this.roleRepo);

  @override
  Future<Either<Failure, List<RoleModel>>> call() {
    return roleRepo.showRolesWithoutClient();
  }
}
