import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_finaltask/bottomnavigation.dart';

import 'utils/color_extension.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      home: TopPage(),
    );
  }
}

class TopPage extends StatefulWidget {
  @override
  _TopPageState createState() => _TopPageState();
}

class _TopPageState extends State<TopPage> {
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
                        onPressed: () {},
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
                    ),
                    onPressed: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => BottomNavigation()));
                    },
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 64,
          ),
        ],
      )
    ]));
  }
}
