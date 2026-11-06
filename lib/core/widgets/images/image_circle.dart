import 'package:flutter/material.dart';

import '../../../config/strings/assets_path.dart';
import '../../network/enums.dart';
import 'custom_rounded_image.dart';

class ImageCircle extends StatelessWidget {
  const ImageCircle({super.key, this.width, this.height});
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return CustomRoundedImage(
      width: width ?? 40,
      height: height ?? 40,
      padding: 0.0,
      imageType: ImageType.asset,
      image: ImagesPath.profile,
      shape: BoxShape.circle,
      applyImageradius: false,
    );
  }
}
