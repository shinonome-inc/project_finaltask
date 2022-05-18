import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_finaltask/components/appbar.dart';
import 'package:project_finaltask/models/article.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ArticlePage extends StatelessWidget {
  final Article article;
  const ArticlePage({Key? key, required this.article}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarComponent(text: 'Article', backButton: true),
      body: Center(
        child: WebView(
          initialUrl: article.url,
        ),
      ),
    );
  }
}
