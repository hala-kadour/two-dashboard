import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:two_dashboard/config/constants/padding_config.dart';
import 'package:two_dashboard/config/constants/sizes_config.dart';
import 'package:two_dashboard/config/theme/color.dart';
import 'package:two_dashboard/core/functions/bloc-state-handling/profile_bloc_state_handling.dart';
import 'package:two_dashboard/core/functions/device_utility.dart';
import 'package:two_dashboard/core/network/enums.dart';
import 'package:two_dashboard/core/widgets/buttons/icon-buttons/filter_button.dart';
import 'package:two_dashboard/core/widgets/container/custom_rounder_container.dart';
import 'package:two_dashboard/core/widgets/dialog/filter/filter_employee.dart';
import 'package:two_dashboard/core/widgets/texts/page_title.dart';
import 'package:two_dashboard/features/auth/presentation/bloc/auth_role_profile_bloc.dart';
import 'package:two_dashboard/features/roles/data/models/role_response_model.dart';

class AccountsPage extends StatefulWidget {
  const AccountsPage({super.key});

  @override
  State<AccountsPage> createState() => _AccountsPageState();
}

class _AccountsPageState extends State<AccountsPage> {
  ValueNotifier<RoleModel> selectedRole = ValueNotifier(
    RoleModel(id: 2, role: "client"),
  );
  List<String> approveList = ["Approved", "Not Approved"];
  ValueNotifier<int> approved = ValueNotifier(0);
  // Filter For Role
  Widget _buildRoleFilterList(List<RoleModel> roles) {
    return SizedBox(
      height: 200,
      child: SingleChildScrollView(
        child: Column(
          children:
              roles.map((role) {
                return ValueListenableBuilder<RoleModel>(
                  valueListenable: selectedRole,
                  builder: (_, selected, __) {
                    return RadioListTile<RoleModel>(
                      value: role,
                      groupValue: selected,
                      onChanged: (val) {
                        if (val != null) {
                          selectedRole.value = val;
                          context.read<AuthRoleProfileBloc>().add(
                            ShowUsersWithFilterEvent(
                              approvedFilter: approved.value,
                              roleFilter: val.id,
                            ),
                          );
                        }
                      },
                      title: Text(role.role),
                      activeColor: AppColors.blueShade2,
                      controlAffinity: ListTileControlAffinity.leading,
                      dense: true,
                    );
                  },
                );
              }).toList(),
        ),
      ),
    );
  }

  // Filter For Approvment
  Widget _buildApprovedFilterList(List<String> list) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children:
          list.map((item) {
            return ValueListenableBuilder<int>(
              valueListenable: approved,
              builder: (_, selected, __) {
                final value = item == "Approved" ? 1 : 0;
                return RadioListTile<int>(
                  value: value,
                  groupValue: selected,
                  onChanged: (val) {
                    if (val != null) {
                      approved.value = val;
                      context.read<AuthRoleProfileBloc>().add(
                        ShowUsersWithFilterEvent(
                          approvedFilter: val,
                          roleFilter: selectedRole.value.id,
                        ),
                      );
                    }
                  },
                  title: Text(item),
                  activeColor: AppColors.blueShade2,
                  controlAffinity: ListTileControlAffinity.leading,
                  dense: true,
                );
              },
            );
          }).toList(),
    );
  }

  @override
  void didChangeDependencies() {
    context.read<AuthRoleProfileBloc>().add(
      ShowUsersWithFilterEvent(roleFilter: 4),
    );
    context.read<AuthRoleProfileBloc>().add(GetAllRolesEvent());
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(SizesConfig.lg),
        child: BlocListener<AuthRoleProfileBloc, AuthRoleProfileState>(
          listener: (context, state) {
            ProfileBlocStateHandling().toggleApproveUser(state, context);
          },
          listenWhen:
              (previous, current) =>
                  (previous.toggleApproveStatus != current.toggleApproveStatus),
          child: Column(
            children: [
              const PageTitle(pageTitle: "Accounts"),
              const SizedBox(height: SizesConfig.spaceBtwSections),
              if (!DeviceUtility.isDesktopScreen(context))
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    PaddingConfig.w8,
                    FilterButton(
                      onPressed: () {
                        FilterEmployee().filterUsers(
                          context,
                          ValueNotifier(true),
                          ValueNotifier(2),
                        );
                      },
                    ),
                  ],
                ),
              const SizedBox(height: SizesConfig.spaceBtwSections),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  PaddingConfig.w8,
                  Expanded(
                    flex: 5,
                    child:
                        BlocBuilder<AuthRoleProfileBloc, AuthRoleProfileState>(
                          buildWhen:
                              (previous, current) =>
                                  (previous.userListStatus !=
                                      current.userListStatus),
                          builder: (context, state) {
                            return ProfileBlocStateHandling().getUsersTable(
                              state,
                            );
                          },
                        ),
                  ),
                  PaddingConfig.w16,
                  if (DeviceUtility.isDesktopScreen(context))
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomRounderContainer(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Row(
                                  children: [
                                    Icon(Iconsax.filter),
                                    PaddingConfig.w8,
                                    Text("Approvment:"),
                                  ],
                                ),
                                PaddingConfig.h16,
                                _buildApprovedFilterList(approveList),
                              ],
                            ),
                          ),
                          PaddingConfig.h16,
                          CustomRounderContainer(
                            height: 300,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Row(
                                  children: [
                                    Icon(Iconsax.filter),
                                    PaddingConfig.w8,
                                    Text("Role:"),
                                  ],
                                ),
                                PaddingConfig.h16,
                                BlocBuilder<
                                  AuthRoleProfileBloc,
                                  AuthRoleProfileState
                                >(
                                  buildWhen:
                                      (previous, current) =>
                                          previous.allRolesListStatus !=
                                          current.allRolesListStatus,
                                  builder: (context, state) {
                                    if (state.allRolesListStatus ==
                                        CasualStatus.loading) {
                                      return Center(
                                        child: const CircularProgressIndicator(
                                          color: AppColors.blueShade2,
                                        ),
                                      );
                                    } else if (state.allRolesListStatus ==
                                        CasualStatus.success) {
                                      final defaultRole = state.allRolesList
                                          .firstWhere(
                                            (r) => r.id == 2,
                                            orElse:
                                                () => state.allRolesList.first,
                                          );
                                      selectedRole.value = defaultRole;
                                      return _buildRoleFilterList(
                                        state.allRolesList,
                                      );
                                    } else {
                                      return const Text("No Roles available");
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
