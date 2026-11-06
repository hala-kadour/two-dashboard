// ** DRAFTS ** //
class CreateDraftParam {
  String token;
  String draf;
  int clientId;
  CreateDraftParam({
    required this.token,
    required this.draf,
    required this.clientId,
  });
}

// ** CONTRACTS ** //
class AddContractParam {
  String token;
  String contract;
  int clientId;
  int drafId;
  AddContractParam({
    required this.token,
    required this.contract,
    required this.clientId,
    required this.drafId,
  });
}

class AddSignParam {
  String token;
  String signature;
  int contractId;
  AddSignParam({
    required this.token,
    required this.signature,
    required this.contractId,
  });
}

class GetDraftOrContractParam {
  String token;
  int filter;
  GetDraftOrContractParam({required this.token, required this.filter});
}
