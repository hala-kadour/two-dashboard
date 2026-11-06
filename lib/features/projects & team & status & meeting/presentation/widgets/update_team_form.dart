import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:two_dashboard/config/constants/padding_config.dart';
import 'package:two_dashboard/config/constants/sizes_config.dart';
import 'package:two_dashboard/config/theme/color.dart';
import 'package:two_dashboard/config/theme/text_style.dart';
import 'package:two_dashboard/core/functions/bloc-state-handling/profile_bloc_state_handling.dart';
import 'package:two_dashboard/core/widgets/buttons/elevated-buttons/save_elevated_button.dart';
import 'package:two_dashboard/core/widgets/buttons/icon-buttons/filter_button.dart';
import 'package:two_dashboard/core/widgets/container/custom_rounder_container.dart';
import 'package:two_dashboard/core/widgets/dialog/filter/filter_employee.dart';
import 'package:two_dashboard/features/auth/presentation/bloc/auth_role_profile_bloc.dart';
import 'package:two_dashboard/features/profile/domain/entities/employee_entity.dart';
import 'package:two_dashboard/features/projects%20&%20team%20&%20status%20&%20meeting/data/models/project/team.dart';
import 'package:two_dashboard/features/projects%20&%20team%20&%20status%20&%20meeting/presentation/bloc/project_status_team_meeting_bloc.dart';

class EditTeamForm extends StatefulWidget {
  final Team team;

  const EditTeamForm({super.key, required this.team});

  @override
  State<EditTeamForm> createState() => _EditTeamFormState();
}

class _EditTeamFormState extends State<EditTeamForm> {
  List<EmployeeEntity> selectedEmployees = [];
  EmployeeEntity? selectedManager;

  @override
  void initState() {
    super.initState();
    // القيم الابتدائية من الفريق الحالي
    selectedEmployees =
        widget.team.members
            .map(
              (m) => EmployeeEntity(
                id: m.id,
                name: m.name,
                role: m.role,
                approved: 1,
                email: m.email,
              ),
            )
            .toList();
    final manager = widget.team.members.firstWhere(
      (element) => element.isManager == true,
    );
    selectedManager = EmployeeEntity(
      id: manager.id,
      name: manager.name,
      email: manager.email,
      role: manager.role,
      approved: 1,
    );
  }

  @override
  void didChangeDependencies() {
    // تحميل المستخدمين و الوظائف
    context.read<AuthRoleProfileBloc>().add(
      ShowUsersWithFilterEvent(approvedFilter: 1, roleFilter: 4),
    );
    context.read<AuthRoleProfileBloc>().add(GetRolesWithoutClientEvent());
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // زر الحفظ
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SaveElevatedButton(
              onPressed: () {
                if (selectedEmployees.isNotEmpty && selectedManager != null) {
                  List<int> membersIdList =
                      selectedEmployees.map((e) => e.id).toList();
                  membersIdList.add(selectedManager!.id);
                  context.read<ProjectStatusTeamMeetingBloc>().add(
                    AddMembersEvent(
                      teamId: widget.team.id,
                      memebersIdList: membersIdList,
                    ),
                  );
                }
              },
            ),
          ],
        ),
        PaddingConfig.h24,

        // الفورم
        CustomRounderContainer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                Text("Team Members", style: AppTextStyle.bodySm()),
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

              // Choose Members
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
              const SizedBox(height: SizesConfig.spaceBtwSections),

              // Employee List
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
