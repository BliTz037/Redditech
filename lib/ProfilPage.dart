import 'package:flutter/material.dart';
import 'post.dart';
import 'drawer.dart';
import 'package:provider/provider.dart';
import 'userProvider.dart';
import 'package:dio/dio.dart';

class ProfilPage extends StatefulWidget {
  const ProfilPage({Key? key}) : super(key: key);
  @override
  State<ProfilPage> createState() => ProfilPageState();
}

class ProfilPageState extends State<ProfilPage> {
  int _selectedIndex = 0;
  var user;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: Home',
      style: optionStyle,
    ),
    Text(
      'Index 1: Add post',
      style: optionStyle,
    ),
    Text(
      'Index 2: Settings',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    user = Provider.of<UserProvider>(context);
    user.fetchPost().then((val) {
      print("val ==>" + val);
    });
    return Scaffold(
      appBar: AppBar(
        title: const Text('Redditech'),
        backgroundColor: Color.fromARGB(255, 255, 69, 0),
      ),
      drawer: MyDrawer(),
      body: ListView(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            height: 100,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.fill,
                image: NetworkImage(
                    "https://pbs.twimg.com/media/D-jnKUPU4AE3hVR.jpg"),
              ),
            ),
          ),
          Container(
            color: Colors.white,
            height: 150,
            child: Stack(children: [
              Align(
                alignment: Alignment.topLeft + Alignment(0.05, -1),
                child: CircleAvatar(
                    radius: 45,
                    backgroundColor: Color.fromARGB(255, 255, 69, 0),
                    child: CircleAvatar(
                      radius: 40.0,
                      backgroundImage:
                          NetworkImage('https://i.ibb.co/hLnvQWQ/images.jpg'),
                    )),
              ),
              Align(
                alignment: Alignment.topLeft + Alignment(0.8, 0.2),
                child: Text(
                  'test',
                  style: TextStyle(color: Colors.black, fontSize: 20.0),
                ),
              ),
              Align(
                alignment: Alignment.bottomLeft + Alignment(1.05, -1.4),
                child: Text(
                  '6747 karma • 3 ans • 4 juil. 2018',
                  style: TextStyle(color: Colors.black54, fontSize: 12.0),
                ),
              ),
              Align(
                alignment: Alignment(30, 0.2),
                child: Text(
                  'Le train de tes injures roule sur le rail de mon indifférence - George Abitbol',
                  style: TextStyle(color: Colors.black54, fontSize: 12.0),
                ),
              ),
            ]),
          ),
          Posts("Phillipe"),
        ],
      ),
      backgroundColor: Colors.grey.shade800,
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Post',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Color.fromARGB(255, 255, 69, 0),
        onTap: _onItemTapped,
      ),
    );
  }
}
