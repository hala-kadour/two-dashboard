import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:two_dashboard/config/constants/padding_config.dart';
import 'package:two_dashboard/config/routes/app_route_config.dart';
import 'package:two_dashboard/config/theme/color.dart';
import 'package:two_dashboard/config/theme/text_style.dart';
import 'package:two_dashboard/core/widgets/buttons/elevated-buttons/update_elevated_button.dart';
import 'package:two_dashboard/core/widgets/container/custom_rounder_container.dart';
import 'package:two_dashboard/core/widgets/images/fetch_network_image.dart';
import 'package:two_dashboard/features/projects%20&%20team%20&%20status%20&%20meeting/data/models/project/team.dart';

class TeamTabBarView extends StatelessWidget {
  const TeamTabBarView({
    super.key,
    required this.team,
    required this.projectId,
  });
  final Team? team;
  final int projectId;

  @override
  Widget build(BuildContext context) {
    final teamMgr = team?.members.firstWhere(
      (element) => element.isManager == true,
    );
    final membersList =
        team?.members.where((element) => element.isManager == false).toList() ??
        [];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              UpdateElevatedButton(
                updateType: "Members",
                onPressed:
                    () => context.pushNamed(
                      AppRouteConfig.updateTeam,
                      extra: team,
                    ),
              ),
            ],
          ),
          PaddingConfig.h32,
          CustomRounderContainer(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            "Team Name",
                            style: AppTextStyle.bodyMd(
                              color: AppColors.blueShade2,
                            ),
                          ),
                          PaddingConfig.w48,
                          Text(
                            team?.name ?? "NO Team Selected",
                            style: AppTextStyle.bodySm(
                              color: AppColors.fontDarkGray,
                            ),
                          ),
                        ],
                      ),
                      PaddingConfig.h32,
                      Row(
                        children: [
                          Text(
                            "Team Manager",
                            style: AppTextStyle.bodyMd(
                              color: AppColors.blueShade2,
                            ),
                          ),
                          PaddingConfig.w32,
                          Row(
                            children: [
                              FetchNetworkImage(
                                width: 40,
                                height: 40,
                                imagePath: teamMgr?.image,
                              ),
                              PaddingConfig.w8,
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    teamMgr?.name ?? "NO Team Selected",
                                    style: AppTextStyle.bodySm(
                                      color: AppColors.fontDarkGray,
                                    ),
                                  ),
                                  PaddingConfig.h8,
                                  Text(
                                    teamMgr?.role ?? "NO Team Selected",
                                    style: AppTextStyle.bodyXs(
                                      color: AppColors.fontLightGray,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                      PaddingConfig.h16,
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Team Members",
                        style: AppTextStyle.bodyMd(color: AppColors.blueShade2),
                      ),
                      PaddingConfig.w32,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 300,
                            width: 300,
                            child: ListView.builder(
                              itemCount: membersList.length,
                              itemBuilder:
                                  (context, index) => Padding(
                                    padding: const EdgeInsets.only(bottom: 8.0),
                                    child: Row(
                                      children: [
                                        FetchNetworkImage(
                                          width: 40,
                                          height: 40,
                                          imagePath: membersList[index].image,
                                        ),
                                        PaddingConfig.w8,
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              membersList[index].name,
                                              style: AppTextStyle.bodySm(
                                                color: AppColors.fontDarkGray,
                                              ),
                                            ),
                                            PaddingConfig.h8,
                                            Text(
                                              membersList[index].role,
                                              style: AppTextStyle.bodyXs(
                                                color: AppColors.fontLightGray,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
