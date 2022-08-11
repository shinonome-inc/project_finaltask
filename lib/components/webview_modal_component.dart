import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'appbar_component.dart';

class WebViewModalComponent extends StatefulWidget {
  const WebViewModalComponent({
    Key? key,
    required this.title,
    this.initialUrl,
    this.navigationDelegate,
  }) : super(key: key);

  final String title;
  final String? initialUrl;
  final FutureOr<NavigationDecision> Function(NavigationRequest)?
      navigationDelegate;

  @override
  _WebViewModalComponentState createState() => _WebViewModalComponentState();
}

class _WebViewModalComponentState extends State<WebViewModalComponent> {
  final Set<Factory<OneSequenceGestureRecognizer>> gestureRecognizers = {
    Factory(() => EagerGestureRecognizer())
  };

  UniqueKey _key = UniqueKey();
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Scaffold(
        appBar: AppBarComponent(text: widget.title),
        resizeToAvoidBottomInset: false,
        body: WebView(
          key: _key,
          gestureRecognizers: gestureRecognizers,
          initialUrl: widget.initialUrl,
          onWebViewCreated: _controller.complete,
          navigationDelegate: widget.navigationDelegate,
        ),
      ),
    );
  }
}
