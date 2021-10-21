import 'package:flutter/material.dart';
import 'package:redditech/mainPage.dart';
import 'auth.dart';

void main() {
  runApp(
    MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => MyAuthentication(),
        '/main': (context) => MyMainPage(),
      },
    ),
  );
}
