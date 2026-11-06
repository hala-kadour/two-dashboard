import 'package:flutter/material.dart';
import 'package:two_dashboard/features/contracts/presentation/widgets/create_draft_form.dart';

class CreateDraftPage extends StatelessWidget {
  const CreateDraftPage({super.key, required this.projectId});
  final String projectId;

  @override
  Widget build(BuildContext context) {
    return CreateDraftForm(projectId: int.parse(projectId));
  }
}
