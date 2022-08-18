import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:project_finaltask/pages/follow_page.dart';
import 'package:project_finaltask/pages/follower_page.dart';

import '../../models/user.dart';
import '../../utils/color_extension.dart';

class UserProfile extends StatelessWidget {
  final User user;

  const UserProfile({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(24, 23, 24, 0),
      height: 268,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(user.iconUrl),
                radius: 40,
              ),
              SizedBox(height: 10),
              Container(
                padding: EdgeInsets.symmetric(vertical: 4),
                child: Text(
                  user.name ?? user.id,
                  style: TextStyle(fontSize: 14),
                ),
              ),
              Text('@${user.id}',
                  style: TextStyle(
                    fontSize: 12,
                    color: '#828282'.toColor(),
                  )),
              SizedBox(height: 8),
              SizedBox(
                height: 56,
                child: Text(user.description ?? '未設定',
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 12,
                      color: '#828282'.toColor(),
                    )),
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                '${user.followeescount}',
                style: TextStyle(
                  color: '#000000'.toColor(),
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextButton(
                  onPressed: () {
                    if (user.followeescount != 0)
                      Navigator.of(context)
                          .push(MaterialWithModalsPageRoute(builder: (context) {
                        return FollowPage(user);
                      }));
                  },
                  child: Text(
                    'フォロー中',
                    style: TextStyle(
                      color: '#828282'.toColor(),
                      fontStyle: FontStyle.normal,
                      fontSize: 12,
                    ),
                  )),
              Text(
                '${user.followerscount}',
                style: TextStyle(
                  color: '#000000'.toColor(),
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextButton(
                  onPressed: () {
                    if (user.followerscount != 0)
                      Navigator.of(context)
                          .push(MaterialWithModalsPageRoute(builder: (context) {
                        return FollowerPage(user);
                      }));
                  },
                  child: Text(
                    'フォロワー',
                    style: TextStyle(
                      color: '#828282'.toColor(),
                      fontStyle: FontStyle.normal,
                      fontSize: 12,
                    ),
                  )),
            ],
          ),
        ],
      ),
    );
  }
}
