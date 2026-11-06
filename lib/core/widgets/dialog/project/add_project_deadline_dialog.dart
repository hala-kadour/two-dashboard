import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:two_dashboard/config/constants/padding_config.dart';
import 'package:two_dashboard/config/constants/sizes_config.dart';
import 'package:two_dashboard/config/theme/color.dart';
import 'package:two_dashboard/config/theme/text_style.dart';
import 'package:two_dashboard/core/helper/helper_functions.dart';
import 'package:two_dashboard/core/widgets/buttons/text-buttons/cancel_text_button.dart';
import 'package:two_dashboard/core/widgets/buttons/text-buttons/save_text_button.dart';
import 'package:two_dashboard/features/projects%20&%20team%20&%20status%20&%20meeting/presentation/bloc/project_status_team_meeting_bloc.dart';

Future<void> addProjectDeadlineDialog(
  BuildContext context,
  int projectId,
) async {
  DateTime? selectedStartDate;
  DateTime? selectedEndDate;

  await showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(
          "Add Project Deadline :",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        content: StatefulBuilder(
          builder: (context, setState) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PaddingConfig.h16,
                Text("Start Date"),
                PaddingConfig.h16,
                GestureDetector(
                  onTap: () async {
                    final date = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2100),
                    );
                    if (date != null) {
                      setState(() {
                        selectedStartDate = date;
                      });
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.gray, width: 0.7),
                      borderRadius: BorderRadius.circular(
                        SizesConfig.inputFieldRadius,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          selectedStartDate == null
                              ? "select the date"
                              : "${selectedStartDate!.year}-${selectedStartDate!.month}-${selectedStartDate!.day}",
                          style: AppTextStyle.bodySm(),
                        ),
                        PaddingConfig.w16,
                        Icon(Iconsax.calendar_1, color: AppColors.blueShade2),
                      ],
                    ),
                  ),
                ),
                PaddingConfig.h16,
                Text("End Date"),
                PaddingConfig.h16,
                GestureDetector(
                  onTap: () async {
                    final date = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2100),
                    );
                    if (date != null) {
                      setState(() {
                        selectedEndDate = date;
                      });
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.gray, width: 0.7),
                      borderRadius: BorderRadius.circular(
                        SizesConfig.inputFieldRadius,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          selectedEndDate == null
                              ? "select the date"
                              : "${selectedEndDate!.year}-${selectedEndDate!.month}-${selectedEndDate!.day}",
                          style: AppTextStyle.bodySm(),
                        ),
                        PaddingConfig.w16,
                        Icon(Iconsax.calendar_1, color: AppColors.blueShade2),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
        actions: [
          CancelTextButton(),
          SaveTextButton(
            onPressed: () {
              if (selectedStartDate != null && selectedEndDate != null) {
                context.read<ProjectStatusTeamMeetingBloc>().add(
                  ProjectMangerUpdateProjectDateEvent(
                    projectId: projectId.toString(),
                    startDate: HelperFunctions.formateDateForBack(
                      selectedStartDate!,
                    ),
                    endDate: HelperFunctions.formateDateForBack(
                      selectedEndDate!,
                    ),
                  ),
                );
                Navigator.pop(context);
              }
            },
          ),
        ],
      );
    },
  );
}
