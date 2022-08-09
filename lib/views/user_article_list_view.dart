import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:project_finaltask/utils/change_date.dart';

import '../components/webview_modal_component.dart';
import '../models/article.dart';
import '../utils/color_extension.dart';

class UserArticleListView extends StatelessWidget {
  final List<Article> articleList;

  const UserArticleListView({Key? key, required this.articleList})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: articleList.length,
      itemBuilder: (BuildContext context, int index) {
        final article = articleList[index];
        return index >= articleList.length
            ? Center(
                child: CupertinoActivityIndicator(),
              )
            : ListTile(
                title: Text(
                  article.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 14),
                ),
                subtitle: Container(
                  decoration: BoxDecoration(
                    border: Border(
                        bottom:
                            BorderSide(color: '#B2B2B2'.toColor(), width: 0.5)),
                  ),
                  child: Container(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Text(
                      '投稿日:${changeDateFormat(article.date)} LGTM:${article.lgtm.toString()}',
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
                onTap: () {
                  showCupertinoModalBottomSheet(
                      enableDrag: true,
                      context: context,
                      builder: (context) {
                        return WebViewModalComponent(
                            title: 'Article', initialUrl: article.url);
                      });
                },
              );
      },
    );
  }
}
