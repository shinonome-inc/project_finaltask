import 'package:flutter/material.dart';
import 'package:project_finaltask/components/appbar_component.dart';

import '../../models/user.dart';
import '../views/user_view.dart';

class UserPage extends StatefulWidget {
  late final User user;
  UserPage(this.user);

  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarComponent(text: 'Users', backButton: true),
      body: Center(child: UserView(widget.user)),
    );
  }
}
