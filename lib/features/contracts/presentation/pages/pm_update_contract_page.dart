import 'package:flutter/material.dart';
import 'package:two_dashboard/features/contracts/presentation/widgets/pm_contract_form.dart';

class PmUpdateContractPage extends StatelessWidget {
  const PmUpdateContractPage({
    super.key,
    required this.projectId,
    required this.contractId,
  });
  final String projectId;
  final String contractId;

  @override
  Widget build(BuildContext context) {
    return PmContractForm(contractId: contractId, projectId: projectId);
  }
}
