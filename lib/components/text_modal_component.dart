import 'package:flutter/material.dart';
import 'package:project_finaltask/utils/color_extension.dart';

class TextModalComponent extends StatelessWidget {
  const TextModalComponent({Key? key, required this.title, required this.text})
      : super(key: key);

  final String title;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.center,

          height: 59,
          decoration: BoxDecoration(
            color: '#F9F9F9'.toColor(),
            border: Border(
                bottom: BorderSide(color: '#B2B2B2'.toColor(), width: 0.5)),
          ),
          child: Material(
            child: Text(
              title,
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w600,
                color: '#000000'.toColor(),
              ),
            ),
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
              child: Container(
                  color: '#F7F7F7'.toColor(),
                  padding: EdgeInsets.symmetric(vertical: 18, horizontal: 16),
                  child: Material(child: Text(text)))),
        ),
      ],
    );
  }
}
