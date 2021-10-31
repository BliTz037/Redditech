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
          Text(
            "Cette applicaction a été développé par l'équipe : Reddit en 1000 fois mieux",
            style: TextStyle(fontSize: 32),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                child: Column(
                  children: [
                    CircleAvatar(
                      backgroundImage: AssetImage('images/blitz.jpg'),
                      radius: 50,
                    ),
                    Text("Tom"),
                    Text("Front-end (Ta jamais vu une app aussi joli, avoue le !)")
                  ],
                ),
              ),
              Container(
                  child: Column(
                children: [
                  CircleAvatar(
                    backgroundImage: AssetImage('images/thomas.png'),
                    radius: 50,
                  ),
                  Text("Thomas"),
                  Text("Back-end (L'API reddit est une merveille !)")
                ],
              )),
            ],
          )
        ],
      ),
      backgroundColor:
          user.nightMode ? Colors.grey.shade800 : Colors.grey.shade100,
    );
  }
}
