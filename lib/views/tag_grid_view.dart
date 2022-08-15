import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:project_finaltask/models/tag.dart';
import 'package:project_finaltask/pages/tag_detail_page.dart';
import 'package:project_finaltask/utils/color_extension.dart';

class TagGridView extends StatelessWidget {
  late final List<Tag> tags;

  TagGridView({Key? key, required this.tags}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        shrinkWrap: true,
        primary: false,
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 300,
          childAspectRatio: 162 / 138,
        ),
        padding: EdgeInsets.all(8),
        itemCount: tags.length,
        itemBuilder: (BuildContext context, int index) {
          final tag = tags[index];
          return index >= tags.length
              ? Center(
                  child: CupertinoActivityIndicator(),
                )
              : GestureDetector(
                  child: Container(
                    margin: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border:
                            Border.all(color: '#E0E0E0'.toColor(), width: 1)),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image(
                            width: 38,
                            height: 38,
                            image: NetworkImage(tag.iconUrl),
                            errorBuilder: (context, exception, stackTrace) {
                              return Icon(Icons.error);
                            },
                          ),
                          ListTile(
                            title: Center(
                              child: Text(tag.id,
                                  style: TextStyle(
                                    fontSize: 14,
                                  )),
                            ),
                            subtitle: Center(
                              child: Text(
                                '記事件数:${tag.articlecount}\nフォロワー数:${tag.follower}',
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
                  onTap: () {
                    Navigator.of(context)
                        .push(MaterialWithModalsPageRoute(builder: (context) {
                      return TagDetailPage(tag);
                    }));
                  });
        });
  }
}
