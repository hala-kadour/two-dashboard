import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:two_dashboard/config/constants/padding_config.dart';
import 'package:two_dashboard/config/constants/sizes_config.dart';
import 'package:two_dashboard/config/theme/color.dart';
import 'package:two_dashboard/config/theme/text_style.dart';
import 'package:two_dashboard/core/widgets/images/fetch_network_image.dart';
import 'package:two_dashboard/features/services/domain/entities/service_entity.dart';

import '../../../../core/widgets/menus/service_side_menu.dart';

class ServiceCard extends StatelessWidget {
  const ServiceCard({super.key, required this.serviceEntity});
  final ServiceEntity serviceEntity;

  @override
  Widget build(BuildContext context) {
    final GlobalKey iconKey = GlobalKey();

    return Container(
      key: iconKey,
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(SizesConfig.borderRadiusMd),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 0),
            color: AppColors.gray,
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: () {
                  serviceCardSideMenu(iconKey, context, serviceEntity);
                },
                child: const Icon(Iconsax.more),
              ),
            ],
          ),
          FetchNetworkImage(
            imagePath: serviceEntity.imageE,
            height: 180,
            width: double.maxFinite,
          ),
          PaddingConfig.h8,
          Text(serviceEntity.titleE, style: AppTextStyle.bodyLg()),
          PaddingConfig.h8,
          Text(
            serviceEntity.descriptionE,
            style: AppTextStyle.bodyMd(color: AppColors.fontLightGray),
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
