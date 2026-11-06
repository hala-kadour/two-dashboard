import 'package:dartz/dartz.dart';
import 'package:two_dashboard/core/error/failures.dart';
import 'package:two_dashboard/core/param/contract_param.dart';
import 'package:two_dashboard/core/usecases/use_case.dart';
import 'package:two_dashboard/features/contracts/data/models/contract_model.dart';
import 'package:two_dashboard/features/contracts/domain/repos/contract_repo.dart';

class ShowContractListUsecase
    extends
        UseCase<
          Future<Either<Failure, List<ContractModel>>>,
          ShowContractParam
        > {
  final ContractRepo contractRepo;

  ShowContractListUsecase(this.contractRepo);

  @override
  Future<Either<Failure, List<ContractModel>>> call(ShowContractParam param) {
    return contractRepo.showContractList(param);
  }
}
