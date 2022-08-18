import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_finaltask/components/appbar_component.dart';
import 'package:project_finaltask/qiita_client.dart';

import '../models/user.dart';
import '../views/empty_view.dart';
import '../views/error_view.dart';
import '../views/user_list_view.dart';

class FollowPage extends StatefulWidget {
  late final User user;
  FollowPage(this.user);

  @override
  _FollowPageState createState() => _FollowPageState();
}

class _FollowPageState extends State<FollowPage> {
  List<User> userList = [];
  bool _isLoading = false;
  int page = 1;

  @override
  void initState() {
    super.initState();
    loadUser();
  }

  @override
  Widget build(BuildContext context) {
    print(page);
    return Scaffold(
      appBar: AppBarComponent(
        text: 'Follows',
        backButton: true,
      ),
      body: Center(
        child: FutureBuilder<List<User>>(
            future: QiitaClient().getUserFollowees(page, widget.user.id),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return NotificationListener<ScrollNotification>(
                  onNotification: (ScrollNotification notification) {
                    if (!_isLoading &&
                        notification.metrics.extentAfter == 0.0) {
                      loadUser();
                    }
                    return false;
                  },
                  child: userList.isNotEmpty
                      ? CustomScrollView(
                          physics: BouncingScrollPhysics(),
                          slivers: [
                            CupertinoSliverRefreshControl(
                                onRefresh: refreshUser),
                            SliverToBoxAdapter(
                                child: UserListView(userList: userList)),
                          ],
                        )
                      : _isLoading
                          ? CupertinoActivityIndicator()
                          : EmptyView(),
                );
              } else if (snapshot.hasError) {
                return ErrorView();
              } else
                return const CupertinoActivityIndicator();
            }),
      ),
    );
  }

  void loadUser() async {
    _isLoading = true;
    List<User> results =
        await QiitaClient().getUserFollowees(page, widget.user.id);
    page++;
    userList.addAll(results);
    setState(() {
      _isLoading = false;
    });
  }

  Future<void> refreshUser() async {
    page = 1;
    _isLoading = true;
    List<User> results =
        await QiitaClient().getUserFollowees(page, widget.user.id);
    page++;
    setState(() {
      userList = results;
      _isLoading = false;
    });
  }
}
