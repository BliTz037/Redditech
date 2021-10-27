import 'package:flutter/material.dart';
import 'package:share/share.dart';

class PostType {
  final String title, permalink, author, nbComments, url, ups, subreddit;

  PostType({
    required this.title,
    required this.permalink,
    required this.author,
    required this.nbComments,
    required this.url,
    required this.ups,
    required this.subreddit,
  });

  factory PostType.fromJson(Map<String, dynamic> json) {
    return new PostType(
      title: json['data']['title'].toString(),
      permalink: json['data']['permalink'].toString(),
      author: json['data']['author'].toString(),
      nbComments: json['data']['num_comments'].toString(),
      url: json['data']['url'].toString(),
      ups: json['data']['ups'].toString(),
      subreddit: json['data']['subreddit'].toString(),
    );
  }
}

class InteractPost extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        IconButton(
          icon: const Icon(Icons.arrow_upward),
          color: Colors.red,
          onPressed: () {
            print("UP");
          },
        ),
        Text("31.7k"),
        IconButton(
          icon: const Icon(Icons.arrow_downward_sharp),
          color: Colors.red,
          onPressed: () {
            print("DOWN");
          },
        ),
        IconButton(
          icon: const Icon(Icons.chat_bubble_outline),
          color: Colors.grey,
          onPressed: () {
            print("DOWN");
          },
        ),
        Text("94"),
        IconButton(
          icon: const Icon(Icons.share),
          color: Colors.grey,
          onPressed: () {
            Share.share("https://www.youtube.com/watch?v=1oegwxUIrkc");
          },
        ),
        Text("Share"),
        // GestureDetector(
        //   onTap: () { print("Share");},
        // )
      ],
    );
  }
}

class Posts extends StatelessWidget {
  var _user;

  Posts.empty() {
    this._user = "Unknown";
  }

  Posts(var name) {
    this._user = name;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        margin: EdgeInsets.all(15),
        child: Column(children: <Widget>[
          ListTile(
              //leading: FlutterLogo(),
              //leading: CircleAvatar(backgroundColor: Colors.brown.shade800, child: const Text('X')),
              leading: CircleAvatar(
                  backgroundImage: NetworkImage(
                      "https://www.journaldugeek.com/content/uploads/2021/03/xbox-1.jpg")),
              title: Text('r/' + _user),
              subtitle: Text('u/jsbibatea | 6d')),
          Container(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: EdgeInsets.all(10),
                child: const Text("You're pretty good !",
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 18)),
              )),
          const Divider(
            height: 0,
            thickness: 0.5,
            indent: 0,
            endIndent: 0,
          ),
          // Container(
          //     alignment: Alignment.bottomLeft,
          //     child: Padding(
          //       padding: EdgeInsets.all(10),
          //       child: const Text(
          //           'A l\'issue de débats souvent électriques, l\'Assemblée nationale a donné dans la nuit du mercredi 20 au jeudi 21 octobre, un premier feu vert au projet de loi "vigilance sanitaire", avec la possibilité de recourir au pass sanitaire jusqu\'au 31 juillet 2022.'),
          //     )),
          Container(
            margin: const EdgeInsets.all(10),
            child: Image(
                image: NetworkImage('https://i.redd.it/5ap6kaz58mu71.png')),
          ),
          const Divider(
            height: 0,
            thickness: 0.5,
            indent: 0,
            endIndent: 0,
          ),
          InteractPost()
        ]));
  }
}
