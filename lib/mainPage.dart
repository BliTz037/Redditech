import 'package:flutter/material.dart';
import 'post.dart';
import 'drawer.dart';
import 'package:provider/provider.dart';
import 'userProvider.dart';

class MyMainPage extends StatefulWidget {
  const MyMainPage({Key? key}) : super(key: key);
  @override
  State<MyMainPage> createState() => MyMainPageState();
}

class MyMainPageState extends State<MyMainPage> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget projectWidget() {
    final user = Provider.of<UserProvider>(context);

    return FutureBuilder(
        future: user.fetchSubreddits(),
        builder: (context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          } else {
            return ListView.builder(
              itemCount: snapshot.data.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                PostType project = snapshot.data![index];
                return Text(project.title);
              },
            );
          }
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
      body: projectWidget(),
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
