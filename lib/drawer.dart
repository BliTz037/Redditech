import 'package:flutter/material.dart';

class MyDrawerHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DrawerHeader(
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.5), BlendMode.dstATop),
            image: NetworkImage(
                'https://digitalmediaknowledge.com/wp-content/uploads/2020/02/Reddit-Header-1.png'),
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
                  backgroundImage:
                      NetworkImage('https://i.ibb.co/hLnvQWQ/images.jpg'),
                )),
            Align(
              alignment: Alignment.centerRight + Alignment(-0.3, 0),
              child: Text(
                'u/BliTz_37',
                style: TextStyle(color: Colors.white, fontSize: 25.0),
              ),
            ),
            Align(
              alignment: Alignment.centerRight + Alignment(-0.4, 0.5),
              child: Text(
                '14545 karma',
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
            // Update the state of the app
            // ...
            // Then close the drawer
            //Navigator.pop(context);
            Navigator.popAndPushNamed(context, "/profil");
          },
          title: const Text("Profil")),
      ListTile(
          leading: Icon(Icons.settings, color: Color.fromARGB(255, 255, 69, 0)),
          title: const Text("Paramètres")),
      ListTile(
          leading:
              Icon(Icons.exit_to_app, color: Color.fromARGB(255, 255, 69, 0)),
          title: const Text("Déconnexion")),
    ]));
  }
}
