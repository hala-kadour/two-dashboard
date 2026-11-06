import 'package:flutter/material.dart';
import 'package:two_dashboard/config/constants/padding_config.dart';
import 'package:two_dashboard/core/widgets/divider/custom_divider.dart';
import 'package:two_dashboard/features/projects%20&%20team%20&%20status%20&%20meeting/domain/entity/project_entity.dart';

class ProjectDetailsDialog extends StatelessWidget {
  final ProjectEntity project;

  const ProjectDetailsDialog({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      insetPadding: const EdgeInsets.all(16),
      child: Container(
        width: 700,
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ✅ العنوان
              Text(
                "Project #${project.id}",
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              PaddingConfig.h8,
              Text(
                project.projectDescription.isNotEmpty
                    ? project.projectDescription
                    : "No Description",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              CustomDivider(),
              PaddingConfig.h8,
              // ✅ معلومات أساسية
              Wrap(
                runSpacing: 12,
                spacing: 30,
                children: [
                  _buildInfoItem("Type", project.pType.name),
                  _buildInfoItem("Cooperation", project.cType.name),
                  _buildInfoItem("Visibility", project.visibility.name),
                  _buildInfoItem("Contact Time", project.contactTime),
                  _buildInfoItem("Status", project.status),
                  _buildInfoItem("Start", project.start ?? "-"),
                  _buildInfoItem("End", project.end ?? "-"),
                  _buildInfoItem("Review", project.review?.toString() ?? "-"),
                ],
              ),

              CustomDivider(),

              // ✅ Requirements
              if (project.requirements.isNotEmpty) ...[
                Text(
                  "Requirements",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),
                const SizedBox(height: 8),
                Text(project.requirements),
                CustomDivider(),
              ],

              // ✅ Contract
              if (project.contract != null) ...[
                Text("Contract", style: Theme.of(context).textTheme.bodySmall),
                const SizedBox(height: 8),
                Text("ID: ${project.contract?.id}"),
                Text("Status: ${project.contract!.status}"),
                Text(
                  "Manager Signed: ${project.contract?.contractManagerStatus}",
                ),
                Text(
                  "Project Manager Signed: ${project.contract?.projectManagerStatus}",
                ),
                CustomDivider(),
              ],

              // ✅ Team
              if (project.team != null) ...[
                Text("Team", style: Theme.of(context).textTheme.bodySmall),
                const SizedBox(height: 8),
                Text("Team Name: ${project.team?.name ?? "No Team Selected"}"),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children:
                      project.team?.members
                          .map(
                            (m) => Chip(
                              label: Text(
                                "${m.name} (${m.role})${m.isManager ? ' ⭐' : ''}",
                              ),
                            ),
                          )
                          .toList() ??
                      [],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoItem(String label, String value) {
    return SizedBox(
      width: 200,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          ),
          const SizedBox(height: 4),
          Text(value, style: const TextStyle(fontSize: 12, color: Colors.grey)),
        ],
      ),
    );
  }
}
