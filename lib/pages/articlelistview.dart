// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:project_finaltask/pages/articlepage.dart';
// import 'package:project_finaltask/utils/changedate.dart';
//
// import '../models/article.dart';
// import '../qiita_qlient.dart';
// import '../utils/color_extension.dart';
//
// class ArticleListView extends StatefulWidget {
//   final String searchword;
//
//   ArticleListView({required this.searchword});
//
//   State<ArticleListView> createState() => _ArticleListViewState();
// }
//
// class _ArticleListViewState extends State<ArticleListView> {
//   int page = 1;
//   bool _isLoading = false;
//   List<Article> _articleList = [];
//
//   @override
//   void initState() {
//     super.initState();
//     this._loadArticle(widget.searchword);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return NotificationListener<ScrollNotification>(
//         onNotification: (ScrollNotification notification) {
//           if (!_isLoading && notification.metrics.extentAfter == 0.0) {
//             _loadArticle(widget.searchword);
//           }
//           return false;
//         },
//         child: ListView.builder(
//           itemCount: _articleList.length,
//           itemBuilder: (BuildContext context, int index) {
//             final article = _articleList[index];
//             //else if(index > _articleList.length){return null;}
//             return index >= _articleList.length
//                 ? Center(
//                     child: CircularProgressIndicator(),
//                   )
//                 : ListTile(
//                     leading: CircleAvatar(
//                       backgroundImage: NetworkImage(article.user.iconUrl),
//                     ),
//                     title: Text(
//                       article.title,
//                       maxLines: 2,
//                       overflow: TextOverflow.ellipsis,
//                       style: TextStyle(fontSize: 14),
//                     ),
//                     subtitle: Container(
//                       decoration: BoxDecoration(
//                         border: Border(
//                             bottom: BorderSide(
//                                 color: '#B2B2B2'.toColor(), width: 0.5)),
//                       ),
//                       child: Padding(
//                         padding: const EdgeInsets.only(bottom: 8.0),
//                         child: Text(
//                           '@${article.user.id} 投稿日:${changeDateFormat(article.date)} LGTM:${article.lgtm.toString()}',
//                           style: TextStyle(
//                             fontSize: 12,
//                           ),
//                         ),
//                       ),
//                     ),
//                     onTap: () {
//                       Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                               builder: (context) =>
//                                   ArticlePage(article: article)));
//                     },
//                   );
//           },
//         ));
//   }
//
//   void _loadArticle(searchword) async {
//     List<Article> results = [];
// //新たなデータを取得
//     try {
//       _isLoading = true;
//       var articleList = await QiitaClient().fetchArticle(page);
//       {
//         if (searchword.isEmpty) {
//           results = articleList;
//         } else {
//           setState(() {
//             results = articleList
//                 .where((element) => element.title.contains(searchword))
//                 .toList();
//           });
//         }
//         page++;
//         setState(() {
//           if (page == 1) {
//             _articleList = results;
//           } else if (page != 1) {
//             _articleList.addAll(results);
//           }
//           //_currentPage = page;
//         });
//         _isLoading = false;
//       }
//     } catch (e) {
//       setState(() {
//         print(e);
//       });
//     }
//   }
// }
