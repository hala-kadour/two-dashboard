import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:two_dashboard/config/theme/color.dart';
import 'package:two_dashboard/core/widgets/menus/notification_side_menu.dart';
import 'package:two_dashboard/features/auth/presentation/bloc/auth_role_profile_bloc.dart';

class NotificationsIcon extends StatelessWidget {
  final GlobalKey iconKey;

  const NotificationsIcon({super.key, required this.iconKey});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<AuthRoleProfileBloc, AuthRoleProfileState, int>(
      selector: (state) {
        return state.unReadNotificationList.length;
      },
      builder: (context, unreadCount) {
        return Stack(
          children: [
            IconButton(
              onPressed: () => showNotificationsPanel(context),
              icon: const Icon(Iconsax.notification),
            ),
            if (unreadCount > 0)
              Positioned(
                right: 4,
                top: 4,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: AppColors.redShade3,
                    shape: BoxShape.circle,
                  ),
                  constraints: const BoxConstraints(minHeight: 18),
                  child: Text(
                    unreadCount > 9 ? '+9' : unreadCount.toString(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
