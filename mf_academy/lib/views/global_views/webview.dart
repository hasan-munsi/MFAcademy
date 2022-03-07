import 'dart:io';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class GlobalWebView extends StatefulWidget {
  final String url;
  const GlobalWebView({Key? key, required this.url}) : super(key: key);

  @override
  State<GlobalWebView> createState() => _GlobalWebViewState();
}

class _GlobalWebViewState extends State<GlobalWebView> {
  @override
  void initState() {
    if (Platform.isAndroid) {
      WebView.platform = AndroidWebView();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WebView(
        initialUrl: widget.url,
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}
