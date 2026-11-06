import 'package:flutter/material.dart';
import 'package:two_dashboard/core/widgets/container/circle_container_for_left_count.dart';
import 'package:two_dashboard/core/widgets/images/image_circle.dart';

class GroupOfImageCircle extends StatelessWidget {
  const GroupOfImageCircle({super.key, required this.imagePaths});
  final List<String> imagePaths;

  @override
  Widget build(BuildContext context) {
    if (imagePaths.length <= 4) {
      return Stack(
        alignment: AlignmentDirectional.centerStart,
        children: List.generate(
          imagePaths.length,
          (index) => Align(
            alignment: Alignment(index.toDouble(), 0),
            child: ImageCircle(),
          ),
        ),
      );
    } else {
      return Stack(
        alignment: AlignmentDirectional.centerStart,
        children: [
          Align(
            alignment: Alignment(-1, 0),
            child: ImageCircle(width: 30, height: 30),
          ),
          Align(
            alignment: Alignment(-0.6, 0),
            child: ImageCircle(width: 30, height: 30),
          ),
          Align(
            alignment: Alignment(-0.2, 0),
            child: ImageCircle(width: 30, height: 30),
          ),
          Align(
            alignment: Alignment(0.2, 0),
            child: CircleContainerForLeftCount(
              count: imagePaths.length - 3,
              width: 30,
              height: 30,
            ),
          ),
        ],
      );
    }
  }
}
