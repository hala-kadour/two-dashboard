import 'package:two_dashboard/config/constants/base_uri.dart';
import 'package:two_dashboard/core/api/get_with_token_api.dart';
import 'package:two_dashboard/core/api/post_api_with_token.dart';
import 'package:two_dashboard/core/models/empty_response_model.dart';
import 'package:two_dashboard/core/param/contract_param.dart';
import 'package:two_dashboard/features/contracts/data/models/add_draft_response_model.dart';
import 'package:two_dashboard/features/contracts/data/models/show_contract_list_response_model.dart';

abstract class ContractRemoteDatasource {
  // create draft & CreateDraftParam
  Future<AddDraftResponseModel> addDraft(AddDraftParam param);
  // show contact & ShowContractParam
  Future<ShowContractListResponseModel> showContractList(
    ShowContractParam param,
  );
  //** for contract manager **//
  // show contract list & token
  Future<ShowContractListResponseModel> showContractManagerContrcatList(
    String token,
  );
  // update contract & CMUpdateContractParam
  Future<EmptyResponseModel> contractManagerUpdateContract(
    CMUpdateContractParam param,
  );
  // approve contract & ApproveContractParam
  Future<EmptyResponseModel> contractManagerApproveContract(
    ApproveContractParam param,
  );

  //** for project manager **//
  // update contract & PMUpdateContractParam
  Future<EmptyResponseModel> projectManagerUpdateContract(
    PMUpdateContractParam param,
  );
  // approve contract & ApproveContractParam
  Future<EmptyResponseModel> projectManagerApproveContract(
    ApproveContractParam param,
  );
  //** for admin **//
  // show contract list & ShowAdminContractParam
  Future<ShowContractListResponseModel> showAdminContractList(
    ShowAdminContractParam param,
  );
  // admin sign contract & AdminSignContractParam
  Future<EmptyResponseModel> adminSignContract(AdminSignContractParam param);
}

class ContractRemoteDatasourceImpl implements ContractRemoteDatasource {
  @override
  Future<AddDraftResponseModel> addDraft(AddDraftParam param) async {
    final result = PostWithTokenApi(
      uri: Uri.parse("$baseUri/api/create/draft"),
      token: param.token,
      body: ({
        'contract': '$pdfBase64${param.pdfFilePath}',
        'project_id': param.projectId,
      }),
      fromJson: addDraftResponseModelFromJson,
    );
    return await result.call();
  }

  @override
  Future<EmptyResponseModel> adminSignContract(
    AdminSignContractParam param,
  ) async {
    final result = PostWithTokenApi(
      uri: Uri.parse("$baseUri/api/ceo/add/signature"),
      token: param.token,
      body: ({
        'signature': '$imageBase64${param.signature}',
        'contract_id': param.contractId,
      }),
      fromJson: emptyResponseModelFromJson,
    );
    return await result.call();
  }

  @override
  Future<EmptyResponseModel> contractManagerApproveContract(
    ApproveContractParam param,
  ) async {
    final result = PostWithTokenApi(
      uri: Uri.parse("$baseUri/api/contract-manager/approve/contract"),
      token: param.token,
      body: ({'contract_id': param.contractId, 'project_id': param.projectId}),
      fromJson: emptyResponseModelFromJson,
    );
    return await result.call();
  }

  @override
  Future<EmptyResponseModel> contractManagerUpdateContract(
    CMUpdateContractParam param,
  ) async {
    final result = PostWithTokenApi(
      uri: Uri.parse("$baseUri/api/contract-manager/update/contract"),
      token: param.token,
      body: ({
        'contract': '$pdfBase64${param.pdfFilePath}',
        'contract_id': param.contractId,
      }),
      fromJson: emptyResponseModelFromJson,
    );
    return await result.call();
  }

  @override
  Future<EmptyResponseModel> projectManagerApproveContract(
    ApproveContractParam param,
  ) async {
    final result = PostWithTokenApi(
      uri: Uri.parse("$baseUri/api/project-manager/approve/contract"),
      token: param.token,
      body: ({'contract_id': param.contractId, 'project_id': param.projectId}),
      fromJson: emptyResponseModelFromJson,
    );
    return await result.call();
  }

  @override
  Future<EmptyResponseModel> projectManagerUpdateContract(
    PMUpdateContractParam param,
  ) async {
    final result = PostWithTokenApi(
      uri: Uri.parse("$baseUri/api/project-manager/update/contract"),
      token: param.token,
      body: ({
        'contract': '$pdfBase64${param.pdfFilePath}',
        'contract_id': param.contractId,
        'project_id': param.projectId,
      }),
      fromJson: emptyResponseModelFromJson,
    );
    return await result.call();
  }

  @override
  Future<ShowContractListResponseModel> showAdminContractList(
    ShowAdminContractParam param,
  ) async {
    final result = GetWithTokenApi(
      uri: Uri.parse(
        "$baseUri/api/show/admin/contracts?filter[admin_sign]=${param.adminSignFilter}",
      ),
      token: param.token,
      fromJson: showContractListResponseModelFromJson,
    );
    return await result.callRequest();
  }

  @override
  Future<ShowContractListResponseModel> showContractList(
    ShowContractParam param,
  ) async {
    final result = GetWithTokenApi(
      uri: Uri.parse(
        "$baseUri/api/show/contracts?filter[state]=${param.stateFilter}",
      ),
      token: param.token,
      fromJson: showContractListResponseModelFromJson,
    );
    return await result.callRequest();
  }

  @override
  Future<ShowContractListResponseModel> showContractManagerContrcatList(
    String token,
  ) async {
    final result = GetWithTokenApi(
      uri: Uri.parse("$baseUri/api/show/contract-manager/contracts"),
      token: token,
      fromJson: showContractListResponseModelFromJson,
    );
    return await result.callRequest();
  }
}
