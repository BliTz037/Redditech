import 'package:flutter/material.dart';
import 'userProvider.dart';
import 'package:provider/provider.dart';
import 'utils.dart';

class MyDrawerHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);
    return DrawerHeader(
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.5), BlendMode.dstATop),
            image: AssetImage('images/redditHeader.png'),
          ),
          color: Colors.black,
        ),
        child: Stack(
          children: <Widget>[
            Align(
                alignment: Alignment.centerLeft,
                child: CircleAvatar(
                  backgroundColor: Color.fromARGB(255, 255, 69, 0),
                  radius: 50.0,
                  backgroundImage: NetworkImage(user.icon.length == 0
                      ? "https://www.net-aware.org.uk/siteassets/images-and-icons/application-icons/app-icons-reddit.png?w=585&scale=down"
                      : setParseImage(user.icon)),
                )),
            Align(
              alignment: Alignment.centerRight + Alignment(-0.3, 0),
              child: Text(
                'u/${user.username}',
                style: TextStyle(color: Colors.white, fontSize: 20.0),
              ),
            ),
            Align(
              alignment: Alignment.centerRight + Alignment(-0.4, 0.5),
              child: Text(
                '${user.karma} karma',
                style: TextStyle(color: Colors.white, fontSize: 15.0),
              ),
            )
          ],
        ));
  }
}

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(padding: EdgeInsets.zero, children: <Widget>[
      MyDrawerHeader(),
      ListTile(
          leading: Icon(Icons.account_circle_rounded,
              color: Color.fromARGB(255, 255, 69, 0)),
          onTap: () {
            Navigator.popAndPushNamed(context, "/profil");
          },
          title: const Text("Profil")),
      ListTile(
          leading: Icon(Icons.developer_mode,
              color: Color.fromARGB(255, 255, 69, 0)),
          onTap: () {
            Navigator.popAndPushNamed(context, "/subreddit");
          },
          title: const Text("Subreddit DEV")),

      ListTile(
          leading: Icon(Icons.developer_mode,
              color: Color.fromARGB(255, 255, 69, 0)),
          onTap: () {
            Navigator.popAndPushNamed(context, "/tab");
          },
          title: const Text("Tab DEV")),

      ListTile(
          leading: Icon(Icons.settings, color: Color.fromARGB(255, 255, 69, 0)),
          onTap: () {
            Navigator.popAndPushNamed(context, "/settings");
          },
          title: const Text("Paramètres")),
      ListTile(
          leading:
              Icon(Icons.exit_to_app, color: Color.fromARGB(255, 255, 69, 0)),
          title: const Text("Déconnexion")),
    ]));
  }
}
