import 'package:flutter/material.dart';
import 'package:recipe_app/app/functions.dart';
import 'package:recipe_app/presentation/resources/string_manager.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewSearch extends StatefulWidget {
  final List<String> expectedLables;
  const WebViewSearch({Key? key, required this.expectedLables})
      : super(key: key);

  @override
  _WebViewSearchState createState() => _WebViewSearchState();
}

class _WebViewSearchState extends State<WebViewSearch> {
  late WebViewController _webViewController;
  @override
  Widget build(BuildContext context) {
    return WebView(
      onWebViewCreated: (controller) {
        _webViewController = controller;
      },
      
      initialUrl: StringsManager.initalUrl +
          prepareInitialUrlWebView(widget.expectedLables),
      javascriptMode: JavascriptMode.unrestricted,
    );
  }
}
