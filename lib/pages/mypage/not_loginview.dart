import 'package:flutter/material.dart';
import 'package:project_finaltask/pages/toppage.dart';
import 'package:project_finaltask/utils/color_extension.dart';

class NotLoginView extends StatelessWidget {
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
            Text(
              'ログインが必要です',
              style: TextStyle(
                fontSize: 14,
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 6),
              child: Text(
                'マイページの機能を利用するには\nログインを行っていただく必要があります。',
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
              child: Text('ログインする',
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
                  MaterialPageRoute(builder: (_) => TopPage()),
                );
              },
            ),
          ),
        ),
      ],
    ));
  }
}
