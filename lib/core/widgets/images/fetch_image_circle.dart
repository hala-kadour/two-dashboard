import 'dart:convert';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:two_dashboard/config/constants/sizes_config.dart';
import 'package:two_dashboard/config/theme/color.dart';
import 'package:two_dashboard/core/network/enums.dart';
import 'package:two_dashboard/core/widgets/images/custom_rounded_image.dart';

// ignore: must_be_immutable
class FetchImageCircle extends StatefulWidget {
  FetchImageCircle({super.key, required this.imageB64, required this.onUpdate});
  String? imageB64;
  final Function(String?) onUpdate;

  @override
  State<FetchImageCircle> createState() => _FetchImageCircleState();
}

class _FetchImageCircleState extends State<FetchImageCircle> {
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

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        Container(
          width: 130,
          height: 130,
          clipBehavior: Clip.hardEdge,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.fieldColor,
          ),
          child:
              imageBytes == null
                  ? const Icon(Iconsax.image, size: SizesConfig.iconsMd)
                  : CustomRoundedImage(
                    padding: 0,
                    shape: BoxShape.circle,
                    imageType: ImageType.memory,
                    memoryImage: imageBytes,
                    applyImageradius: false,
                  ),
        ),
        IconButton(
          style: IconButton.styleFrom(
            backgroundColor: AppColors.greenShade3,
            padding: const EdgeInsets.all(10),
            shape: const CircleBorder(),
          ),
          onPressed: () {
            _getImageFile();
          },
          icon: const Icon(Iconsax.camera, color: AppColors.white),
        ),
      ],
    );
  }
}
