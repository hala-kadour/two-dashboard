import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:two_dashboard/config/constants/padding_config.dart';
import 'package:two_dashboard/config/strings/text_strings.dart';
import 'package:two_dashboard/config/theme/color.dart';
import 'package:two_dashboard/config/theme/text_style.dart';
import 'package:two_dashboard/core/functions/bloc-state-handling/project_bloc_state_handling.dart';
import 'package:two_dashboard/core/functions/device_utility.dart';
import 'package:two_dashboard/core/network/enums.dart';
import 'package:two_dashboard/core/widgets/buttons/elevated-buttons/save_elevated_button.dart';
import 'package:two_dashboard/core/widgets/buttons/text-buttons/cancel_text_button.dart';
import 'package:two_dashboard/core/widgets/container/custom_rounder_container.dart';
import 'package:two_dashboard/core/widgets/dialog/global/forget_some_thing_dialog.dart';
import 'package:two_dashboard/features/auth/presentation/widgets/custom_text_form_field.dart';
import 'package:two_dashboard/features/projects%20&%20team%20&%20status%20&%20meeting/domain/entity/project_entity.dart';
import 'package:two_dashboard/features/projects%20&%20team%20&%20status%20&%20meeting/presentation/bloc/project_status_team_meeting_bloc.dart';

class UpdateProjectForm extends StatefulWidget {
  const UpdateProjectForm({super.key, required this.projectEntity});
  final ProjectEntity projectEntity;

  @override
  State<UpdateProjectForm> createState() => _UpdateProjectFormState();
}

class _UpdateProjectFormState extends State<UpdateProjectForm> {
  late final GlobalKey<FormState> _formKey;
  late final TextEditingController _descriptionController;
  late final TextEditingController _requiredmentController;
  ProjectType? projectType;
  CooperationType? cooperationType;
  ProjectVisibility? visibility;

  @override
  void initState() {
    _formKey = GlobalKey<FormState>();
    _descriptionController = TextEditingController(
      text: widget.projectEntity.projectDescription,
    );
    _requiredmentController = TextEditingController(
      text: widget.projectEntity.requirements,
    );
    projectType = widget.projectEntity.pType;
    cooperationType = widget.projectEntity.cType;
    visibility = widget.projectEntity.visibility;
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
                // Project Desription
                CustomTextFormField(
                  labelText: "Project description",
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
                // Project Requirdment
                CustomTextFormField(
                  labelText: "Project Requirdment",
                  maxLines: 6,
                  controller: _requiredmentController,
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
                    // Project Type
                    Text("Project Type", style: AppTextStyle.bodySm()),
                    PaddingConfig.h16,
                    CustomRounderContainer(
                      child: Wrap(
                        children: [
                          _buildRadioForProjectType(
                            ProjectType.mobile,
                            "Mobile Development",
                          ),
                          PaddingConfig.w24,
                          _buildRadioForProjectType(
                            ProjectType.website,
                            "Website Development",
                          ),
                          PaddingConfig.w24,
                          _buildRadioForProjectType(
                            ProjectType.maintain,
                            "Maintain",
                          ),
                          PaddingConfig.w24,
                          _buildRadioForProjectType(
                            ProjectType.softwareTesting,
                            "Software Testing",
                          ),
                          PaddingConfig.w24,
                          _buildRadioForProjectType(
                            ProjectType.systemAnalysis,
                            "System Analysis",
                          ),
                          PaddingConfig.w24,
                        ],
                      ),
                    ),
                    PaddingConfig.h24,
                    // Coopertion Type
                    Text("Coopertion Type", style: AppTextStyle.bodySm()),
                    PaddingConfig.h16,
                    CustomRounderContainer(
                      child: Wrap(
                        children: [
                          _buildRadioForCoopertion(
                            CooperationType.development,
                            "Development",
                          ),
                          PaddingConfig.w24,
                          _buildRadioForCoopertion(
                            CooperationType.test,
                            "Testing",
                          ),
                          PaddingConfig.w24,
                          _buildRadioForCoopertion(
                            CooperationType.analysis,
                            "Analysis",
                          ),
                          PaddingConfig.w24,
                          _buildRadioForCoopertion(
                            CooperationType.managment,
                            "Managment",
                          ),
                          PaddingConfig.w24,
                        ],
                      ),
                    ),
                    PaddingConfig.h24,
                    // Visibilty
                    Text("Visibilty", style: AppTextStyle.bodySm()),
                    PaddingConfig.h16,
                    CustomRounderContainer(
                      child: Row(
                        children: [
                          _buildRadioForVisibilty(
                            ProjectVisibility.private,
                            "Private",
                          ),
                          PaddingConfig.w24,
                          _buildRadioForVisibilty(
                            ProjectVisibility.public,
                            "Public",
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              PaddingConfig.h24,
            ],
          ),
        ),
        PaddingConfig.h24,
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            CancelTextButton(),
            PaddingConfig.w24,
            BlocListener<
              ProjectStatusTeamMeetingBloc,
              ProjectStatusTeamMeetingState
            >(
              listenWhen:
                  (previous, current) =>
                      previous.updateProjectStatus !=
                      current.updateProjectStatus,
              listener: (context, state) {
                ProjectBlocStateHandling().updateProject(state, context);
              },
              child: SaveElevatedButton(
                onPressed: () {
                  if (projectType == null) {
                    forgetSomeThingDialog(context, "The Project Type");
                  } else if (cooperationType == null) {
                    forgetSomeThingDialog(context, "The cooperation Type");
                  } else if (visibility == null) {
                    forgetSomeThingDialog(context, "The cooperation Type");
                  } else {
                    context.read<ProjectStatusTeamMeetingBloc>().add(
                      UpdateProjectEvent(
                        projectId: widget.projectEntity.id,
                        projectType: projectType!.name,
                        projectDescription: _descriptionController.text,
                        document: widget.projectEntity.document,
                        requirements: _requiredmentController.text,
                        cooperationType: cooperationType!.name,
                        contactTime: widget.projectEntity.contactTime,
                        visibility:
                            (visibility == ProjectVisibility.public) ? 0 : 1,
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
    );
  }

  /// build radio buttons list for project type chooses
  Widget _buildRadioForProjectType(ProjectType value, String label) {
    return Row(
      children: [
        RadioGroup<ProjectType>(
          groupValue: projectType,
          onChanged: (ProjectType? newValue) {
            setState(() {
              projectType = newValue;
            });
          },
          child: Radio<ProjectType>(
            value: value,
            activeColor: AppColors.blueShade2,
          ),
        ),
        Text(label, style: AppTextStyle.bodySm()),
      ],
    );
  }

  /// build radio buttons list for Coopertion Type chooses
  Widget _buildRadioForCoopertion(CooperationType value, String label) {
    return Row(
      children: [
        RadioGroup<CooperationType>(
          groupValue: cooperationType,
          onChanged: (CooperationType? newValue) {
            setState(() {
              cooperationType = newValue;
            });
          },
          child: Radio<CooperationType>(
            value: value,
            activeColor: AppColors.blueShade2,
          ),
        ),
        Text(label, style: AppTextStyle.bodySm()),
      ],
    );
  }

  /// build radio buttons list for visibilty chooses
  Widget _buildRadioForVisibilty(ProjectVisibility value, String label) {
    return Row(
      children: [
        RadioGroup<ProjectVisibility>(
          groupValue: visibility,
          onChanged: (ProjectVisibility? newValue) {
            setState(() {
              visibility = newValue;
            });
          },
          child: Radio<ProjectVisibility>(
            value: value,
            activeColor: AppColors.blueShade2,
          ),
        ),
        Text(label, style: AppTextStyle.bodySm()),
      ],
    );
  }
}
