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

void getAccessToken(String code) async {
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
  }
  Response<Map> res = await dio.get(
    'https://oauth.reddit.com/api/v1/me',
    options: Options(
        headers: {"Authorization": "bearer ${response.data?['access_token']}"}),
  );
  print(res.data);
}

class MyAuthenticationState extends State<MyAuthentication> {
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  var client = "K3u2sTJJTa6CounterxgZqSYGYTGg";
  Widget build(BuildContext context) {
    // final user = Provider.of<UserProvider>(context);
    return WebView(
        initialUrl:
            'https://www.reddit.com/api/v1/authorize.compact?client_id=$client&response_type=code&state=RANDOM_STRING&redirect_uri=https://127.0.0.1/&duration=permanent&scope=identity,edit,flair,history,modconfig,modflair,modlog,modposts,modwiki,mysubreddits,privatemessages,read,report,save,submit,subscribe,vote,wikiedit,wikiread',
        onPageStarted: (String url) {
          if (url.contains("error")) {
            Navigator.pushNamed(context, '/');
            return;
          }
          var str = url;
          print(url);
          const start = "code=";
          const end = "#";
          final startIndex = str.indexOf(start);
          final endIndex = str.indexOf(end, startIndex + start.length);
          final code = str.substring(startIndex + start.length, endIndex);
          getAccessToken(code);
          // user.setToken("yo");

          // print("le user ==> " + user.token);
          Navigator.pushNamed(context, '/main');
        });
  }
}
