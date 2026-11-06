import 'package:flutter/material.dart';
import 'package:two_dashboard/config/constants/padding_config.dart';
import 'package:two_dashboard/config/theme/text_style.dart';
import 'package:two_dashboard/core/network/enums.dart';
import 'package:two_dashboard/core/widgets/images/fetch_network_image.dart';
import 'package:two_dashboard/features/profile/domain/entities/employee_entity.dart';
import 'package:two_dashboard/config/constants/sizes_config.dart';
import 'package:two_dashboard/config/theme/color.dart';
import 'package:two_dashboard/core/widgets/container/custom_rounder_container.dart';
import 'package:two_dashboard/core/widgets/container/status-containers/field_status_container.dart';
import 'package:iconsax/iconsax.dart';
import 'package:two_dashboard/core/widgets/texts/linked_text.dart';

class ProfileColumn extends StatefulWidget {
  const ProfileColumn({super.key, required this.user});

  final EmployeeEntity user;

  @override
  State<ProfileColumn> createState() => _ProfileColumnState();
}

class _ProfileColumnState extends State<ProfileColumn> {
  // int selectedLang = 0;
  // int selectedMode = 0;
  // Widget _buildRadioForLang(int lang) {
  //   return Row(
  //     children: [
  //       Radio<int>(
  //         value: lang,
  //         groupValue: selectedLang,
  //         activeColor: AppColors.blueShade2,
  //         onChanged: (int? newValue) {
  //           setState(() {
  //             selectedLang = newValue ?? 0;
  //           });
  //         },
  //       ),
  //       Text(
  //         lang == 0 ? TextStrings.english : TextStrings.arabic,
  //         style: AppTextStyle.bodySm(),
  //       ),
  //     ],
  //   );
  // }

  // ///////////////////////////////////////////////////////////////////
  // Widget _buildRadioForMode(int mode) {
  //   return Row(
  //     children: [
  //       Radio<int>(
  //         value: mode,
  //         groupValue: selectedMode,
  //         activeColor: AppColors.blueShade2,
  //         onChanged: (int? newValue) {
  //           setState(() {
  //             selectedMode = newValue ?? 0;
  //           });
  //           // context.read<ThemeCubit>().toggleTheme(
  //           //   newValue == 0 ? TextStrings.light : TextStrings.dark,
  //           // );
  //         },
  //       ),
  //       Text(
  //         mode == 0 ? TextStrings.light : TextStrings.dark,
  //         style: AppTextStyle.bodySm(),
  //       ),
  //     ],
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // image
            Stack(
              alignment: AlignmentDirectional.bottomEnd,
              children: [
                FetchNetworkImage(
                  height: 175,
                  width: 175,
                  shape: BoxShape.circle,
                  imagePath: widget.user.image,
                  firstLetter: widget.user.name.split("").first,
                ),
                IconButton(
                  style: IconButton.styleFrom(
                    backgroundColor: AppColors.blueShade2,
                    padding: const EdgeInsets.all(10),
                    shape: const CircleBorder(),
                  ),
                  onPressed: () {
                    // _getImageFile();
                  },
                  icon: const Icon(Iconsax.camera, color: AppColors.white),
                ),
              ],
            ),
            PaddingConfig.h16,
            // Name
            Text(widget.user.name, style: AppTextStyle.bodyLg()),
            // Email
            Text(
              widget.user.email,
              style: AppTextStyle.bodySm(color: AppColors.fontLightGray),
            ),
            PaddingConfig.h16,
            // Roles
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Iconsax.bag_2, size: SizesConfig.iconsSm),
                PaddingConfig.w8,
                Text("Role", style: AppTextStyle.bodySm()),
              ],
            ),
            PaddingConfig.h8,
            CustomRounderContainer(
              child: Text(
                widget.user.role,
                style: AppTextStyle.bodySm(color: AppColors.fontLightGray),
              ),
            ),
            PaddingConfig.h16,
            // State
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Iconsax.status, size: SizesConfig.iconsSm),
                PaddingConfig.w8,
                Text("Status", style: AppTextStyle.bodySm()),
              ],
            ),
            PaddingConfig.h8,
            widget.user.approved == 1
                ? FieldStatusContainer(fieldStatus: FieldStatus.approved)
                : FieldStatusContainer(fieldStatus: FieldStatus.unApproved),
            PaddingConfig.h16,
            // CV
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Iconsax.document_1, size: SizesConfig.iconsSm),
                PaddingConfig.w8,
                Text("CV", style: AppTextStyle.bodySm()),
              ],
            ),
            PaddingConfig.h8,
            Row(
              children: [
                CustomRounderContainer(
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          color: AppColors.gray,
                        ),
                        child: Text(
                          "PDF",
                          style: AppTextStyle.bodyMd(
                            color: AppColors.fontLightGray,
                          ),
                        ),
                      ),
                      PaddingConfig.w8,
                      LinkedText(link: widget.user.cv),
                    ],
                  ),
                ),
                PaddingConfig.w16,
                IconButton(
                  style: IconButton.styleFrom(
                    backgroundColor: AppColors.blueShade2,
                  ),
                  onPressed: () {},
                  icon: Icon(
                    Iconsax.edit,
                    color: AppColors.white,
                    size: SizesConfig.iconsSm,
                  ),
                ),
              ],
            ),
          ],
        ),
        // Column(
        //   mainAxisAlignment: MainAxisAlignment.start,
        //   crossAxisAlignment: CrossAxisAlignment.start,
        //   children: [
        //     PaddingConfig.h96,
        //     // Edit Button
        //     UpdateElevatedButton(updateType: "Profile", onPressed: () {}),
        //     PaddingConfig.h40,
        //     // Language
        //     Row(
        //       mainAxisAlignment: MainAxisAlignment.start,
        //       children: [
        //         Icon(Iconsax.language_square, size: SizesConfig.iconsSm),
        //         PaddingConfig.w8,
        //         Text("The Language", style: AppTextStyle.bodySm()),
        //       ],
        //     ),
        //     PaddingConfig.h8,
        //     CustomRounderContainer(
        //       child: Row(
        //         children: [
        //           _buildRadioForLang(0),
        //           PaddingConfig.w16,
        //           _buildRadioForLang(1),
        //         ],
        //       ),
        //     ),
        //     PaddingConfig.h24,
        //     // Mode
        //     Row(
        //       mainAxisAlignment: MainAxisAlignment.start,
        //       children: [
        //         Icon(Iconsax.eye, size: SizesConfig.iconsSm),
        //         PaddingConfig.w8,
        //         Text("The Mode", style: AppTextStyle.bodySm()),
        //       ],
        //     ),
        //     PaddingConfig.h8,
        //     CustomRounderContainer(
        //       child: Row(
        //         children: [
        //           _buildRadioForMode(0),
        //           PaddingConfig.w40,
        //           _buildRadioForMode(1),
        //         ],
        //       ),
        //     ),
        //   ],
        // ),
      ],
    );
  }
}
