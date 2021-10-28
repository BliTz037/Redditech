import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'utils.dart';

class PostType {
  final String title, permalink, author, nbComments, url, ups, subreddit;
  final bool isSelf, isVideo;
  final double created;
  final String urlVideo;
  final String selftext;

  PostType(
      {required this.title,
      required this.permalink,
      required this.author,
      required this.nbComments,
      required this.created,
      required this.url,
      required this.ups,
      required this.subreddit,
      required this.isSelf,
      required this.isVideo,
      required this.urlVideo,
      required this.selftext});

  factory PostType.fromJson(Map<String, dynamic> json) {
    String urlVideo = "";

    if (json['data']['secure_media'] != null && json['data']['secure_media'].containsKey('reddit_video'))
      urlVideo = json['data']['secure_media']['reddit_video']['fallback_url'];

    return new PostType(
        title: json['data']['title'].toString(),
        permalink: json['data']['permalink'].toString(),
        author: json['data']['author'].toString(),
        nbComments: json['data']['num_comments'].toString(),
        url: json['data']['url'].toString(),
        ups: json['data']['ups'].toString(),
        created: json['data']['created'],
        subreddit: json['data']['subreddit'].toString(),
        isSelf: json['data']['is_self'],
        isVideo: json['data']['is_video'],
        urlVideo: urlVideo,
        selftext: json['data']!['selftext'] ?? "");
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
  final PostType postType;

  Posts({required this.postType});

  Widget getContent() {
    print("Création");
    if (!postType.isSelf) {
      if (postType.isVideo) {
        return Container(
          margin: const EdgeInsets.all(10),
          child: Text("Insert videolink ${postType.urlVideo}"),
        );
      }
      if (postType.url.contains("https://i.redd.it/")) {
        return Container(
            margin: const EdgeInsets.all(10),
            child: Image.network(
              postType.url,
              errorBuilder: (BuildContext context, Object exception,
                  StackTrace? stackTrace) {
                return const Text('Cannot load this image');
              },
            ));
      } else {
        return Container(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Text(postType.url),
            ));
      }
    }
    return Container(
        alignment: Alignment.bottomLeft,
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Text(postType.selftext),
        ));
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
              title: Text('r/' + postType.subreddit),
              subtitle: Text('u/${postType.author} | ${getTime(postType.created)}')),
          Container(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Text(postType.title,
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
          // Container(
          //     margin: const EdgeInsets.all(10),
          //     child: Image.network(
          //       postType.url,
          //       errorBuilder: (BuildContext context, Object exception,
          //           StackTrace? stackTrace) {
          //         return const Text('Cannot load this image');
          //       },
          //     )),
          getContent(),
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
