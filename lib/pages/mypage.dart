// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:project_finaltask/components/appbar.dart';
// import 'package:project_finaltask/pages/articlelistview.dart';
//
// import '../models/article.dart';
// import '../qiita_qlient.dart';
// import '../utils/color_extension.dart';
// import '../view.dart';
//
// class MyPage extends StatefulWidget {
//   @override
//   _MyPageState createState() => _MyPageState();
// }
//
// class _MyPageState extends State<MyPage> {
//   List<Article> articleList = [];
//   bool _isLoading = false;
//   int page = 1;
//
//   @override
//   void initState() {
//     super.initState();
//     loadArticle();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBarComponent(text: 'Article'),
//       body: Center(
//         child: FutureBuilder<List<Article>>(
//             future: QiitaClient().fetchArticle(1),
//             builder: (context, snapshot) {
//               if (snapshot.hasData) {
//                 return NotificationListener<ScrollNotification>(
//                   onNotification: (ScrollNotification notification) {
//                     if (!_isLoading &&
//                         notification.metrics.extentAfter == 0.0) {
//                       loadArticle();
//                     }
//                     return false;
//                   },
//                   child: articleList.isNotEmpty
//                       ? Column(children: [
//                           Container(
//                             padding: EdgeInsets.only(left: 12),
//                             child: Text(
//                               "  投稿記事",
//                               style: TextStyle(
//                                 fontSize: 12,
//                                 color: '#828282'.toColor(),
//                               ),
//                             ),
//                             color: '#F2F2F2'.toColor(),
//                             height: 28,
//                             width: double.infinity,
//                             alignment: Alignment(-1, 0),
//                           ),
//                           Flexible(
//                             child: ArticleListView(articleList: articleList),
//                           ),
//                         ])
//                       : EmptyView(),
//                 );
//               }
//               return CircularProgressIndicator();
//             }),
//       ),
//     );
//   }
//
//   void loadArticle() async {
//     //新たなデータを取得
//     try {
//       _isLoading = true;
//       List<Article> results =
//           await QiitaTagArticle().fetchArticle(widget.tag, page);
//       page++;
//       setState(() {
//         if (page == 1) {
//           articleList = results;
//         } else if (page != 1) articleList.addAll(results);
//       });
//       _isLoading = false;
//     } catch (e) {
//       setState(() {
//         print(e);
//       });
//     }
//   }
// }
import 'package:flutter/material.dart';

class MyPage extends StatefulWidget {
  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.blue,
        child: Center(
          child: Text('MyPage'),
        ),
      ),
    );
  }
}
