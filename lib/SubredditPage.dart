import 'package:flutter/material.dart';
import 'post.dart';
import 'drawer.dart';

class SubredditPage extends StatefulWidget {
  const SubredditPage({Key? key}) : super(key: key);
  @override
  State<SubredditPage> createState() => SubredditPageState();
}

class SubredditPageState extends State<SubredditPage> {
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
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            height: 100,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.fill,
                image: NetworkImage(
                    "https://styles.redditmedia.com/t5_2r6ex/styles/bannerBackgroundImage_zxzfrfilp0n61.jpg"),
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
                      backgroundImage: NetworkImage(
                          'https://b.thumbs.redditmedia.com/JVxT4A3Lr5Zsj77i0rDxvl0p4FDQmESxwcsw47AZZPw.png'),
                    )),
              ),
              Align(
                alignment: Alignment.topLeft + Alignment(0.8, 0.2),
                child: Text(
                  'Evangelion',
                  style: TextStyle(color: Colors.black, fontSize: 20.0),
                ),
              ),
              Align(
                  alignment: Alignment.topRight + Alignment(-0.02, 0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Color.fromARGB(255, 255, 69, 0),
                        textStyle: const TextStyle(fontSize: 12)),
                    onPressed: () {},
                    child: const Text('Subscribe'),
                  )),
              Align(
                alignment: Alignment.bottomLeft + Alignment(1.05, -1.4),
                child: Text(
                  'r/evangelion • 172 972 small birds',
                  style: TextStyle(color: Colors.black54, fontSize: 12.0),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft + Alignment(0.1, 0.2),
                child: Text(
                  'God\'s in his heaven. All\'s right with the world.',
                  style: TextStyle(color: Colors.black54, fontSize: 12.0),
                ),
              ),
            ]),
          ),
          //Posts("Phillipe"),
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
