import 'package:flutter/material.dart';
import 'post.dart';
import 'drawer.dart';

class ProfilPage extends StatefulWidget {
  const ProfilPage({Key? key}) : super(key: key);
  @override
  State<ProfilPage> createState() => ProfilPageState();
}

class ProfilPageState extends State<ProfilPage> {
  int _selectedIndex = 0;
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Redditech'),
        backgroundColor: Color.fromARGB(255, 255, 69, 0),
      ),
      drawer: MyDrawer(),
      body: ListView(
        padding: const EdgeInsets.all(10),
        children: <Widget>[
Container(
  padding: EdgeInsets.zero,
  width: MediaQuery.of(context).size.width,
  height: 100,
  decoration: BoxDecoration(
    image: DecorationImage(
      fit: BoxFit.fill,
      image: NetworkImage("https://pbs.twimg.com/media/D-jnKUPU4AE3hVR.jpg"),
    ),
  ),
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