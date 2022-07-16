import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/color_extension.dart';

class ErrorView extends StatelessWidget {
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'ネットワークエラー',
            style: TextStyle(
              fontSize: 14,
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 20),
            child: Text(
              'お手数ですが電波の良い場所で\n再度読み込みをお願いします',
              style: TextStyle(
                fontSize: 12,
                color: '#828282'.toColor(),
              ),
            ),
          )
        ],
      ),
    );
  }
}
