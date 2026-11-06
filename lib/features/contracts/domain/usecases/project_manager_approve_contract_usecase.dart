import 'package:dartz/dartz.dart';
import 'package:two_dashboard/core/error/failures.dart';
import 'package:two_dashboard/core/param/contract_param.dart';
import 'package:two_dashboard/core/usecases/use_case.dart';
import 'package:two_dashboard/features/contracts/domain/repos/contract_repo.dart';

class ProjectManagerApproveContractUsecase
    extends UseCase<Future<Either<Failure, Unit>>, ApproveContractParam> {
  final ContractRepo contractRepo;

  ProjectManagerApproveContractUsecase(this.contractRepo);

  @override
  Future<Either<Failure, Unit>> call(ApproveContractParam param) {
    return contractRepo.projectManagerApproveContract(param);
  }
}
