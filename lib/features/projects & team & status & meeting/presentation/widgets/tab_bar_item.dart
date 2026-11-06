import 'package:flutter/material.dart';
import 'package:two_dashboard/config/constants/padding_config.dart';
import 'package:two_dashboard/config/constants/sizes_config.dart';

class TabBarItem extends StatelessWidget {
  const TabBarItem({super.key, required this.itemIcon, required this.itemName});
  final IconData itemIcon;
  final String itemName;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        children: [
          Icon(itemIcon, size: SizesConfig.iconsSm),
          PaddingConfig.w8,
          Text(itemName),
        ],
      ),
    );
  }
}
