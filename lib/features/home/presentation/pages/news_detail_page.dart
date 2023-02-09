import 'package:flutter/material.dart' hide Colors;
import 'package:news_apps/themes/themes.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NewsDetailPage extends StatefulWidget {
  final String webUrl;

  const NewsDetailPage({Key? key, required this.webUrl}) : super(key: key);

  @override
  State<NewsDetailPage> createState() => _NewsDetailPageState();
}

class _NewsDetailPageState extends State<NewsDetailPage> {
  final webController = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..setBackgroundColor(Colors.white)
    ..setNavigationDelegate(
      NavigationDelegate(
        onWebResourceError: (WebResourceError error) {},
        onNavigationRequest: (NavigationRequest request) {
          if (request.url.startsWith('https://www.youtube.com/')) {
            return NavigationDecision.prevent;
          }
          return NavigationDecision.navigate;
        },
      ),
    );

  @override
  Widget build(BuildContext context) {
    webController.loadRequest(Uri.parse(widget.webUrl));

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: WebViewWidget(controller: webController),
      ),
    );
  }
}
