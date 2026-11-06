import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:two_dashboard/config/constants/padding_config.dart';
import 'package:two_dashboard/config/constants/sizes_config.dart';
import 'package:two_dashboard/config/routes/app_route_config.dart';
import 'package:two_dashboard/config/theme/color.dart';
import 'package:two_dashboard/config/theme/text_style.dart';
import 'package:two_dashboard/core/widgets/container/custom_rounder_container.dart';
import 'package:two_dashboard/core/widgets/texts/page_title.dart';

class MainContractPage extends StatelessWidget {
  const MainContractPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(SizesConfig.lg),
        child: Column(
          children: [
            const PageTitle(pageTitle: "Contracts"),
            const SizedBox(height: SizesConfig.spaceBtwSections),
            const SizedBox(height: SizesConfig.spaceBtwSections),
            Text(
              "Choose Your Gate Based on Your Role 🔥:",
              style: AppTextStyle.bodyLg(),
            ),
            const SizedBox(height: SizesConfig.spaceBtwSections),
            const SizedBox(height: SizesConfig.spaceBtwSections),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomRounderContainer(
                  height: 200,
                  width: 300,
                  onTap: () => context.pushNamed(AppRouteConfig.adminContracts),
                  backgroundColor: AppColors.redShade1,
                  showBorder: false,
                  child: Center(
                    child: Text(
                      "Admin Gate 👨‍💼",
                      style: AppTextStyle.bodyMd(color: AppColors.redShade3),
                    ),
                  ),
                ),
                PaddingConfig.w16,
                CustomRounderContainer(
                  height: 200,
                  width: 300,
                  onTap: () => context.pushNamed(AppRouteConfig.cmContracts),
                  backgroundColor: AppColors.blueShade1,
                  showBorder: false,
                  child: Center(
                    child: Text(
                      "Contract Manager Gate 👨‍⚖️",
                      style: AppTextStyle.bodyMd(color: AppColors.blueShade3),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
