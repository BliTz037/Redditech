import 'package:flutter/material.dart';
import 'package:redditech/mainPage.dart';
import 'package:provider/provider.dart';
import 'test.dart';
import 'SubredditPage.dart';
import 'SettingsPage.dart';
import 'auth.dart';
import 'userProvider.dart';

void main() {
  // runApp(MaterialApp(
  //     initialRoute: '/',
  //     routes: {
  //       '/': (context) => MyAuthentication(),
  //       '/main': (context) => MyMainPage(),
  //     },
  //   ),)
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ChangeNotifierProvider(
          create: (_) => UserProvider(), child: const MyRoute()),
    );
  }
}

class MyRoute extends StatelessWidget {
  const MyRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => MyAuthentication(),
        '/main': (context) => MyMainPage(),
        '/profil': (context) => ProfilPage(),
        '/subreddit': (context) => SubredditPage(),
        '/settings': (context) => SettingsPage()
      },
    );
  }
}
