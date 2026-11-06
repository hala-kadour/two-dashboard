import 'package:dartz/dartz.dart';
import 'package:two_dashboard/core/error/failures.dart';
import 'package:two_dashboard/core/param/contract_param.dart';
import 'package:two_dashboard/features/contracts/data/datasource/contract_remote_datasource.dart';
import 'package:two_dashboard/features/contracts/data/models/contract_model.dart';
import 'package:two_dashboard/features/contracts/domain/repos/contract_repo.dart';

class ContractRepoImpl extends ContractRepo {
  final ContractRemoteDatasource contractDatasource;

  ContractRepoImpl(this.contractDatasource);

  @override
  Future<Either<Failure, Unit>> addDraft(AddDraftParam param) {
    return wrapHandling(
      tryCall: () async {
        await contractDatasource.addDraft(param);
        return Right(unit);
      },
    );
  }

  @override
  Future<Either<Failure, Unit>> adminSignContract(
    AdminSignContractParam param,
  ) {
    return wrapHandling(
      tryCall: () async {
        await contractDatasource.adminSignContract(param);
        return Right(unit);
      },
    );
  }

  @override
  Future<Either<Failure, Unit>> contractManagerApproveContract(
    ApproveContractParam param,
  ) {
    return wrapHandling(
      tryCall: () async {
        await contractDatasource.contractManagerApproveContract(param);
        return Right(unit);
      },
    );
  }

  @override
  Future<Either<Failure, Unit>> contractManagerUpdateContract(
    CMUpdateContractParam param,
  ) {
    return wrapHandling(
      tryCall: () async {
        await contractDatasource.contractManagerUpdateContract(param);
        return Right(unit);
      },
    );
  }

  @override
  Future<Either<Failure, Unit>> projectManagerApproveContract(
    ApproveContractParam param,
  ) {
    return wrapHandling(
      tryCall: () async {
        await contractDatasource.projectManagerApproveContract(param);
        return Right(unit);
      },
    );
  }

  @override
  Future<Either<Failure, Unit>> projectManagerUpdateContract(
    PMUpdateContractParam param,
  ) {
    return wrapHandling(
      tryCall: () async {
        await contractDatasource.projectManagerUpdateContract(param);
        return Right(unit);
      },
    );
  }

  @override
  Future<Either<Failure, List<ContractModel>>> showAdminContractList(
    ShowAdminContractParam param,
  ) {
    return wrapHandling(
      tryCall: () async {
        final result = await contractDatasource.showAdminContractList(param);
        return Right(result.data);
      },
    );
  }

  @override
  Future<Either<Failure, List<ContractModel>>> showContractList(
    ShowContractParam param,
  ) {
    return wrapHandling(
      tryCall: () async {
        final result = await contractDatasource.showContractList(param);
        return Right(result.data);
      },
    );
  }

  @override
  Future<Either<Failure, List<ContractModel>>> showContractManagerContrcatList(
    String token,
  ) {
    return wrapHandling(
      tryCall: () async {
        final result = await contractDatasource.showContractManagerContrcatList(
          token,
        );
        return Right(result.data);
      },
    );
  }
}
