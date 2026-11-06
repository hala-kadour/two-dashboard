import 'package:dartz/dartz.dart';
import 'package:two_dashboard/core/error/failures.dart';
import 'package:two_dashboard/core/param/contract_param.dart';
import 'package:two_dashboard/core/usecases/use_case.dart';
import 'package:two_dashboard/features/contracts/data/models/contract_model.dart';
import 'package:two_dashboard/features/contracts/domain/repos/contract_repo.dart';

class ShowAdminContractListUsecase
    extends
        UseCase<
          Future<Either<Failure, List<ContractModel>>>,
          ShowAdminContractParam
        > {
  final ContractRepo contractRepo;

  ShowAdminContractListUsecase(this.contractRepo);

  @override
  Future<Either<Failure, List<ContractModel>>> call(
    ShowAdminContractParam param,
  ) {
    return contractRepo.showAdminContractList(param);
  }
}
