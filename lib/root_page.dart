import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:two_dashboard/core/widgets/layouts/templates/custom_site_template.dart';
import 'package:two_dashboard/features/auth/presentation/bloc/auth_role_profile_bloc.dart';

class RootPage extends StatefulWidget {
  const RootPage({super.key, required this.shell});
  final StatefulNavigationShell shell;

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  @override
  void didChangeDependencies() {
    context.read<AuthRoleProfileBloc>()
      ..add(GetUserHeaderEvent())
      ..add(ShowUnReadNotificationListEvent());
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomSiteTemplate(
        currentPageIndex: widget.shell.currentIndex,
        onItemSelected: (index) {
          widget.shell.goBranch(index);
        },
        desktop: Expanded(child: widget.shell),
      ),
    );
  }
}
