import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'userProvider.dart';

class CreditsPage extends StatefulWidget {
  const CreditsPage({Key? key}) : super(key: key);
  @override
  State<CreditsPage> createState() => CreditsPageState();
}

class CreditsPageState extends State<CreditsPage> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Crédits'),
        backgroundColor: Color.fromARGB(255, 255, 69, 0),
      ),
      body: ListView(
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(10),
            child: Text(
              "Cette applicaction a été développé par l'équipe :",
              style: TextStyle(
                  fontSize: 17,
                  color:
                      user.settings.isNightMode ? Colors.white : Colors.black),
              textAlign: TextAlign.center,
            ),
          ),
          Container(
            margin: EdgeInsets.all(10),
            child: Text(
              "Reddit en 1000 fois mieux",
              style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 255, 69, 0)),
              textAlign: TextAlign.center,
            ),
          ),
          Card(
              child: ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage('images/blitz.jpg'),
              radius: 30,
            ),
            title: Text('Tom'),
            subtitle:
                Text('Front-end (Ta jamais vu une app aussi joli, avoue le !)'),
            isThreeLine: true,
          )),
          Card(
              child: ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage('images/thomas.png'),
              radius: 30,
            ),
            title: Text('Thomas'),
            subtitle: Text("Back-end (L'API reddit est une merveille !)"),
            isThreeLine: true,
          )),
        ],
      ),
      backgroundColor: user.settings.isNightMode
          ? Colors.grey.shade800
          : Colors.grey.shade100,
    );
  }
}
