import 'package:flutter/material.dart';
import 'package:two_dashboard/core/widgets/layouts/templates/login_template.dart';
import 'package:two_dashboard/features/auth/presentation/widgets/fill-profile/fill_employee_profile_body.dart';

class FillEmployeeProfileDesktopTablet extends StatefulWidget {
  const FillEmployeeProfileDesktopTablet({super.key});

  @override
  State<FillEmployeeProfileDesktopTablet> createState() =>
      _FillEmployeeProfileDesktopTabletState();
}

class _FillEmployeeProfileDesktopTabletState
    extends State<FillEmployeeProfileDesktopTablet> {
  @override
  Widget build(BuildContext context) {
    return const LoginTemplate(
      child: Column(
        children: [
          // Body
          FillEmployeeProfileBody(),
        ],
      ),
    );
  }
}
