import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:two_dashboard/config/constants/padding_config.dart';
import 'package:two_dashboard/config/strings/text_strings.dart';
import 'package:two_dashboard/config/theme/color.dart';
import 'package:two_dashboard/config/theme/text_style.dart';
import 'package:two_dashboard/core/functions/bloc-state-handling/sprint_bloc_state_handling.dart';
import 'package:two_dashboard/core/functions/device_utility.dart';
import 'package:two_dashboard/core/helper/helper_functions.dart';
import 'package:two_dashboard/core/widgets/buttons/elevated-buttons/save_elevated_button.dart';
import 'package:two_dashboard/core/widgets/buttons/text-buttons/cancel_text_button.dart';
import 'package:two_dashboard/core/widgets/container/custom_rounder_container.dart';
import 'package:two_dashboard/features/auth/presentation/widgets/custom_text_form_field.dart';
import 'package:two_dashboard/features/projects%20&%20team%20&%20status%20&%20meeting/presentation/widgets/date_field.dart';
import 'package:two_dashboard/features/sprints%20&%20tasks/presentation/bloc/sprint_and_task_bloc.dart';

class CreateSprintForm extends StatefulWidget {
  const CreateSprintForm({super.key, required this.projectId});
  final int projectId;

  @override
  State<CreateSprintForm> createState() => _CreateSprintFormState();
}

class _CreateSprintFormState extends State<CreateSprintForm> {
  late final GlobalKey<FormState> _formKey;
  late final TextEditingController _lableController;
  late final TextEditingController _descriptionController;
  late final TextEditingController _goalController;
  DateTime? _startDate;
  DateTime? _endDate;

  Future<void> _pickDate({required bool isStart}) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate:
          isStart
              ? (_startDate ?? DateTime.now())
              : (_endDate ?? DateTime.now()),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() {
        if (isStart) {
          _startDate = picked;
        } else {
          _endDate = picked;
        }
      });
    }
  }

  @override
  void initState() {
    _formKey = GlobalKey<FormState>();
    _lableController = TextEditingController();
    _descriptionController = TextEditingController();
    _goalController = TextEditingController();
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
                            label: 'Start Date',
                            date: _startDate,
                            onTap: () => _pickDate(isStart: true),
                          ),
                        ),
                        PaddingConfig.w16,
                        Expanded(
                          child: DateField(
                            label: 'End Date',
                            date: _endDate,
                            onTap: () => _pickDate(isStart: false),
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
                    listener: (context, state) {
                      SprintBlocStateHandling().createSprintListener(
                        state,
                        context,
                        widget.projectId,
                      );
                    },
                    listenWhen:
                        (previous, current) =>
                            previous.createSprintStatus !=
                            current.createSprintStatus,
                    child: SaveElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate() &&
                            _startDate != null &&
                            _endDate != null) {
                          context.read<SprintAndTaskBloc>().add(
                            CreateSprintEvent(
                              lable: _lableController.text,
                              description: _descriptionController.text,
                              goal: _goalController.text,
                              start: HelperFunctions.formateDateForBack(
                                _startDate!,
                              ),
                              end: HelperFunctions.formateDateForBack(
                                _endDate!,
                              ),
                              projectId: widget.projectId,
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
