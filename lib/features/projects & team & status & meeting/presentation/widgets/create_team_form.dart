import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:two_dashboard/config/constants/padding_config.dart';
import 'package:two_dashboard/config/constants/sizes_config.dart';
import 'package:two_dashboard/config/strings/text_strings.dart';
import 'package:two_dashboard/config/theme/color.dart';
import 'package:two_dashboard/config/theme/text_style.dart';
import 'package:two_dashboard/core/functions/bloc-state-handling/profile_bloc_state_handling.dart';
import 'package:two_dashboard/core/widgets/buttons/elevated-buttons/save_elevated_button.dart';
import 'package:two_dashboard/core/widgets/buttons/icon-buttons/filter_button.dart';
import 'package:two_dashboard/core/widgets/container/custom_rounder_container.dart';
import 'package:two_dashboard/core/widgets/dialog/filter/filter_employee.dart';
import 'package:two_dashboard/features/auth/presentation/bloc/auth_role_profile_bloc.dart';
import 'package:two_dashboard/features/auth/presentation/widgets/custom_text_form_field.dart';
import 'package:two_dashboard/features/profile/domain/entities/employee_entity.dart';
import 'package:two_dashboard/features/projects%20&%20team%20&%20status%20&%20meeting/presentation/bloc/project_status_team_meeting_bloc.dart';
import 'package:two_dashboard/features/roles/data/models/role_response_model.dart';

class CreateTeamForm extends StatefulWidget {
  const CreateTeamForm({super.key});

  @override
  State<CreateTeamForm> createState() => _CreateTeamFormState();
}

class _CreateTeamFormState extends State<CreateTeamForm>
    with TickerProviderStateMixin {
  TabController? _tabController;
  final TextEditingController _teamNameController = TextEditingController();
  List<RoleModel> jobList = [];
  List<EmployeeEntity> selectedEmployees = [];
  EmployeeEntity? selectedManager;

  @override
  void didChangeDependencies() {
    context.read<AuthRoleProfileBloc>().add(
      ShowUsersWithFilterEvent(approvedFilter: 1, roleFilter: 4),
    );
    context.read<AuthRoleProfileBloc>().add(GetRolesWithoutClientEvent());
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _tabController?.dispose();
    _teamNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SaveElevatedButton(
              onPressed: () {
                if (selectedEmployees.isNotEmpty && selectedManager != null) {
                  // From EmployeeEntity to Int
                  List<int> memebersIdList =
                      selectedEmployees.map((e) => e.id).toList();
                  context.read<ProjectStatusTeamMeetingBloc>().add(
                    CreateTeamEvent(
                      name: _teamNameController.text,
                      mgrId: selectedManager!.id,
                      memebersIdList: memebersIdList,
                    ),
                  );
                }
              },
            ),
          ],
        ),
        PaddingConfig.h24,
        CustomRounderContainer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Team Name
              Text("Team Name", style: AppTextStyle.bodySm()),
              PaddingConfig.h16,
              CustomTextFormField(
                labelText: "Team Name",
                controller: _teamNameController,
                validator: (value) {
                  if (value != null && value.isNotEmpty) {
                    return null;
                  } else {
                    return TextStrings.fieldValidation;
                  }
                },
              ),
              PaddingConfig.h16,
              // Team Manager
              if (selectedManager != null)
                Text("Team Manager", style: AppTextStyle.bodySm()),
              if (selectedManager != null) PaddingConfig.h8,
              if (selectedManager != null)
                Chip(
                  label: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(selectedManager!.name, style: AppTextStyle.bodySm()),
                      Text(
                        selectedManager!.role,
                        style: AppTextStyle.bodyXs(
                          color: AppColors.fontLightGray,
                        ),
                      ),
                    ],
                  ),
                  onDeleted: () {
                    setState(() {
                      selectedManager = null;
                    });
                  },
                ),
              PaddingConfig.h24,

              // Team Members
              if (selectedEmployees.isNotEmpty)
                Text("Team Memembers", style: AppTextStyle.bodySm()),
              if (selectedEmployees.isNotEmpty) PaddingConfig.h8,
              if (selectedEmployees.isNotEmpty)
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  child: Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children:
                        selectedEmployees.map((emp) {
                          return Chip(
                            label: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(emp.name, style: AppTextStyle.bodySm()),
                                Text(
                                  emp.role,
                                  style: AppTextStyle.bodyXs(
                                    color: AppColors.fontLightGray,
                                  ),
                                ),
                              ],
                            ),
                            onDeleted: () {
                              setState(() => selectedEmployees.remove(emp));
                            },
                          );
                        }).toList(),
                  ),
                ),
              PaddingConfig.h24,
              //Choose The Team Members
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Select Your Team Members",
                    style: AppTextStyle.bodySm(),
                  ),
                  FilterButton(
                    onPressed: () {
                      FilterEmployee().filterUsers(
                        context,
                        ValueNotifier(true),
                        ValueNotifier(4),
                      );
                    },
                  ),
                ],
              ),
              PaddingConfig.h16,
              //Employee List
              const SizedBox(height: SizesConfig.spaceBtwSections),
              SizedBox(
                height: 400,
                child: BlocBuilder<AuthRoleProfileBloc, AuthRoleProfileState>(
                  buildWhen:
                      (previous, current) =>
                          (previous.userListStatus != current.userListStatus),
                  builder: (context, state) {
                    return ProfileBlocStateHandling().getSelectUsersTable(
                      state,
                      (EmployeeEntity value) {
                        setState(() {
                          selectedManager = value;
                        });
                      },
                      (EmployeeEntity emp) {
                        setState(() {
                          // تحقق إذا الموظف موجود بالفعل أو لا
                          if (!selectedEmployees.contains(emp)) {
                            selectedEmployees.add(emp);
                          } else {
                            selectedEmployees.remove(emp);
                          }
                        });
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
