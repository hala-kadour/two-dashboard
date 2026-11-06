import 'package:flutter/material.dart';
import 'package:two_dashboard/config/constants/padding_config.dart';
import 'package:two_dashboard/config/constants/sizes_config.dart';
import 'package:two_dashboard/config/theme/color.dart';
import 'package:two_dashboard/config/theme/text_style.dart';
import 'package:two_dashboard/core/widgets/container/custom_rounder_container.dart';
import 'package:two_dashboard/core/widgets/images/fetch_network_image.dart';
import 'package:two_dashboard/features/projects%20&%20team%20&%20status%20&%20meeting/domain/entity/team_entity.dart';

class CustomTeamGridView extends StatelessWidget {
  const CustomTeamGridView({
    super.key,
    required this.teamList,
    required this.selectedTeam,
    required this.onUpdate,
    required this.wantToChoose,
  });
  final List<TeamEntity> teamList;
  final ValueNotifier<TeamEntity?> selectedTeam;
  final Function(TeamEntity?) onUpdate;
  final bool wantToChoose;

  @override
  Widget build(BuildContext context) {
    int crossAxisCount = 1;
    double width = MediaQuery.of(context).size.width;

    if (width >= SizesConfig.desktopScreenSize) {
      crossAxisCount = 4;
    } else if (width >= SizesConfig.tabletScreenSize) {
      crossAxisCount = 3;
    }
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(8),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 0.9,
      ),
      itemCount: teamList.length,
      itemBuilder: (context, index) {
        final team = teamList[index];
        return ValueListenableBuilder(
          valueListenable: selectedTeam,
          builder:
              (context, value, child) => GestureDetector(
                onTap: () {
                  if (wantToChoose) {
                    selectedTeam.value = team;
                    onUpdate(team);
                  }
                },
                child: CustomRounderContainer(
                  width: double.infinity,
                  backgroundColor:
                      (value != null && value.id == team.id)
                          ? AppColors.blueShade1
                          : AppColors.white,
                  borderColor:
                      (value != null && value.id == team.id)
                          ? AppColors.blueShade2
                          : AppColors.grayShade2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(team.name, style: AppTextStyle.bodyMd()),
                      PaddingConfig.h24,
                      Wrap(
                        spacing: 12,
                        runSpacing: 16,
                        alignment: WrapAlignment.center,
                        children:
                            team.membersList.map((member) {
                              return SizedBox(
                                width: 80,
                                child: Column(
                                  children: [
                                    FetchNetworkImage(
                                      imagePath: member.image,
                                      shape: BoxShape.circle,
                                      height: 50,
                                      width: 50,
                                    ),
                                    PaddingConfig.h8,
                                    Text(
                                      member.name,
                                      style: AppTextStyle.bodySm(),
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.center,
                                      maxLines: 1,
                                    ),
                                    Text(
                                      member.role,
                                      style: AppTextStyle.bodyXs(
                                        color: AppColors.fontLightGray,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.center,
                                      maxLines: 1,
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
                      ),
                    ],
                  ),
                ),
              ),
        );
      },
    );
  }
}
