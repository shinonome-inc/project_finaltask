import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_finaltask/bottomnavigation.dart';
import 'package:project_finaltask/qiita_client.dart';

import '../utils/color_extension.dart';
import 'loginpage.dart';

class TopPage extends StatefulWidget {
  // final Uri? uri;
  // const TopPage({Key? key, required this.uri}) : super(key: key);
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
          MaterialPageRoute(builder: (context) => BottomNavigation()),
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
                          showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(20))),
                              builder: (context) {
                                return Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.95,
                                    child: SafeArea(child: LoginPage()));
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
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
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

// class _LoadAccessToken extends StatefulWidget {
//   @override
//   _LoadAccessTokenState createState() => _LoadAccessTokenState();
// }
//
// class _LoadAccessTokenState extends State<_LoadAccessToken> {
//   @override
//   void initState() {
//     super.initState();
//
//     QiitaClient().accessTokenIsSaved().then((isSaved) {
//       if (isSaved) {
//         Navigator.of(context).pushReplacement(
//           MaterialPageRoute(builder: (_) => BottomNavigation()),
//         );
//       }
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     throw UnimplementedError();
//   }
// }
