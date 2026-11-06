import 'package:dartz/dartz.dart';
import 'package:two_dashboard/core/error/failures.dart';
import 'package:two_dashboard/core/param/contract_param.dart';
import 'package:two_dashboard/core/usecases/use_case.dart';
import 'package:two_dashboard/features/contracts/domain/repos/contract_repo.dart';

class AdminSignContractUsecase
    extends UseCase<Future<Either<Failure, Unit>>, AdminSignContractParam> {
  final ContractRepo contractRepo;

  AdminSignContractUsecase(this.contractRepo);

  @override
  Future<Either<Failure, Unit>> call(AdminSignContractParam param) {
    return contractRepo.adminSignContract(param);
  }
}
