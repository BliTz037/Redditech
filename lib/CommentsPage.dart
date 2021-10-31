import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'userProvider.dart';
import 'Comment.dart';

class CommentsPage extends StatefulWidget {
  const CommentsPage({Key? key}) : super(key: key);
  @override
  State<CommentsPage> createState() => CommentsPageState();
}

class CommentsPageState extends State<CommentsPage> {
  @override
  Widget build(BuildContext context) {
    Widget projectWidget() {
      final user = Provider.of<UserProvider>(context);
      return FutureBuilder(
          future: user.fetchCommentsPost(),
          builder: (context, AsyncSnapshot snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            } else {
              return ListView.builder(
                physics: ScrollPhysics(),
                shrinkWrap: true,
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  CommentType project = snapshot.data![index];
                  return Comments(commentType: project);
                },
              );
            }
          });
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Commentaires'),
        backgroundColor: Color.fromARGB(255, 255, 69, 0),
      ),
      body: ListView(
        children: <Widget>[projectWidget()],
      ),
      backgroundColor: Colors.grey.shade800,
    );
  }
}
