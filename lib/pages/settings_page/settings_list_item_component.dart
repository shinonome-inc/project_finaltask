import 'package:flutter/material.dart';
import 'package:project_finaltask/utils/color_extension.dart';

class SettingsListItemComponent extends StatelessWidget {
  SettingsListItemComponent({
    required this.title,
    required this.trailing,
    required this.onTap,
  });

  final String title;
  final Widget trailing;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
          color: '#FFFFFF'.toColor(),
          border: Border(
              bottom: BorderSide(color: '#E0E0E0'.toColor(), width: 0.5))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title),
          GestureDetector(child: trailing, onTap: onTap),
        ],
      ),
    );
  }
}
