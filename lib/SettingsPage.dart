import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'userProvider.dart';

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
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, _redirect);
      },
      child: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.all(10),
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10)),
        child: ListTile(
          onTap: () {
            Navigator.pushNamed(context, _redirect);
          },
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
      ),
    );
  }
}

class SettingsState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Paramètres'),
        backgroundColor: Color.fromARGB(255, 255, 69, 0),
      ),
      body: ListView(
        children: <Widget>[
          OptionsButton("u/" + user.username, "Editer le profile",
              Icons.account_circle_outlined, "/settings/profil"),
          Card(
            margin: EdgeInsets.all(10),
            child: ListTile(
              leading: Icon(Icons.nightlight_round,
                  size: 40, color: Color.fromARGB(255, 255, 69, 0)),
              title: Text('NightMode'),
              subtitle: Text('Si tu as un minimum de race tu vas en dark theme'),
              trailing: Switch(
                value: user.settings.isNightMode,
                onChanged: (bool newValue) {
                  user.setSettingUser(
                      {"nightmode": !user.settings.isNightMode});
                },
              ),
            ),
          ),
          OptionsButton(
              "Crédits",
              "Dédicace au groupe 'Reddit en 1000 fois mieux'",
              Icons.group_sharp,
              "/credits"),
        ],
      ),
      backgroundColor: user.settings.isNightMode
          ? Colors.grey.shade800
          : Colors.grey.shade100,
    );
  }
}
