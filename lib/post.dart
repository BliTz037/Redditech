import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'utils.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'userProvider.dart';

class PostType {
  final String title, permalink, author, nbComments, url, ups, subreddit;
  final bool isSelf, isVideo;
  final double created;
  final String urlVideo;
  final String selftext;
  final String statusVote;
  final String nameVote;

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
      required this.selftext,
      required this.statusVote,
      required this.nameVote});

  factory PostType.fromJson(Map<String, dynamic> json) {
    String urlVideo = "";

    if (json['data']['secure_media'] != null &&
        json['data']['secure_media'].containsKey('reddit_video'))
      urlVideo = json['data']['secure_media']['reddit_video']['fallback_url'];

    return new PostType(
      title: json['data']!['title'],
      permalink: json['data']!['permalink'],
      author: json['data']!['author'],
      nbComments: json['data']!['num_comments'].toString(),
      url: json['data']!['url'],
      ups: json['data']!['ups'].toString(),
      created: json['data']!['created'],
      subreddit: json['data']!['subreddit'],
      isSelf: json['data']!['is_self'],
      isVideo: json['data']!['is_video'],
      urlVideo: urlVideo,
      selftext: json['data']!['selftext'] ?? "",
      statusVote: json['data']!['likes'].toString(),
      nameVote: json['data']!['name'],
    );
  }
}

class InteractPost extends StatelessWidget {
  final PostType postType;

  InteractPost({required this.postType});
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);
    print("statusVote ===>" +
        postType.statusVote.toString() +
        "  && name ===> " +
        postType.nameVote);
    return Row(
      children: <Widget>[
        IconButton(
          icon: const Icon(Icons.arrow_upward),
          color: postType.statusVote == "true" ? Colors.red : Colors.grey,
          onPressed: () async {
            if (postType.statusVote == "true") {
              user.postVote(postType.nameVote, "0");
            } else {
              user.postVote(postType.nameVote, "1");
            }
          },
        ),
        Text(postType.ups),
        IconButton(
          icon: const Icon(Icons.arrow_downward_sharp),
          color: postType.statusVote == "false" ? Colors.red : Colors.grey,
          onPressed: () async {
            if (postType.statusVote == "false") {
              user.postVote(postType.nameVote, "0");
            } else {
              user.postVote(postType.nameVote, "-1");
            }
          },
        ),
        IconButton(
          icon: const Icon(Icons.chat_bubble_outline),
          color: Colors.grey,
          onPressed: () {
            print("COMMENT");
          },
        ),
        Text(postType.nbComments),
        IconButton(
          icon: const Icon(Icons.share),
          color: Colors.grey,
          onPressed: () {
            Share.share("https://www.reddit.com" + postType.permalink);
          },
        ),
        Text("Share"),
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
              child: InkWell(
                child: Text("Ouvrir le lien", style: TextStyle(decoration: TextDecoration.underline, color: Colors.blue, fontSize: 20)),
                onTap: () => launch(postType.url)
                ),
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
              subtitle:
                  Text('u/${postType.author} | ${getTime(postType.created)}')),
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
          getContent(),
          const Divider(
            height: 0,
            thickness: 0.5,
            indent: 0,
            endIndent: 0,
          ),
          InteractPost(postType: postType)
        ]));
  }
}
