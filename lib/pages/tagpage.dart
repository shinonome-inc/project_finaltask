import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../color_extension.dart';

class Tag extends StatefulWidget {
  @override
  _TagState createState() => _TagState();
}

class _TagState extends State<Tag> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: Text(
        'Tags',
        style: TextStyle(
        fontSize: 17,
        fontFamily: 'Pacifico',
        color: '#000000'.toColor(),
        ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        ),
        );
        }
        }