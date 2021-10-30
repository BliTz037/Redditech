import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);
  @override
  State<SettingsPage> createState() => SettingsState();
}

class OptionsButton extends StatelessWidget {
  var _title;
  var _subtitle;
  final IconData _icon;
  var _redirect;

  OptionsButton(var title, var subtitle, IconData icon, var redirect)
      : _icon = icon {
    this._title = title;
    this._subtitle = subtitle;
    this._redirect = redirect;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.all(10),
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        leading: Icon(
          _icon,
          color: Color.fromARGB(255, 255, 69, 0),
          size: 40.0,
        ),
        title: Text(_title, style: TextStyle(color: Colors.black)),
        subtitle: Text(
          _subtitle,
          style: TextStyle(color: Colors.black54),
        ),
      ),
    );
  }
}

class SettingsState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Paramètres'),
        backgroundColor: Color.fromARGB(255, 255, 69, 0),
      ),
      body: ListView(
        children: <Widget>[
          OptionsButton("u/BliTz_37", "Editer le profile",
              Icons.account_circle_outlined, "/editprofile"),
          OptionsButton("Apparence", "Changer l'apparence de l'app",
              Icons.app_registration, "/editappearance"),
          OptionsButton(
              "Crédits",
              "Dédicace au groupe 'Reddit en 1000 fois mieux'",
              Icons.group_sharp,
              "/credit"),
        ],
      ),
      backgroundColor: Colors.grey.shade800,
    );
  }
}
