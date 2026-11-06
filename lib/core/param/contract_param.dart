class AddDraftParam {
  final String token;
  final String pdfFilePath;
  final int projectId;

  AddDraftParam({
    required this.token,
    required this.pdfFilePath,
    required this.projectId,
  });
}

class ShowContractParam {
  final String token;
  final int stateFilter;

  ShowContractParam({required this.token, required this.stateFilter});
}

class ApproveContractParam {
  final String token;
  final int contractId;
  final int projectId;

  ApproveContractParam({
    required this.token,
    required this.contractId,
    required this.projectId,
  });
}

// ** Contract Manager Param ** //

class CMUpdateContractParam {
  final String token;
  final String pdfFilePath;
  final String contractId;

  CMUpdateContractParam({
    required this.token,
    required this.pdfFilePath,
    required this.contractId,
  });
}

// ** Project Manager Param ** //

class PMUpdateContractParam {
  final String token;
  final String pdfFilePath;
  final String contractId;
  final String projectId;

  PMUpdateContractParam({
    required this.token,
    required this.pdfFilePath,
    required this.contractId,
    required this.projectId,
  });
}

// ** Admin Param ** //
class ShowAdminContractParam {
  final String token;
  final int adminSignFilter;

  ShowAdminContractParam({required this.token, required this.adminSignFilter});
}

class AdminSignContractParam {
  final String token;
  final String signature;
  final String contractId;

  AdminSignContractParam({
    required this.token,
    required this.signature,
    required this.contractId,
  });
}
