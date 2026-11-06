import 'dart:convert';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:two_dashboard/config/constants/padding_config.dart';
import 'package:two_dashboard/config/constants/sizes_config.dart';
import 'package:two_dashboard/config/theme/color.dart';
import 'package:two_dashboard/config/theme/text_style.dart';

// ignore: must_be_immutable
class FetchFileBox extends StatefulWidget {
  FetchFileBox({
    super.key,
    required this.fileB64,
    required this.onUpdate,
    this.changeStyle = false,
    this.isPDF = true,
  });
  String? fileB64;
  bool isPDF;
  final Function(String?) onUpdate;
  final bool changeStyle;

  @override
  State<FetchFileBox> createState() => _FetchFileBoxState();
}

class _FetchFileBoxState extends State<FetchFileBox> {
  String? filePathName;
  Future<void> _getFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: widget.isPDF ? ['pdf'] : ['doc', 'docx'],
      allowMultiple: false,
    );
    if (result != null && result.files.isNotEmpty) {
      final bytes = await result.files.first.xFile.readAsBytes();
      filePathName = result.files.first.name;
      widget.fileB64 = base64Encode(bytes);
      widget.onUpdate(widget.fileB64);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      decoration: BoxDecoration(
        color: widget.changeStyle ? Colors.transparent : AppColors.fieldColor,
        borderRadius: BorderRadius.circular(12),
        border:
            widget.changeStyle
                ? Border.all(color: AppColors.gray, width: .8)
                : null,
      ),
      padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
      child: Column(
        children: [
          InkWell(
            onTap: () async {
              _getFile();
            },
            child: const Icon(
              Iconsax.direct_inbox,
              size: SizesConfig.iconsMd,
              color: AppColors.greenShade2,
            ),
          ),
          PaddingConfig.h8,
          Text(
            widget.fileB64 != null ? "File selected" : "Select a file",
            style: AppTextStyle.bodySm(color: AppColors.greenShade2),
          ),
          PaddingConfig.h8,
          filePathName != null
              ? Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.file_present_outlined,
                      color: AppColors.greenShade2,
                      size: SizesConfig.iconsSm,
                    ),
                    PaddingConfig.w8,
                    SizedBox(
                      width: 200,
                      child: Text(
                        "$filePathName",
                        style: AppTextStyle.bodySm(
                          color: AppColors.greenShade2,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              )
              : SizedBox(),
        ],
      ),
    );
  }
}
