import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'utils.dart';

class CommentType {
  final String author, ups, content, url;
  final double created;

  CommentType(
    {required this.author,
    required this.ups,
    required this.content,
    required this.url,
    required this.created});

  factory CommentType.fromJson(Map<String, dynamic> json) {
    return new CommentType(
      author: json['data']!['author'],
      ups: json['data']!['ups'].toString(),
      content: json['data']!['body'],
      url: json['data']!['permalink'],
      created: json['data']!['created']
    );
  }
}

class Comments extends StatelessWidget {

  final CommentType commentType;

  Comments({required this.commentType});

  @override
  Widget build(BuildContext context) {
    return Card(
        margin: EdgeInsets.all(5),
        child: Column(children: <Widget>[
          ListTile(
              leading: CircleAvatar(
                  backgroundImage: AssetImage('images/redditIcon.png')),
              title: Text('${commentType.author} | ${getTime(commentType.created)}'),
              ),
          Container(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Text(commentType.content,
                    style: const TextStyle()),
              )),
          const Divider(
            height: 0,
            thickness: 0.5,
            indent: 0,
            endIndent: 0,
          ),
          InteractComments(commentType: commentType,)
        ]));
  }
}
class InteractComments extends StatelessWidget {
  
  final CommentType commentType;

  InteractComments({required this.commentType});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        IconButton(
          icon: const Icon(Icons.arrow_upward),
          color: Colors.grey,
          onPressed: () async {},
        ),
        Text(commentType.ups),
        IconButton(
          icon: const Icon(Icons.arrow_downward_sharp),
          color: Colors.grey,
          onPressed: () async {},
        ),
        IconButton(
          icon: const Icon(Icons.share),
          color: Colors.grey,
          onPressed: () {
            Share.share("https://www.reddit.com${commentType.url}");
          },
        ),
        Text("Share"),
      ],
    );
  }
}