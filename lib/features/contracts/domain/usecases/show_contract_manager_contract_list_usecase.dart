import 'package:dartz/dartz.dart';
import 'package:two_dashboard/core/error/failures.dart';
import 'package:two_dashboard/core/usecases/use_case.dart';
import 'package:two_dashboard/features/contracts/data/models/contract_model.dart';
import 'package:two_dashboard/features/contracts/domain/repos/contract_repo.dart';

class ShowContractManagerContractListUsecase
    extends UseCase<Future<Either<Failure, List<ContractModel>>>, String> {
  final ContractRepo contractRepo;

  ShowContractManagerContractListUsecase(this.contractRepo);

  @override
  Future<Either<Failure, List<ContractModel>>> call(String param) {
    return contractRepo.showContractManagerContrcatList(param);
  }
}
