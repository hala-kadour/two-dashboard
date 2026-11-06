import 'package:flutter/material.dart';
import 'package:two_dashboard/config/constants/base_uri.dart';
import 'package:two_dashboard/config/theme/color.dart';
import 'package:two_dashboard/config/theme/text_style.dart';
import 'package:url_launcher/url_launcher.dart';

class LinkedText extends StatelessWidget {
  const LinkedText({super.key, required this.link});
  final String? link;

  @override
  Widget build(BuildContext context) {
    return (link == null)
        ? Text("No data")
        : InkWell(
          onTap: () => launchUrl(Uri.parse('$imageUri$link')),
          child: Text(
            link!,
            style: AppTextStyle.dataTableCellStyle(
              color: AppColors.fontLightGray,
              decoration: TextDecoration.underline,
            ),
            textAlign: TextAlign.center,
          ),
        );
  }
}
