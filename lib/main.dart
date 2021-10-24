import 'package:flutter/material.dart';
import 'package:redditech/mainPage.dart';
import 'auth.dart';
import 'ProfilPage.dart';
import 'SubredditPage.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => MyAuthentication(),
        '/main': (context) => MyMainPage(),
        '/profil': (context) => ProfilPage(),
        '/subreddit': (context) => SubredditPage(),
      },
    ),
  );
}
