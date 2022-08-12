import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../utils/color_extension.dart';

class EmptyView extends StatelessWidget {
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 200),
            Text(
              '検索にマッチする記事はありませんでした',
              style: TextStyle(
                fontSize: 14,
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20),
              child: Text(
                '検索条件を変えるなどして再度検索をしてください',
                style: TextStyle(
                  fontSize: 12,
                  color: '#828282'.toColor(),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
