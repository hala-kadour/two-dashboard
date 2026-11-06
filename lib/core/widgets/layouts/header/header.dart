import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:two_dashboard/config/constants/padding_config.dart';
import 'package:two_dashboard/config/constants/sizes_config.dart';
import 'package:two_dashboard/config/theme/color.dart';
import 'package:two_dashboard/config/theme/text_style.dart';
import 'package:two_dashboard/core/functions/bloc-state-handling/profile_bloc_state_handling.dart';
import 'package:two_dashboard/core/functions/device_utility.dart';
import 'package:two_dashboard/core/widgets/layouts/header/notification_icon.dart';
import 'package:two_dashboard/features/auth/presentation/bloc/auth_role_profile_bloc.dart';

class CustomHeader extends StatelessWidget implements PreferredSizeWidget {
  const CustomHeader({super.key, this.scaffoldKey});
  final GlobalKey<ScaffoldState>? scaffoldKey;

  @override
  Widget build(BuildContext context) {
    final GlobalKey iconKey = GlobalKey();
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        border: Border(bottom: BorderSide(color: AppColors.gray, width: 1)),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: SizesConfig.md,
        vertical: SizesConfig.sm,
      ),
      child: AppBar(
        scrolledUnderElevation: 0.0,
        // Mobile Menu
        leading:
            !DeviceUtility.isDesktopScreen(context)
                ? IconButton(
                  onPressed: () {
                    scaffoldKey?.currentState!.openDrawer();
                  },
                  icon: const Icon(Iconsax.menu),
                )
                : null,
        // Search Field
        title:
            DeviceUtility.isDesktopScreen(context)
                ? SizedBox(
                  width: 400,
                  child: TextField(
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                          SizesConfig.inputFieldRadius,
                        ),
                        borderSide: const BorderSide(
                          color: AppColors.gray,
                          width: 1,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                          SizesConfig.inputFieldRadius,
                        ),
                        borderSide: const BorderSide(
                          color: AppColors.gray,
                          width: 1,
                        ),
                      ),
                      prefixIcon: const Icon(Iconsax.search_normal),
                      hintText: 'Search anything...',
                      hintStyle: AppTextStyle.textfieldStyle(
                        color: AppColors.fontLightGray,
                      ),
                    ),
                  ),
                )
                : null,
        // Actions
        actions: [
          // Search Icon on Mobile
          if (!DeviceUtility.isDesktopScreen(context))
            IconButton(
              onPressed: () {},
              icon: const Icon(Iconsax.search_normal),
            ),
          // Notification Icon
          NotificationsIcon(iconKey: iconKey),
          PaddingConfig.h8,
          // User Data
          BlocBuilder<AuthRoleProfileBloc, AuthRoleProfileState>(
            builder: (context, state) {
              return ProfileBlocStateHandling().getUserProfileHeader(
                state,
                context,
              );
            },
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}
