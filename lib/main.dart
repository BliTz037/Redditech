import 'package:flutter/material.dart';
import 'mainPage.dart';
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
