import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:project_finaltask/bottom_navigation.dart';
import 'package:project_finaltask/qiita_client.dart';

import '../utils/color_extension.dart';
import 'login_page.dart';

class TopPage extends StatefulWidget {
  @override
  _TopPageState createState() => _TopPageState();
}

class _TopPageState extends State<TopPage> {
  @override
  void initState() {
    super.initState();

    QiitaClient().accessTokenIsSaved().then((isSaved) {
      if (isSaved) {
        Navigator.of(context).pushReplacement(
          MaterialWithModalsPageRoute(builder: (context) => BottomNavigation()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: <Widget>[
      Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/backgroundimage.png'),
            fit: BoxFit.cover,
          ),
        ),
      ),
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
              flex: 5,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Qiita Feed App',
                      style: TextStyle(
                        fontSize: 36,
                        fontFamily: 'Pacifico',
                        color: '#ffffff'.toColor(),
                      ),
                    ),
                    Text(
                      '-PlayGround-',
                      style: TextStyle(
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        letterSpacing: 0.25,
                        color: '#ffffff'.toColor(),
                      ),
                    ),
                  ],
                ),
              )),
          Expanded(
            flex: 2,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 16, right: 16),
                    child: SizedBox(
                      height: 50,
                      child: TextButton(
                        onPressed: () {
                          showCupertinoModalBottomSheet(
                              enableDrag: true,
                              context: context,
                              builder: (context) {
                                return LoginPage();
                              });
                        },
                        style: TextButton.styleFrom(
                          backgroundColor: '#468300'.toColor(),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                        ),
                        child: Text(
                          'ログインする',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            letterSpacing: 0.75,
                            color: '#ffffff'.toColor(),
                          ),
                        ),
                      ),
                    ),
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacement(
                            MaterialWithModalsPageRoute(
                                builder: (context) => BottomNavigation()));
                      },
                      child: Text(
                        'ログインせずに利用する',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          letterSpacing: 0.75,
                          color: '#ffffff'.toColor(),
                        ),
                      )),
                ],
              ),
            ),
          ),
          SizedBox(height: 64),
        ],
      )
    ]));
  }
}
