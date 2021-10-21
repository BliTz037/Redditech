import 'package:flutter/material.dart';
import 'dart:io';
import 'package:webview_flutter/webview_flutter.dart';

class MyAuthentication extends StatefulWidget {
  @override
  MyAuthenticationState createState() => MyAuthenticationState();
}

class MyAuthenticationState extends State<MyAuthentication> {
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  var client = "K3u2sTJJTa6xgZqSYGYTGg";
  String accessToken = "";
  Widget build(BuildContext context) {
    return WebView(
        onPageStarted: (str) => Navigator.pushNamed(context, '/main'),
        initialUrl:
            'https://www.reddit.com/api/v1/authorize.compact?client_id=$client&response_type=token&state=daazdjpazjpdjze&redirect_uri=https://127.0.0.1/&scope=identity',
        navigationDelegate: (NavigationRequest request) {
          var str = request.url;
          const start = "access_token=";
          const end = "&";
          final startIndex = str.indexOf(start);
          final endIndex = str.indexOf(end, startIndex + start.length);
          accessToken = str.substring(startIndex + start.length, endIndex);
          Navigator.pushNamed(context, '/main');
          return NavigationDecision.navigate;
        });
  }
}
