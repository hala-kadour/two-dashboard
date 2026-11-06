import 'package:dartz/dartz.dart';
import 'package:two_dashboard/core/error/failures.dart';
import 'package:two_dashboard/core/error/handling_exception_manager.dart';
import 'package:two_dashboard/core/param/contract_param.dart';
import 'package:two_dashboard/features/contracts/data/models/contract_model.dart';

abstract class ContractRepo with HandlingExceptionManager {
  // create draft & CreateDraftParam
  Future<Either<Failure, Unit>> addDraft(AddDraftParam param);
  // show contact & ShowContractParam
  Future<Either<Failure, List<ContractModel>>> showContractList(
    ShowContractParam param,
  );
  //** for contract manager **//
  // show contract list & token
  Future<Either<Failure, List<ContractModel>>> showContractManagerContrcatList(
    String token,
  );
  // update contract & CMUpdateContractParam
  Future<Either<Failure, Unit>> contractManagerUpdateContract(
    CMUpdateContractParam param,
  );
  // approve contract & ApproveContractParam
  Future<Either<Failure, Unit>> contractManagerApproveContract(
    ApproveContractParam param,
  );

  //** for project manager **//
  // update contract & PMUpdateContractParam
  Future<Either<Failure, Unit>> projectManagerUpdateContract(
    PMUpdateContractParam param,
  );
  // approve contract & ApproveContractParam
  Future<Either<Failure, Unit>> projectManagerApproveContract(
    ApproveContractParam param,
  );
  //** for admin **//
  // show contract list & ShowAdminContractParam
  Future<Either<Failure, List<ContractModel>>> showAdminContractList(
    ShowAdminContractParam param,
  );
  // admin sign contract & AdminSignContractParam
  Future<Either<Failure, Unit>> adminSignContract(AdminSignContractParam param);
}
