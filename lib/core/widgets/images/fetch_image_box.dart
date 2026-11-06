import 'dart:convert';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:two_dashboard/config/constants/padding_config.dart';
import 'package:two_dashboard/config/constants/sizes_config.dart';
import 'package:two_dashboard/config/theme/color.dart';
import 'package:two_dashboard/config/theme/text_style.dart';
import 'package:two_dashboard/core/functions/get_network_image.dart';
import 'package:two_dashboard/core/network/enums.dart';
import 'package:two_dashboard/core/widgets/images/custom_rounded_image.dart';

// ignore: must_be_immutable
class FetchImageBox extends StatefulWidget {
  FetchImageBox({
    super.key,
    required this.imageB64,
    required this.onUpdate,
    this.initNetworkImage,
  });
  String? imageB64;
  String? initNetworkImage;
  final Function(String?) onUpdate;

  @override
  State<FetchImageBox> createState() => _FetchImageBoxState();
}

class _FetchImageBoxState extends State<FetchImageBox> {
  Uint8List? imageBytes;

  Future<void> _getImageFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: false,
    );
    if (result != null && result.files.isNotEmpty) {
      final bytes = await result.files.first.xFile.readAsBytes();
      imageBytes = bytes;
      widget.imageB64 = base64Encode(bytes);
      widget.onUpdate(widget.imageB64);
    }
  }

  void getImage() async {
    if (widget.initNetworkImage != null) {
      setState(() async {
        imageBytes = await fetchImage(widget.initNetworkImage!);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    getImage();
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 250,
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.gray, width: .7),
            borderRadius: BorderRadius.circular(SizesConfig.borderRadiusMd),
          ),
          padding: const EdgeInsets.all(8.0),
          child:
              imageBytes == null
                  ? const Icon(Iconsax.gallery, size: SizesConfig.iconsXl)
                  : CustomRoundedImage(
                    imageType: ImageType.memory,
                    memoryImage: imageBytes,
                    borderRadius: 10,
                  ),
        ),
        PaddingConfig.h8,
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            InkWell(
              onTap: () => _getImageFile(),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    SizesConfig.borderRadiusSm,
                  ),
                  border: Border.all(color: AppColors.gray, width: .7),
                ),
                child: Text("Upload Image", style: AppTextStyle.bodySm()),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
