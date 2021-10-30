import 'package:flutter/material.dart';
import 'drawer.dart';
import 'package:provider/provider.dart';
import 'userProvider.dart';
import 'utils.dart';
import 'post.dart';

class SubredditPage extends StatelessWidget {
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);
    Widget projectWidget(String tag) {
      final user = Provider.of<UserProvider>(context);
      return FutureBuilder(
          future: user.fetchSubreddits(tag),
          builder: (context, AsyncSnapshot snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            } else {
              return ListView.builder(
                physics: ScrollPhysics(),
                shrinkWrap: true,
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  PostType project = snapshot.data![index];
                  // return Text(project.title);
                  return Posts(postType: project);
                },
              );
            }
          });
    }

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
                fit: BoxFit.fitWidth,
                image: NetworkImage(user.subSelected.banner.length == 0
                    ? "https://www.ojim.fr/wp-content/uploads/2020/07/reddit-2020.jpg"
                    : user.subSelected.banner),
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
                        backgroundImage: NetworkImage(user
                                    .subSelected.communityIcon.length ==
                                0
                            ? "https://blog.lastpass.com/wp-content/uploads/sites/20/2020/04/reddit-logo-2.jpg"
                            : setParseImage(user.subSelected.communityIcon)))),
              ),
              Align(
                alignment: Alignment.topLeft + Alignment(0.8, 0.2),
                child: Text(
                  "r/" + user.subSelected.name,
                  style: TextStyle(color: Colors.black, fontSize: 18.0),
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
                alignment: Alignment.bottomLeft + Alignment(0.8, -1.4),
                child: Text(
                  '${user.subSelected.nbMembers} members',
                  style: TextStyle(color: Colors.black54, fontSize: 12.0),
                ),
              ),
              Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Align(
                    alignment: Alignment.centerLeft + Alignment(0, 0.2),
                    child: Text(
                      user.subSelected.description,
                      style: TextStyle(color: Colors.black54, fontSize: 12.0),
                    ),
                  )),
            ]),
          ),
          Container(
            child: projectWidget(
              "/r/" + user.subSelected.name,
            ),
          )
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
        selectedItemColor: Color.fromARGB(255, 255, 69, 0),
      ),
    );
  }
}
