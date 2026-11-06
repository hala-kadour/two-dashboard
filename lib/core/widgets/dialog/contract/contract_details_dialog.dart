import 'package:flutter/material.dart';
import 'package:two_dashboard/config/constants/padding_config.dart';
import 'package:two_dashboard/core/widgets/divider/custom_divider.dart';
import 'package:two_dashboard/features/contracts/data/models/contract_model.dart';

class ContractDetailsDialog extends StatelessWidget {
  final ContractModel contract;

  const ContractDetailsDialog({super.key, required this.contract});

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
                "Contract #${contract.id}",
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              PaddingConfig.h8,
              Text(
                "Related Project: #${contract.project.id}",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              CustomDivider(),

              // ✅ معلومات أساسية عن العقد
              Wrap(
                runSpacing: 12,
                spacing: 30,
                children: [
                  _buildInfoItem("Contract File", contract.contract),
                  _buildInfoItem("Status", "${contract.status ?? '-'}"),
                  _buildInfoItem(
                    "Manager Signed",
                    "${contract.contractManagerStatus ?? '-'}",
                  ),
                  _buildInfoItem(
                    "Project Manager Signed",
                    "${contract.projectManagerStatus ?? '-'}",
                  ),
                  _buildInfoItem("Need Edit", "${contract.needEdit ?? '-'}"),
                  _buildInfoItem("Admin Sign", "${contract.adminSign ?? '-'}"),
                ],
              ),

              CustomDivider(),

              // ✅ طلبات تعديل العميل
              if (contract.clientEditRequest != null) ...[
                Text(
                  "Client Edit Request",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 8),
                Text(contract.clientEditRequest.toString()),
                CustomDivider(),
              ],

              // ✅ بيانات المشروع المرتبط
              Text(
                "Project Info",
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(height: 8),
              Wrap(
                runSpacing: 12,
                spacing: 30,
                children: [
                  _buildInfoItem("Type", contract.project.projectType),
                  _buildInfoItem(
                    "Cooperation",
                    contract.project.cooperationType,
                  ),
                  _buildInfoItem("Contact Time", contract.project.contactTime),
                  _buildInfoItem("Status", contract.project.status),
                  _buildInfoItem("Private", "${contract.project.private}"),
                  _buildInfoItem(
                    "Created At",
                    contract.project.createdAt.toIso8601String(),
                  ),
                  _buildInfoItem(
                    "Updated At",
                    contract.project.updatedAt.toIso8601String(),
                  ),
                ],
              ),

              PaddingConfig.h8,

              if (contract.project.projectDescription.isNotEmpty) ...[
                Text(
                  "Description",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                PaddingConfig.h8,
                Text(contract.project.projectDescription),
              ],

              if (contract.project.requirementsList.isNotEmpty) ...[
                CustomDivider(),
                Text(
                  "Requirements",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 8),
                Wrap(
                  children:
                      contract.project.requirementsList
                          .map((r) => Chip(label: Text(r)))
                          .toList(),
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
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          ),
          const SizedBox(height: 4),
          Text(value, style: const TextStyle(fontSize: 12, color: Colors.grey)),
        ],
      ),
    );
  }
}
