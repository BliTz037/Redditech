import 'package:flutter/material.dart';

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
            print("DOWN");
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
  var _urlUserProfilePicture;
  var _subreddit;
  var _timestamp;
  var _title;
  var _textContent;
  var _urlImageContent;
  var _votesCounter;
  var _unvotesCounter;
  var _commentsCounter;
  var _urlPost;

  Posts.empty() {
    this._user = "Unknown";
    this._urlUserProfilePicture = "";
    this._subreddit = "Unknown";
    this._timestamp = 0;
    this._title = "Unknown";
    this._textContent = "";
    this._urlImageContent = "";
    this._votesCounter = 0;
    this._unvotesCounter = 0;
    this._commentsCounter = 0;
    this._urlPost = "localhost/";
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
