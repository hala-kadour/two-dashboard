import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:two_dashboard/config/constants/sizes_config.dart';
import 'package:two_dashboard/config/theme/color.dart';
import 'package:two_dashboard/config/theme/text_style.dart';

import '../../../features/contracts/domain/entities/contract_entity.dart';
import '../container/custom_rounder_container.dart';

class CustomPopuMenuForContractEntity extends StatelessWidget {
  const CustomPopuMenuForContractEntity({
    super.key,
    required this.selectYour,
    required this.value,
    required this.items,
    required this.onSelected,
  });
  final String selectYour;
  final ContractEntity? value;
  final List<PopupMenuItem<ContractEntity>> items;
  final void Function(ContractEntity)? onSelected;

  @override
  Widget build(BuildContext context) {
    return CustomRounderContainer(
      borderColor: AppColors.grayShade2,
      child: PopupMenuButton<ContractEntity>(
        onSelected: onSelected,
        itemBuilder: (context) => items,
        color: AppColors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(SizesConfig.borderRadiusSm),
        ),
        offset: const Offset(0, 40),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              value != null ? value!.contractPath : "Select your $selectYour",
              style: AppTextStyle.bodySm(
                color:
                    value != null
                        ? AppColors.fontDarkGray
                        : AppColors.fontLightGray,
              ),
            ),
            const Icon(
              Iconsax.arrow_down_1,
              color: AppColors.greenShade2,
              size: SizesConfig.iconsSm,
            ),
          ],
        ),
      ),
    );
  }
}
