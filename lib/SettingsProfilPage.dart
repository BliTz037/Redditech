import 'package:flutter/material.dart';

class SettingsProfilPage extends StatefulWidget {
  const SettingsProfilPage({Key? key}) : super(key: key);
  @override
  State<SettingsProfilPage> createState() => SettingsProfilPageState();
}

class SettingsProfilPageState extends State<SettingsProfilPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editer le profil'),
        backgroundColor: Color.fromARGB(255, 255, 69, 0),
      ),
      body: ListView(
        children: <Widget>[
          Card(
            child: ListTile(
              leading: Icon(Icons.explicit_sharp,
                  size: 40, color: Color.fromARGB(255, 255, 69, 0)),
              title: Text('NSFW'),
              subtitle: Text('Afficher le contenu pour adulte +18'),
              trailing: Switch(
                value: false,
                onChanged: (bool newValue) {},
              ),
            ),
          ),

          Card(
            child: ListTile(
              leading: Icon(Icons.people_outlined,
                  size: 40, color: Color.fromARGB(255, 255, 69, 0)),
              title: Text('Afficher les communautés actives'),
              subtitle: Text('Afficher les communautés avec lesquelles vous interragissez sur votre profil'),
              trailing: Switch(
                value: false,
                onChanged: (bool newValue) {},
              ),
            ),
          ),
          Card(
            child: ListTile(
              leading: Icon(Icons.person_add_disabled_outlined,
                  size: 40, color: Color.fromARGB(255, 255, 69, 0)),
              title: Text('Autoriser les gens à vous suivre'),
              subtitle: Text('Les followers seront informés de vos nouvelles publication'),
              trailing: Switch(
                value: false,
                onChanged: (bool newValue) {},
              ),
            )
          ),

          Card(
            child: ListTile(
              leading: Icon(Icons.email,
                  size: 40, color: Color.fromARGB(255, 255, 69, 0)),
              title: Text('Etre notifié par e-mail'),
              subtitle: Text('Un e-mail sera envoyé pour vous informer d\'un évènement'),
              trailing: Switch(
                value: false,
                onChanged: (bool newValue) {},
              ),
            )
          ),

          Card(
            child: ListTile(
              leading: Icon(Icons.question_answer_outlined,
                  size: 40, color: Color.fromARGB(255, 255, 69, 0)),
              title: Text('Autoriser les messages privés'),
              trailing: Switch(
                value: false,
                onChanged: (bool newValue) {},
              ),
            ),
          ),
        ],
      ),
      backgroundColor: Colors.grey.shade800,
    );
  }
}
