import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../models/user.dart';
import '../pages/user_page.dart';
import '../utils/color_extension.dart';

class UserListView extends StatelessWidget {
  final List<User> userList;

  const UserListView({Key? key, required this.userList}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const AlwaysScrollableScrollPhysics(),
      shrinkWrap: true,
      primary: false,
      itemCount: userList.length,
      itemBuilder: (BuildContext context, int index) {
        final user = userList[index];
        return index >= userList.length
            ? Center(
                child: CupertinoActivityIndicator(),
              )
            : GestureDetector(
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: '#E0E0E0'.toColor(), width: 1)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundImage: NetworkImage(user.iconUrl),
                            radius: 16,
                          ),
                          SizedBox(width: 8),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                user.name!,
                                style: TextStyle(fontSize: 14),
                              ),
                              Text('@${user.id}',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: '#828282'.toColor(),
                                  )),
                            ],
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Text(
                          'Posts: ${user.itemscount}',
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                      Text(
                        user.description!,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 12,
                          color: '#828282'.toColor(),
                        ),
                      ),
                    ],
                  ),
                ),
                onTap: () {
                  Navigator.of(context)
                      .push(MaterialWithModalsPageRoute(builder: (context) {
                    return UserPage(user);
                  }));
                });
      },
    );
  }
}
