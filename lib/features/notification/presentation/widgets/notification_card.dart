import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:two_dashboard/config/constants/padding_config.dart';
import 'package:two_dashboard/config/routes/app_route_config.dart';
import 'package:two_dashboard/config/theme/color.dart';
import 'package:two_dashboard/config/theme/text_style.dart';
import 'package:two_dashboard/core/helper/helper_functions.dart';
import 'package:two_dashboard/core/network/enums.dart';
import 'package:two_dashboard/features/auth/presentation/bloc/auth_role_profile_bloc.dart';
import 'package:two_dashboard/features/notification/data/models/notification_model.dart';

class NotificationCard extends StatelessWidget {
  const NotificationCard({super.key, required this.notificationModel});
  final NotificationModel notificationModel;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.pop();
        context.goNamed(AppRouteConfig.assignRequests);
      },
      child: Card(
        elevation: 0,
        color: AppColors.grayshade1,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.all(10.0),
                    margin: EdgeInsetsDirectional.only(start: 8.0),
                    decoration: BoxDecoration(
                      color: AppColors.blueShade1,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      ".P",
                      style: AppTextStyle.headerMd(color: AppColors.blueShade2),
                    ),
                  ),
                  PaddingConfig.w16,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      PaddingConfig.h8,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "New Assign Request",
                                style: AppTextStyle.bodyLg(),
                              ),
                              PaddingConfig.h4,
                              Text(
                                HelperFunctions.getTimeAgo(
                                  notificationModel.project.updatedAt,
                                ),
                                style: AppTextStyle.bodySm(
                                  color: AppColors.fontLightGray,
                                ),
                              ),
                            ],
                          ),
                          PaddingConfig.w72,
                          Text(
                            HelperFunctions.formatDate(
                              notificationModel.project.updatedAt,
                            ),
                            style: AppTextStyle.bodySm(
                              color: AppColors.fontLightGray,
                            ),
                          ),
                        ],
                      ),
                      PaddingConfig.h8,
                      if (notificationModel.message.trim().isNotEmpty)
                        SizedBox(
                          width: 270,
                          child: Text(
                            notificationModel.message,
                            overflow: TextOverflow.fade,
                            style: AppTextStyle.bodySm(),
                          ),
                        ),
                      PaddingConfig.h8,
                    ],
                  ),
                ],
              ),
              PaddingConfig.h16,
              Divider(color: AppColors.grayShade2, thickness: 0.7),
              BlocListener<AuthRoleProfileBloc, AuthRoleProfileState>(
                listenWhen:
                    (previous, current) =>
                        previous.markNotificationAsReadStatus !=
                        current.markNotificationAsReadStatus,
                listener: (context, state) {
                  if (state.markNotificationAsReadStatus ==
                      CasualStatus.success) {
                    context.read<AuthRoleProfileBloc>().add(
                      ShowUnReadNotificationListEvent(),
                    );
                  }
                },
                child: GestureDetector(
                  onTap:
                      () => context.read<AuthRoleProfileBloc>().add(
                        MarkNotificationAsReadEvent(id: notificationModel.id),
                      ),
                  child: Row(
                    children: [
                      PaddingConfig.w16,
                      Icon(Iconsax.eye),
                      PaddingConfig.w8,
                      Text("Mark as read", style: AppTextStyle.bodySm()),
                    ],
                  ),
                ),
              ),
              PaddingConfig.h8,
            ],
          ),
        ),
      ),
    );
  }
}
