import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:iconsax/iconsax.dart';
import 'package:two_dashboard/config/constants/padding_config.dart';
import 'package:two_dashboard/config/constants/sizes_config.dart';
import 'package:two_dashboard/config/strings/assets_path.dart';
import 'package:two_dashboard/config/strings/text_strings.dart';
import 'package:two_dashboard/core/functions/bloc-state-handling/auth_bloc_state_handling.dart';
import 'package:two_dashboard/core/widgets/dialog/auth/logout_dialog.dart';
import 'package:two_dashboard/core/widgets/layouts/sidebar/logout_widget.dart';
import 'package:two_dashboard/core/widgets/layouts/sidebar/menu_item.dart';
import 'package:two_dashboard/core/widgets/layouts/sidebar/side_bar_title.dart';
import 'package:two_dashboard/features/auth/presentation/bloc/auth_role_profile_bloc.dart';

class CustomSidebar extends StatefulWidget {
  const CustomSidebar({
    super.key,
    required this.currentPageIndex,
    required this.onItemSelected,
  });

  final int currentPageIndex;
  final Function(int) onItemSelected;

  @override
  State<CustomSidebar> createState() => _CustomSidebarState();
}

class _CustomSidebarState extends State<CustomSidebar> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      shape: const BeveledRectangleBorder(),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: SizesConfig.md),
              child: SvgPicture.asset(IconsPath.logo),
            ),
            PaddingConfig.h16,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: SizesConfig.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  // PROJECT
                  SideBarTitle(
                    title: TextStrings.projects,
                    icon: Iconsax.brush,
                  ),
                  PaddingConfig.h8,
                  MenuItem(
                    icon: IconsPath.sort,
                    itemName: TextStrings.viewAllProjects,
                    pageNum: 0,
                    currentPage: widget.currentPageIndex,
                    onTap: widget.onItemSelected,
                  ),
                  PaddingConfig.h8,
                  MenuItem(
                    icon: IconsPath.task,
                    itemName: TextStrings.myProjects,
                    pageNum: 1,
                    currentPage: widget.currentPageIndex,
                    onTap: widget.onItemSelected,
                  ),
                  PaddingConfig.h8,
                  MenuItem(
                    icon: IconsPath.paper,
                    itemName: TextStrings.assignRequests,
                    pageNum: 2,
                    currentPage: widget.currentPageIndex,
                    onTap: widget.onItemSelected,
                  ),
                  PaddingConfig.h8,
                  MenuItem(
                    icon: IconsPath.send,
                    itemName: TextStrings.projectRequests,
                    pageNum: 3,
                    currentPage: widget.currentPageIndex,
                    onTap: widget.onItemSelected,
                  ),
                  MenuItem(
                    icon: IconsPath.threeUsers,
                    itemName: TextStrings.teams,
                    pageNum: 4,
                    currentPage: widget.currentPageIndex,
                    onTap: widget.onItemSelected,
                  ),
                  PaddingConfig.h16,
                  // TASKS
                  SideBarTitle(title: TextStrings.tasks, icon: Iconsax.task),
                  MenuItem(
                    icon: IconsPath.sort,
                    itemName: TextStrings.viewMyTasks,
                    pageNum: 5,
                    currentPage: widget.currentPageIndex,
                    onTap: widget.onItemSelected,
                  ),
                  PaddingConfig.h8,
                  MenuItem(
                    icon: IconsPath.calender,
                    itemName: TextStrings.calendar,
                    pageNum: 6,
                    currentPage: widget.currentPageIndex,
                    onTap: widget.onItemSelected,
                  ),
                  PaddingConfig.h16,
                  // COMPANY
                  SideBarTitle(title: TextStrings.company, icon: Iconsax.house),
                  PaddingConfig.h8,
                  MenuItem(
                    icon: IconsPath.twoUsers,
                    itemName: TextStrings.account,
                    pageNum: 7,
                    currentPage: widget.currentPageIndex,
                    onTap: widget.onItemSelected,
                  ),
                  MenuItem(
                    icon: IconsPath.paper,
                    itemName: TextStrings.contracts,
                    pageNum: 8,
                    currentPage: widget.currentPageIndex,
                    onTap: widget.onItemSelected,
                  ),
                  MenuItem(
                    icon: IconsPath.editSquare,
                    itemName: TextStrings.aboutUsWhyUs,
                    pageNum: 9,
                    currentPage: widget.currentPageIndex,
                    onTap: widget.onItemSelected,
                  ),
                  MenuItem(
                    icon: IconsPath.bag,
                    itemName: TextStrings.services,
                    pageNum: 10,
                    currentPage: widget.currentPageIndex,
                    onTap: widget.onItemSelected,
                  ),
                  MenuItem(
                    icon: IconsPath.send,
                    itemName: TextStrings.posts,
                    pageNum: 11,
                    currentPage: widget.currentPageIndex,
                    onTap: widget.onItemSelected,
                  ),
                  PaddingConfig.h16,
                  // FOR YOU
                  SideBarTitle(
                    title: TextStrings.forYou,
                    icon: Iconsax.profile_circle,
                  ),
                  PaddingConfig.h8,
                  MenuItem(
                    icon: IconsPath.profile2,
                    itemName: TextStrings.profile,
                    pageNum: 12,
                    currentPage: widget.currentPageIndex,
                    onTap: widget.onItemSelected,
                  ),
                  BlocListener<AuthRoleProfileBloc, AuthRoleProfileState>(
                    listener: (context, state) {
                      AuthBlocStateHandling().logoutStateHandling(
                        state,
                        context,
                      );
                    },
                    listenWhen:
                        (previous, current) =>
                            previous.logoutStatusStatus !=
                            current.logoutStatusStatus,
                    child: GestureDetector(
                      onTap: () => showLogoutDialog(context),
                      child: const LogoutWidget(),
                    ),
                  ),
                  PaddingConfig.h16,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
