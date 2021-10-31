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

  Widget projectWidget(String tag) {
    final user = Provider.of<UserProvider>(context);
    return FutureBuilder(
        future: user.fetchSubreddits(tag),
        builder: (context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          } else {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                PostType project = snapshot.data![index];
                return Posts(postType: project);
              },
            );
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);

    return DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Redditech'),
            backgroundColor: Color.fromARGB(255, 255, 69, 0),
            bottom: TabBar(
              tabs: [
                Tab(icon: Icon(Icons.favorite)),
                Tab(
                  icon: Icon(Icons.local_fire_department_sharp),
                ),
                Tab(icon: Icon(Icons.new_releases))
              ],
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.manage_search),
                color: Colors.white,
                iconSize: 30,
                onPressed: () {
                  Navigator.pushNamed(context, '/searchSub');
                },
              ),
            ],
          ),
          drawer: MyDrawer(),
          body: TabBarView(
            children: [
              projectWidget(""),
              projectWidget("/hot"),
              projectWidget("/new"),
            ],
          ),
          backgroundColor:
              user.nightMode ? Colors.grey.shade800 : Colors.grey.shade100,
        ));
  }
}
