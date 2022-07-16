import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_finaltask/pages/toppage.dart';

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
      theme: ThemeData(
          primaryIconTheme: IconThemeData(color: '#468300'.toColor())),
      home: TopPage(),
    );
  }
}
