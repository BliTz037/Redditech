import 'package:flutter/material.dart';
import 'post.dart';
import 'package:provider/provider.dart';
import 'userProvider.dart';

class TabPage extends StatefulWidget {
  const TabPage({Key? key}) : super(key: key);
  @override
  State<TabPage> createState() => TabPageState();
}

class TabPageState extends State<TabPage> {
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
              itemBuilder: (context, index) {
                PostType project = snapshot.data![index];
                print(project.url);
                return Posts(postType: project);
              },
            );
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              tabs: [
                Tab(icon: Icon(Icons.favorite)),
                Tab(icon: Icon(Icons.local_fire_department_sharp)),
                Tab(icon: Icon(Icons.new_releases))
              ],
            ),
            title: const Text('TabBar test'),
          ),
          body: TabBarView(
            children: [
              projectWidget(),
              projectWidget(),
              projectWidget(),
            ],
          ),
        ));
  }
}
