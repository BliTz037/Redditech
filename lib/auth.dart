import 'package:flutter/material.dart';
import 'dart:io';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:dio/dio.dart';
import 'package:provider/provider.dart';
import 'userProvider.dart';

class MyAuthentication extends StatefulWidget {
  @override
  MyAuthenticationState createState() => MyAuthenticationState();
}

Future<String> getAccessToken(String code) async {
  var dio = Dio();
  Response<Map> response = await dio.post(
      'https://K3u2sTJJTa6xgZqSYGYTGg:@www.reddit.com/api/v1/access_token',
      queryParameters: {
        "grant_type": "authorization_code",
        "code": code,
        "redirect_uri": "https://127.0.0.1/"
      });
  if (response.statusCode == 200) {
    print(response.data?['access_token']);
    return (response.data?['access_token']);
  }
  return "";
}

class MyAuthenticationState extends State<MyAuthentication> {
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  var client = "K3u2sTJJTa6xgZqSYGYTGg";
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);
    return WebView(
        initialUrl:
            // 'https://www.reddit.com/api/v1/authorize.compact?client_id=$client&response_type=code&state=RAS&redirect_uri=https://127.0.0.1/&duration=permanent&scope=identity+read+vote+subscribe',
            'https://www.reddit.com/api/v1/authorize.compact?client_id=$client&response_type=code&state=RAS&redirect_uri=https://127.0.0.1/&duration=permanent&scope=*',
        onPageStarted: (String url) {
          if (url.contains("error")) {
            Navigator.pushNamed(context, '/');
            return;
          }
          if (!url.contains("code=")) return;
          var str = url;
          const start = "code=";
          const end = "#";
          final startIndex = str.indexOf(start);
          final endIndex = str.indexOf(end, startIndex + start.length);
          final code = str.substring(startIndex + start.length, endIndex);
          getAccessToken(code).then((val) {
            user.setToken(val);
            user.fetchUserDetails();
            user.fetchUserSettings();
            Navigator.pushNamed(context, '/main');
          });
        });
  }
}
