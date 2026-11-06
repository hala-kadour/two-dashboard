import 'package:flutter/material.dart';
import 'package:two_dashboard/config/constants/sizes_config.dart';
import 'package:two_dashboard/config/theme/color.dart';
import 'package:two_dashboard/config/theme/text_style.dart';
import 'package:two_dashboard/core/network/enums.dart';
import 'package:two_dashboard/core/widgets/dropdown-list/custom_dropdown_list_for_role_model.dart';
import 'package:two_dashboard/core/widgets/shimmers/dropdown-loading/custom_dropdown_loading.dart';
import 'package:two_dashboard/features/auth/presentation/bloc/auth_role_profile_bloc.dart';
import 'package:two_dashboard/features/roles/data/models/role_response_model.dart';

class RoleBlocStateHandling {
  // Roles for drop down list
  Widget getDropDowmRolesList({
    required AuthRoleProfileState state,
    required ValueNotifier<RoleModel?> selectedRole,
    required void Function(RoleModel?) onChanged,
  }) {
    if (state.roleListStatus == CasualStatus.success) {
      if (state.roleList.isNotEmpty) {
        return ValueListenableBuilder<RoleModel?>(
          valueListenable: selectedRole,
          builder: (context, roleValue, _) {
            return CustomDropdownListForRoleModel(
              value: roleValue,
              items:
                  state.roleList.map((role) {
                    return DropdownMenuItem(
                      value: role,
                      child: Text(role.role),
                    );
                  }).toList(),
              onChanged: onChanged,
            );
          },
        );
      } else {
        return const Text("No Roles");
      }
    } else if (state.roleListStatus == CasualStatus.loading) {
      return const CustomDropdownLoading();
    } else if (state.roleListStatus == CasualStatus.failure) {
      return Text(state.message);
    } else {
      return const SizedBox();
    }
  }

  // Roles For Filter
  Widget getRolesForUserFilter(
    AuthRoleProfileState state,
    ValueNotifier<int> roleSelected,
  ) {
    if (state.roleWithoutClientListStatus == CasualStatus.loading) {
      return CircularProgressIndicator();
    } else if (state.roleWithoutClientListStatus == CasualStatus.success) {
      return SizedBox(
        width: 450,
        height: 150,
        child: ListView(
          children: [
            Wrap(
              alignment: WrapAlignment.start,
              runSpacing: 5,
              spacing: 5,
              children: List.generate(state.roleWithoutClientList.length, (
                index,
              ) {
                return GestureDetector(
                  onTap: () {
                    roleSelected.value = state.roleWithoutClientList[index].id;
                  },
                  child: ValueListenableBuilder(
                    valueListenable: roleSelected,
                    builder:
                        (context, value, child) => Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 15,
                            vertical: 9,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(color: AppColors.blueShade1),
                            borderRadius: BorderRadius.circular(
                              SizesConfig.borderRadiusXs,
                            ),
                            color:
                                (state.roleWithoutClientList[index].id ==
                                        roleSelected.value)
                                    ? AppColors.blueShade1
                                    : Colors.transparent,
                          ),
                          child: Text(
                            state.roleWithoutClientList[index].role,
                            style: AppTextStyle.bodyXs(
                              color:
                                  (state.roleWithoutClientList[index].id ==
                                          roleSelected.value)
                                      ? AppColors.blueShade2
                                      : AppColors.blueShade1,
                            ),
                          ),
                        ),
                  ),
                );
              }),
            ),
          ],
        ),
      );
    } else if (state.roleWithoutClientListStatus == CasualStatus.failure) {
      return Text(state.message);
    } else {
      return SizedBox();
    }
  }
}
