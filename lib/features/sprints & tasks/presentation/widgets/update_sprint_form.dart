import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:two_dashboard/core/functions/bloc-state-handling/sprint_bloc_state_handling.dart';
import 'package:two_dashboard/features/sprints%20&%20tasks/domain/entity/sprint_entity.dart';
import 'package:two_dashboard/config/constants/padding_config.dart';
import 'package:two_dashboard/config/strings/text_strings.dart';
import 'package:two_dashboard/config/theme/color.dart';
import 'package:two_dashboard/config/theme/text_style.dart';
import 'package:two_dashboard/core/functions/device_utility.dart';
import 'package:two_dashboard/core/helper/helper_functions.dart';
import 'package:two_dashboard/core/widgets/buttons/elevated-buttons/save_elevated_button.dart';
import 'package:two_dashboard/core/widgets/buttons/text-buttons/cancel_text_button.dart';
import 'package:two_dashboard/core/widgets/container/custom_rounder_container.dart';
import 'package:two_dashboard/features/auth/presentation/widgets/custom_text_form_field.dart';
import 'package:two_dashboard/features/projects%20&%20team%20&%20status%20&%20meeting/presentation/widgets/date_field.dart';
import 'package:two_dashboard/features/sprints%20&%20tasks/presentation/bloc/sprint_and_task_bloc.dart';

class UpdateSprintForm extends StatefulWidget {
  const UpdateSprintForm({super.key, required this.sprintEntity});
  final SprintEntity sprintEntity;

  @override
  State<UpdateSprintForm> createState() => _UpdateSprintFormState();
}

class _UpdateSprintFormState extends State<UpdateSprintForm> {
  late final GlobalKey<FormState> _formKey;
  late final TextEditingController _lableController;
  late final TextEditingController _descriptionController;
  late final TextEditingController _goalController;
  DateTime? _startDate;
  DateTime? _endDate;

  Future<void> _pickDateTime({required bool isStart}) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate:
          isStart
              ? (_startDate ?? DateTime.now())
              : (_endDate ?? DateTime.now()),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate == null) return;

    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(
        isStart ? (_startDate ?? DateTime.now()) : (_endDate ?? DateTime.now()),
      ),
    );

    if (pickedTime == null) return;

    final DateTime combined = DateTime(
      pickedDate.year,
      pickedDate.month,
      pickedDate.day,
      pickedTime.hour,
      pickedTime.minute,
    );

    setState(() {
      if (isStart) {
        _startDate = combined;
      } else {
        _endDate = combined;
      }
    });
  }

  @override
  void initState() {
    _formKey = GlobalKey<FormState>();
    _lableController = TextEditingController(text: widget.sprintEntity.label);
    _descriptionController = TextEditingController(
      text: widget.sprintEntity.description,
    );
    _goalController = TextEditingController(text: widget.sprintEntity.goal);
    _startDate = widget.sprintEntity.start;
    _endDate = widget.sprintEntity.end;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.spaceBetween,
      runSpacing: 16,
      spacing: 12,
      children: [
        CustomRounderContainer(
          width:
              DeviceUtility.isDesktopScreen(context)
                  ? MediaQuery.of(context).size.width / 2.5 - 32
                  : double.infinity,
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Basic Information", style: AppTextStyle.bodySm()),
                PaddingConfig.h16,
                CustomTextFormField(
                  labelText: "Sprint lable",
                  controller: _lableController,
                  validator: (p0) {
                    if (p0 != null) {
                      return null;
                    } else {
                      return TextStrings.fieldValidation;
                    }
                  },
                ),
                PaddingConfig.h16,
                CustomTextFormField(
                  labelText: "Sprint description",
                  maxLines: 6,
                  controller: _descriptionController,
                  validator: (p0) {
                    if (p0 != null) {
                      return null;
                    } else {
                      return TextStrings.fieldValidation;
                    }
                  },
                ),
                PaddingConfig.h16,
              ],
            ),
          ),
        ),
        SizedBox(
          width:
              DeviceUtility.isDesktopScreen(context)
                  ? MediaQuery.of(context).size.width / 2.5 - 32
                  : double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomRounderContainer(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTextFormField(
                      labelText: "Sprint Goal",
                      maxLines: 6,
                      controller: _goalController,
                      validator: (p0) {
                        if (p0 != null) {
                          return null;
                        } else {
                          return TextStrings.fieldValidation;
                        }
                      },
                    ),
                    PaddingConfig.h16,
                    Row(
                      children: [
                        Expanded(
                          child: DateField(
                            label: 'Start Date & Time',
                            date: _startDate,
                            onTap: () => _pickDateTime(isStart: true),
                          ),
                        ),
                        PaddingConfig.w16,
                        Expanded(
                          child: DateField(
                            label: 'End Date & Time',
                            date: _endDate,
                            onTap: () => _pickDateTime(isStart: false),
                          ),
                        ),
                      ],
                    ),
                    PaddingConfig.h16,
                    if (_startDate != null && _endDate != null)
                      Text("Sprint Duration", style: AppTextStyle.bodySm()),
                    if (_startDate != null && _endDate != null)
                      PaddingConfig.h8,
                    if (_startDate != null && _endDate != null)
                      Text(
                        HelperFunctions.getDurationText(_startDate!, _endDate!),
                        style: AppTextStyle.bodyXs(
                          color: AppColors.fontLightGray,
                        ),
                      ),
                  ],
                ),
              ),
              PaddingConfig.h24,
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CancelTextButton(),
                  PaddingConfig.w24,
                  BlocListener<SprintAndTaskBloc, SprintAndTaskState>(
                    listenWhen:
                        (previous, current) =>
                            previous.updateSprintStatus !=
                            current.updateSprintStatus,
                    listener: (context, state) {
                      SprintBlocStateHandling().updateSprintListener(
                        state,
                        context,
                        widget.sprintEntity.projectId,
                      );
                    },
                    child: SaveElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate() &&
                            _startDate != null &&
                            _endDate != null) {
                          context.read<SprintAndTaskBloc>().add(
                            UpdateSprintEvent(
                              sprintId: widget.sprintEntity.id,
                              lable: _lableController.text,
                              description: _descriptionController.text,
                              goal: _goalController.text,
                              start: HelperFunctions.formateDateForBack(
                                _startDate!,
                              ),
                              end: HelperFunctions.formateDateForBack(
                                _endDate!,
                              ),
                              projectId: widget.sprintEntity.projectId,
                              status: widget.sprintEntity.sprintStatus,
                            ),
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
              PaddingConfig.h16,
            ],
          ),
        ),
      ],
    );
  }
}
