import 'dart:async';
import 'post.dart';
import 'drawer.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:provider/provider.dart';
import 'userProvider.dart';
import 'utils.dart';

Future<Map<String, dynamic>> fetchUser(String token) async {
  final response = await Dio().get(
    'https://oauth.reddit.com/api/v1/me',
    options: Options(headers: {"Authorization": "bearer $token"}),
  );
  if (response.statusCode == 200) {
    print(response.data);
    return (response.data);
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load User');
  }
}

// Future<Map<String, dynamic>> fetchUser(String token) async {
//   final response =
//       await Dio().get('https://jsonplaceholder.typicode.com/albums/1');

//   if (response.statusCode == 200) {
//     print(response.data);
//     return (response.data);
//   } else {
//     // If the server did not return a 200 OK response,
//     // then throw an exception.
//     throw Exception('Failed to load User');
//   }
// }

class ProfilPage extends StatefulWidget {
  const ProfilPage({Key? key}) : super(key: key);

  @override
  _ProfilPageState createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {
  var token = "";
  @override
  void initState() {
    super.initState();
    fetchUser(token);
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);
    token = user.token;
    return FutureBuilder<Map<String, dynamic>>(
      future: fetchUser(token),
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
                            backgroundImage: NetworkImage(
                                setParseImage(snapshot.data!['icon_img'])),
                          )),
                    ),
                    Align(
                      alignment: Alignment.topLeft + Alignment(0.8, 0.2),
                      child: Text(
                        snapshot.data!['name'],
                        style: TextStyle(color: Colors.black, fontSize: 20.0),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomLeft + Alignment(1.05, -1.4),
                      child: Text(
                        '${snapshot.data!['total_karma']} karma • 3 ans • 4 juil. 2018',
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
              // currentIndex: _selectedIndex,
              selectedItemColor: Color.fromARGB(255, 255, 69, 0),
              // onTap: _onItemTapped,
            ),
          );
          // Text(snapshot.data!["name"]);
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }

        // By default, show a loading spinner.
        return const CircularProgressIndicator();
      },
    );
  }
}
