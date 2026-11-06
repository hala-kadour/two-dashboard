import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:two_dashboard/config/constants/padding_config.dart';
import 'package:two_dashboard/config/constants/sizes_config.dart';
import 'package:two_dashboard/config/theme/color.dart';
import 'package:two_dashboard/config/theme/text_style.dart';
import 'package:two_dashboard/core/widgets/images/fetch_network_image.dart';
import 'package:two_dashboard/core/widgets/menus/post_side_menu.dart';
import 'package:two_dashboard/features/posts/domain/entities/post_entity.dart';

import '../../../../core/network/enums.dart';
import '../../../../core/widgets/container/status-containers/field_status_container.dart';

class PostCard extends StatelessWidget {
  const PostCard({super.key, required this.postEntity});
  final PostEntity postEntity;

  @override
  Widget build(BuildContext context) {
    final GlobalKey iconKey = GlobalKey();

    return Container(
      key: iconKey,
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(SizesConfig.borderRadiusMd),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 0),
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
              Tooltip(
                message: "More",
                child: GestureDetector(
                  onTap: () {
                    showPostCardSideMenu(iconKey, context, postEntity);
                  },
                  child: const Icon(Iconsax.more),
                ),
              ),
            ],
          ),
          FetchNetworkImage(
            imagePath: postEntity.poster,
            height: 180,
            width: double.maxFinite,
          ),
          FieldStatusContainer(
            fieldStatus:
                postEntity.active == 1
                    ? FieldStatus.active
                    : FieldStatus.unActive,
          ),
          PaddingConfig.h8,
          Text(
            postEntity.body,
            style: AppTextStyle.bodyLg(),
            overflow: TextOverflow.visible,
          ),
        ],
      ),
    );
  }
}
