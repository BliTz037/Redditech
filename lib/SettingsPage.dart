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
          OptionsButton("Apparence", "Changer l'apparence de l'app",
              Icons.app_registration, "/profil"),
          OptionsButton(
              "Crédits",
              "Dédicace au groupe 'Reddit en 1000 fois mieux'",
              Icons.group_sharp,
              "/credit"),
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.all(10),
            width: double.infinity,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10)),
            child: ListTile(
              leading: Icon(
                Icons.mode_night,
                color: Color.fromARGB(255, 255, 69, 0),
                size: 40.0,
              ),
              title: Text("NightMode", style: TextStyle(color: Colors.black)),
              subtitle: Column(children: [
                Text(
                  "Si tu as un minimum de race tu va en dark theme",
                  style: TextStyle(color: Colors.black54),
                ),
                Padding(
                    padding: EdgeInsets.all(20),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Color.fromARGB(255, 255, 69, 0),
                          textStyle: const TextStyle(fontSize: 12)),
                      onPressed: () {
                        user.setSettingUser(
                            {"nightmode": !user.settings.isNightMode});
                      },
                      child: Text((user.settings.isNightMode) ? 'On' : 'Off'),
                    ))
              ]),
            ),
          ),
        ],
      ),
      backgroundColor: user.settings.isNightMode
          ? Colors.grey.shade800
          : Colors.grey.shade100,
    );
  }
}
