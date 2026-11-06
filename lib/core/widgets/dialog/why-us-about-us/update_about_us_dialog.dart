// Update About Us
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:two_dashboard/config/constants/padding_config.dart';
import 'package:two_dashboard/config/theme/color.dart';
import 'package:two_dashboard/config/theme/text_style.dart';
import 'package:two_dashboard/core/widgets/buttons/text-buttons/cancel_text_button.dart';
import 'package:two_dashboard/core/widgets/buttons/text-buttons/save_text_button.dart';
import 'package:two_dashboard/features/about-us%20&%20why-us/domain/entities/about_us_entity.dart';
import 'package:two_dashboard/features/about-us%20&%20why-us/presentation/bloc/about_us_why_us_bloc.dart';
import 'package:two_dashboard/features/auth/presentation/widgets/custom_text_form_field.dart';

Future<dynamic> updateAboutUsDialog(
  BuildContext context,
  TextEditingController timeController,
  TextEditingController siteController,
  int id,
) {
  return showDialog(
    context: context,
    builder:
        (context) => SizedBox(
          height: 100,
          child: AlertDialog(
            title: Text(
              "Update about us :",
              style: AppTextStyle.bodyLg(color: AppColors.blueShade2),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomTextFormField(
                  labelText: "work time",
                  controller: timeController,
                  validator: (p0) {
                    if (p0 == null) {
                      return "Add Text";
                    }
                    return null;
                  },
                ),
                PaddingConfig.h8,
                CustomTextFormField(
                  labelText: "work site",
                  controller: siteController,
                  validator: (p0) {
                    if (p0 == null) {
                      return "Add Text";
                    }
                    return null;
                  },
                ),
              ],
            ),
            actions: [
              const CancelTextButton(),
              SaveTextButton(
                onPressed: () {
                  context.read<AboutUsWhyUsBloc>().add(
                    UpdateAboutUsEvent(
                      aboutUsEntity: AboutUsEntity(
                        aboutId: id,
                        aboutWorkTime: timeController.text,
                        aboutSite: siteController.text,
                      ),
                    ),
                  );
                  context.pop();
                },
              ),
            ],
          ),
        ),
  );
}
