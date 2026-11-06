import 'package:flutter/material.dart';
import 'package:two_dashboard/features/contracts/presentation/widgets/cm_update_contract_form.dart';

class CmUpdateContractPage extends StatelessWidget {
  const CmUpdateContractPage({super.key, required this.contractId});
  final String contractId;

  @override
  Widget build(BuildContext context) {
    return CmUpdateContractForm(contractId: contractId);
  }
}
