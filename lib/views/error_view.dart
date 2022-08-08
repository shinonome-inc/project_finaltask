import 'package:flutter/material.dart';
import 'package:project_finaltask/utils/color_extension.dart';

import '../bottom_navigation.dart';

class ErrorView extends StatelessWidget {
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(child: Container()),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 42.67),
              child: Image.asset('assets/images/networkimage.png'),
              width: 66.67,
              height: 66.67,
            ),
            Text(
              'ネットワークエラー',
              style: TextStyle(
                fontSize: 14,
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 6),
              child: Text(
                'お手数ですが電波の良い場所で\n再度読み込みをお願いします',
                style: TextStyle(
                  fontSize: 12,
                  height: 2.0,
                  color: '#828282'.toColor(),
                ),
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
        Expanded(child: Container()),
        Padding(
          padding: const EdgeInsets.only(left: 16, right: 16, bottom: 32),
          child: SizedBox(
            height: 50,
            child: TextButton(
              style: TextButton.styleFrom(
                backgroundColor: '#74C13A'.toColor(),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.0),
                ),
              ),
              child: Text('再読み込みする',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    letterSpacing: 0.75,
                    color: '#ffffff'.toColor(),
                  )),
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (_) => BottomNavigation()),
                );
              },
            ),
          ),
        ),
      ],
    ));
  }
}
