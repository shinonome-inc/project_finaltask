import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_finaltask/components/appbar.dart';
import 'package:project_finaltask/models/tag.dart';
import 'package:project_finaltask/pages/tagdetailpage.dart';
import 'package:project_finaltask/qiita_qlient.dart';

class TagPage extends StatefulWidget {
  @override
  _TagPageState createState() => _TagPageState();
}

class _TagPageState extends State<TagPage> {
  final Future<List<Tag>> tags = QiitaTag.fetchTag();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarComponent(text: 'Tag'),
      body: Center(
        child: FutureBuilder<List<Tag>>(
            future: tags,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return TagGridView(tags: snapshot.data!.toList());
              }
              return CircularProgressIndicator();
            }),
      ),
    );
  }
}

class TagGridView extends StatelessWidget {
  late final List<Tag> tags;
  TagGridView({Key? key, required this.tags}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 300,
          childAspectRatio: 162 / 138,
        ),
        padding: EdgeInsets.all(8),
        itemCount: tags.length,
        itemBuilder: (BuildContext context, int index) {
          final tag = tags[index];
          return GestureDetector(
              child: Card(
                margin: EdgeInsets.all(8),
                child: Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(8)),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image(
                            width: 38,
                            height: 38,
                            image: NetworkImage(tag.iconUrl)),
                        ListTile(
                          title: Center(
                            child: Text(tag.id,
                                style: TextStyle(
                                  fontSize: 14,
                                )),
                          ),
                          subtitle: Center(
                            child: Text(
                              '????????????:${tag.articlecount}\n??????????????????:${tag.follower}',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return TagDetailPage(tag);
                }));
              });
        });
  }
}
