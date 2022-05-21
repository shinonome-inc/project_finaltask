import 'package:flutter/material.dart';

import '../utils/color_extension.dart';

class AppBarComponent extends StatelessWidget implements PreferredSizeWidget {
  const AppBarComponent({Key? key, required this.text, this.backButton = false})
      : super(key: key);
  final String text;
  final bool backButton;

  @override
  Size get preferredSize => Size.fromHeight(60.0);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: backButton
          ? IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.chevron_left, color: '#468300'.toColor()),
              iconSize: 45,
            )
          : SizedBox.shrink(),
      title: Text(
        text,
        style: TextStyle(
          fontSize: 17,
          fontFamily: 'Pacifico',
          color: '#000000'.toColor(),
        ),
      ),
      centerTitle: true,
      backgroundColor: Colors.white,
    );
  }
}
