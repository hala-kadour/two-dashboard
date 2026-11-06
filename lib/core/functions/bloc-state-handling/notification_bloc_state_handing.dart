import 'package:flutter/material.dart';
import 'package:two_dashboard/core/network/enums.dart';
import 'package:two_dashboard/core/widgets/animation/empty_status_animation.dart';
import 'package:two_dashboard/core/widgets/animation/error_status_animation.dart';
import 'package:two_dashboard/core/widgets/shimmers/card-loading/loading_notification_card.dart';
import 'package:two_dashboard/features/auth/presentation/bloc/auth_role_profile_bloc.dart';
import 'package:two_dashboard/features/notification/presentation/widgets/notification_card.dart';

class NotificationBlocStateHanding {
  static Widget getUnReadNotificationList(AuthRoleProfileState state) {
    if (state.unReadNotificationListStatus == CasualStatus.loading) {
      return Expanded(
        child: ListView.builder(
          itemCount: 5,
          itemBuilder: (context, index) {
            return LoadingNotificationCard();
          },
        ),
      );
    } else if (state.unReadNotificationListStatus == CasualStatus.success) {
      final notifications = state.unReadNotificationList;
      if (notifications.isEmpty) {
        return Center(child: EmptyStatusAnimation());
      } else {
        return Expanded(
          child: ListView.builder(
            itemCount: notifications.length,
            itemBuilder: (context, index) {
              final notif = notifications[index];
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: NotificationCard(notificationModel: notif),
              );
            },
          ),
        );
      }
    } else if (state.unReadNotificationListStatus == CasualStatus.failure) {
      return Center(child: ErrorStatusAnimation(errorMessage: state.message));
    } else {
      return const SizedBox();
    }
  }
}
