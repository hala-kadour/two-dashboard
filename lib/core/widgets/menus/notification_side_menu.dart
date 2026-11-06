import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:two_dashboard/config/constants/padding_config.dart';
import 'package:two_dashboard/config/constants/sizes_config.dart';
import 'package:two_dashboard/config/theme/text_style.dart';
import 'package:two_dashboard/core/functions/bloc-state-handling/notification_bloc_state_handing.dart';
import 'package:two_dashboard/core/widgets/divider/custom_divider.dart';
import 'package:two_dashboard/features/auth/presentation/bloc/auth_role_profile_bloc.dart';

void showNotificationsPanel(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (context) {
      return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
        child: Align(
          alignment: Alignment.topRight,
          child: FractionallySizedBox(
            widthFactor: 0.3,
            child: Material(
              color: Colors.white,
              clipBehavior: Clip.hardEdge,
              elevation: 8,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  PaddingConfig.h16,
                  // Header
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Unread Notification",
                          style: AppTextStyle.bodyLg(),
                        ),
                        IconButton(
                          icon: Icon(
                            Iconsax.close_circle,
                            size: SizesConfig.iconsMd,
                          ),
                          onPressed: () => context.pop(context),
                        ),
                      ],
                    ),
                  ),
                  CustomDivider(),
                  // Notification List
                  BlocBuilder<AuthRoleProfileBloc, AuthRoleProfileState>(
                    buildWhen:
                        (previous, current) =>
                            previous.unReadNotificationListStatus !=
                            current.unReadNotificationListStatus,
                    builder:
                        (context, state) =>
                            NotificationBlocStateHanding.getUnReadNotificationList(
                              state,
                            ),
                  ),
                  PaddingConfig.h16,
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}
