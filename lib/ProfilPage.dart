import 'post.dart';
import 'drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'userProvider.dart';
import 'utils.dart';

class ProfilPage extends StatefulWidget {
  const ProfilPage({Key? key}) : super(key: key);

  @override
  _ProfilPageState createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);
    return FutureBuilder<Map<String, dynamic>>(
      future: user.fetchUserDetails(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
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
                      image: NetworkImage(setParseImage(snapshot
                                  .data!['subreddit']["banner_img"].length ==
                              0
                          ? "https://www.ojim.fr/wp-content/uploads/2020/07/reddit-2020.jpg?"
                          : snapshot.data!['subreddit']["banner_img"])),
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
                                setParseImage(snapshot.data!['icon_img'])),
                          )),
                    ),
                    Align(
                      alignment: Alignment.topLeft + Alignment(0.8, 0.2),
                      child: Text(
                        "u/${snapshot.data!['name']}",
                        style: TextStyle(color: Colors.black, fontSize: 20.0),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomLeft + Alignment(1.05, -1.4),
                      child: Text(
                        '${snapshot.data!['total_karma']} karma • ${setTime(snapshot.data!['created'])}',
                        style: TextStyle(color: Colors.black54, fontSize: 12.0),
                      ),
                    ),
                    Align(
                      alignment: Alignment(0, 0.2),
                      child: Text(
                        snapshot.data!['subreddit']['public_description'],
                        style: TextStyle(color: Colors.black54, fontSize: 12.0),
                      ),
                    ),
                  ]),
                ),
                //Posts("Phillipe"),
              ],
            ),
            backgroundColor:
                user.nightMode ? Colors.grey.shade800 : Colors.grey.shade100,
          );
          // Text(snapshot.data!["name"]);
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }

        // By default, show a loading spinner.
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
