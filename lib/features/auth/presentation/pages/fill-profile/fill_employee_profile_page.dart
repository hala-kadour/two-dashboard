// ignore_for_file: deprecated_member_use, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:two_dashboard/core/functions/bloc-state-handling/auth_bloc_state_handling.dart';
import 'package:two_dashboard/core/widgets/layouts/templates/custom_site_template.dart';
import 'package:two_dashboard/features/auth/presentation/bloc/auth_role_profile_bloc.dart';
import 'package:two_dashboard/features/auth/presentation/pages/fill-profile/responsive-pages/fill_employee_profile.dart';
import 'package:two_dashboard/features/auth/presentation/pages/fill-profile/responsive-pages/fill_employee_profile_desktop_tablet.dart';

class FillEmployeeProfilePage extends StatefulWidget {
  const FillEmployeeProfilePage({super.key});

  @override
  State<FillEmployeeProfilePage> createState() => _FillProfilePageState();
}

class _FillProfilePageState extends State<FillEmployeeProfilePage> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthRoleProfileBloc, AuthRoleProfileState>(
      listener: (context, state) {
        AuthBlocStateHandling().fillEmployeeProfile(state, context);
      },
      listenWhen: (previous, current) {
        return (previous.updateEmployeeProfileStatus !=
            current.updateEmployeeProfileStatus);
      },
      child: CustomSiteTemplate(
        currentPageIndex: 0,
        onItemSelected: (p0) {},
        useLayout: false,
        desktop: const FillEmployeeProfileDesktopTablet(),
        tablet: const FillEmployeeProfileDesktopTablet(),
        mobile: const FillEmployeeProfileMobile(),
      ),
    );
  }
}
