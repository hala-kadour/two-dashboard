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
import 'package:two_dashboard/core/widgets/chips/custom_choise_chip.dart';
import 'package:two_dashboard/features/projects%20&%20team%20&%20status%20&%20meeting/presentation/bloc/project_status_team_meeting_bloc.dart';

Future<void> createMeetingDialog(BuildContext context, int projectId) async {
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  ValueNotifier<String?> selectedMeetingType = ValueNotifier(null);

  await showDialog(
    context: context,
    builder: (context) {
      final meetingTypes = [
        "Review",
        "Planning",
        "Kick-off",
        "Daily Standup",
        "Retrospective",
        "Client",
        "Demo",
        "One-to-One",
      ];
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(
          "Create Meeting",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        content: StatefulBuilder(
          builder: (context, setState) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Meeting Type", style: AppTextStyle.bodyMd()),
                PaddingConfig.h8,
                // Meeting Type
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    ...meetingTypes.map((label) {
                      return ValueListenableBuilder<String?>(
                        valueListenable: selectedMeetingType,
                        builder:
                            (context, value, child) => CustomChoiceChip(
                              label: label,
                              selected: selectedMeetingType.value == label,
                              onSelected:
                                  () => selectedMeetingType.value = label,
                            ),
                      );
                    }),
                  ],
                ),
                PaddingConfig.h16,
                // حقل التاريخ
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
                        selectedDate = date;
                      });
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                    margin: EdgeInsets.only(bottom: 12),
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
                          selectedDate == null
                              ? "select the date"
                              : "${selectedDate!.year}-${selectedDate!.month}-${selectedDate!.day}",
                          style: AppTextStyle.bodySm(),
                        ),
                        Icon(Iconsax.calendar_1, color: AppColors.blueShade2),
                      ],
                    ),
                  ),
                ),

                // حقل الوقت
                GestureDetector(
                  onTap: () async {
                    final time = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                    );
                    if (time != null) {
                      setState(() {
                        selectedTime = time;
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
                          selectedTime == null
                              ? "select the time"
                              : "${selectedTime!.hour}:${selectedTime!.minute.toString().padLeft(2, '0')}",
                          style: AppTextStyle.bodySm(),
                        ),
                        Icon(Iconsax.clock, color: AppColors.blueShade2),
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
              if (selectedDate != null && selectedTime != null) {
                final dateTime = DateTime(
                  selectedDate!.year,
                  selectedDate!.month,
                  selectedDate!.day,
                  selectedTime!.hour,
                  selectedTime!.minute,
                );

                // إرسال للباك
                print("📌 الموعد النهائي: ${dateTime.toIso8601String()}");
                context.read<ProjectStatusTeamMeetingBloc>().add(
                  CreateMeetingEvent(
                    projectId: projectId.toString(),
                    meetingDate: HelperFunctions.formateDateForBack(dateTime),
                    meetingType: selectedMeetingType.value ?? "Review",
                  ),
                );

                Navigator.pop(context, dateTime);
              }
            },
          ),
        ],
      );
    },
  );
}
