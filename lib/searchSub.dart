import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'userProvider.dart';
import 'utils.dart';

class SearchSubType {
  String title,
      communityIcon,
      name,
      nbMembers,
      description,
      banner,
      isSubscribe;

  SearchSubType(
      {required this.title,
      required this.name,
      required this.communityIcon,
      required this.nbMembers,
      required this.description,
      required this.isSubscribe,
      required this.banner});

  factory SearchSubType.fromJson(Map<String, dynamic> json) {
    return new SearchSubType(
      isSubscribe: json['data']!['user_is_subscriber'].toString(),
      banner: (json['data']['banner_img'] ?? ""),
      name: json['data']!['display_name'] ?? "",
      communityIcon: json['data']!['community_icon'] ?? "",
      title: json['data']!['title'] ?? "",
      nbMembers: json['data']!['subscribers'].toString(),
      description: json['data']!['public_description'] ?? "",
    );
  }
}

class SearchSub extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);

    return new Scaffold(
      appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 255, 69, 0),
          title: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (value) {
                user.setSubSearched(value);
              },
              decoration: InputDecoration(
                labelText: "Search",
                hintText: "Search",
                fillColor: Colors.black,
                prefixIcon: Icon(Icons.search),
              ),
            ),
          )),
      body: Container(
        child: Column(
          children: <Widget>[
            Expanded(
              child: FutureBuilder(
                  future: user.fetchSearchSubreddits(),
                  builder: (context, AsyncSnapshot snapshot) {
                    if (!snapshot.hasData) {
                      return Center(child: CircularProgressIndicator());
                    } else {
                      return ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) {
                          SearchSubType project = snapshot.data![index];
                          return Column(children: <Widget>[
                            ListTile(
                                onTap: () {
                                  user.setSubSelected(project);
                                  Navigator.popAndPushNamed(
                                      context, "/subreddit");
                                },
                                leading: CircleAvatar(
                                    backgroundImage: NetworkImage(project
                                                .communityIcon.length ==
                                            0
                                        ? "https://blog.lastpass.com/wp-content/uploads/sites/20/2020/04/reddit-logo-2.jpg"
                                        : setParseImage(
                                            project.communityIcon))),
                                title: Text('r/' + project.name),
                                subtitle: Text('${project.nbMembers} members')),
                            const Divider(
                              height: 0,
                              thickness: 0.5,
                              indent: 0,
                              endIndent: 0,
                            ),
                          ]);
                        },
                      );
                    }
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
