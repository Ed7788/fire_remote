import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPage extends StatelessWidget {
  final String? link;
  const WebViewPage({super.key, required this.link});

  @override
  Widget build(BuildContext context) {
   late WebViewController webController;
    return WillPopScope(
      onWillPop: () async {
        if (await webController.canGoBack()) {
          webController.goBack();
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('History ended.'),
            ),
          );
        }

        // Stay App
        return false;
      },
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              child: WebView(
                initialUrl: link,
                javascriptMode: JavascriptMode.unrestricted,
                onWebViewCreated: (controller) {
                  webController = controller;
                },
                onPageStarted: (url) {
                    Future.delayed(const Duration(microseconds: 300), () {
                      webController.runJavascriptReturningResult(
                        "document.getElementsByTagName('footer')[0].style.display='none'",
                      );
                    });
                  },

              ),
            )
          ],
        ),
      ),
    );
  }
}
