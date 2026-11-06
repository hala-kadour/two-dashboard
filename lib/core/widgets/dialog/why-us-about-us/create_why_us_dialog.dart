// Create Why Us
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:two_dashboard/config/theme/text_style.dart';
import 'package:two_dashboard/core/widgets/buttons/text-buttons/cancel_text_button.dart';
import 'package:two_dashboard/core/widgets/buttons/text-buttons/save_text_button.dart';
import 'package:two_dashboard/features/about-us%20&%20why-us/presentation/bloc/about_us_why_us_bloc.dart';
import 'package:two_dashboard/features/auth/presentation/widgets/custom_text_form_field.dart';

Future<dynamic> craeteWhyUsDialog(
  BuildContext context,
  TextEditingController controller,
) {
  return showDialog(
    context: context,
    builder:
        (context) => AlertDialog(
          title: Text("Create Why Us Item :", style: AppTextStyle.bodyLg()),
          content: CustomTextFormField(
            labelText: "Label",
            controller: controller,
            validator: (p0) {
              if (p0 == null) {
                return "Add Text";
              }
              return null;
            },
          ),
          actions: [
            const CancelTextButton(),
            SaveTextButton(
              onPressed: () {
                context.read<AboutUsWhyUsBloc>().add(
                  CreateWhyUsEvent(whyUs: controller.text),
                );
                context.pop();
              },
            ),
          ],
        ),
  );
}
