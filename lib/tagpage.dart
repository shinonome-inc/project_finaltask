import 'package:flutter/material.dart';

class Tag extends StatefulWidget {
  @override
  _TagState createState() => _TagState();
}

class _TagState extends State<Tag> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.redAccent,
        child: Center(
          child: Text('TagPage'),
        ),
      ),
    );
  }
}
