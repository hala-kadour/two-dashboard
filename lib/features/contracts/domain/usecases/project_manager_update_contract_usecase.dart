import 'package:dartz/dartz.dart';
import 'package:two_dashboard/core/error/failures.dart';
import 'package:two_dashboard/core/param/contract_param.dart';
import 'package:two_dashboard/core/usecases/use_case.dart';
import 'package:two_dashboard/features/contracts/domain/repos/contract_repo.dart';

class ProjectManagerUpdateContractUsecase
    extends UseCase<Future<Either<Failure, Unit>>, PMUpdateContractParam> {
  final ContractRepo contractRepo;

  ProjectManagerUpdateContractUsecase(this.contractRepo);

  @override
  Future<Either<Failure, Unit>> call(PMUpdateContractParam param) {
    return contractRepo.projectManagerUpdateContract(param);
  }
}
