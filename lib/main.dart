import 'package:flutter/material.dart';
import 'package:redditech/mainPage.dart';
import 'auth.dart';
import 'ProfilPage.dart';

void main() {
  runApp(
    MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => MyAuthentication(),
        '/main': (context) => MyMainPage(),
        '/profil': (context) => ProfilPage(),
      },
    ),
  );
}
