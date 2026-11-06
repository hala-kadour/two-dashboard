import 'package:flutter/material.dart';
import 'package:two_dashboard/core/widgets/layouts/templates/custom_site_template.dart';
import 'package:two_dashboard/features/auth/presentation/pages/login/responsive-pages/login_desktop_tablet.dart';
import 'package:two_dashboard/features/auth/presentation/pages/login/responsive-pages/login_mobile.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomSiteTemplate(
      currentPageIndex: 0,
      onItemSelected: (p0) {},
      useLayout: false,
      desktop: const LoginDesktopTablet(),
      tablet: const LoginDesktopTablet(),
      mobile: const LoginMobile(),
    );
  }
}
