import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'userProvider.dart';

class SettingType {
  final bool isNsfw,
      isNightMode,
      isTrackable,
      isNotifyPrivateMessage,
      isNotifyUpVote,
      isNotifyRequestChat,
      isNotifyNewFollower,
      isShowPresence,
      isShowTopSubreddit;

  SettingType(
      {required this.isNsfw,
      required this.isNightMode,
      required this.isTrackable,
      required this.isNotifyPrivateMessage,
      required this.isNotifyUpVote,
      required this.isNotifyRequestChat,
      required this.isNotifyNewFollower,
      required this.isShowPresence,
      required this.isShowTopSubreddit});

  factory SettingType.fromJson(Map<String, dynamic> json) {
    return new SettingType(
        isNsfw: json['over_18'],
        isNightMode: json['nightmode'],
        isTrackable: json['enable_followers'],
        isNotifyPrivateMessage: json['email_private_message'],
        isNotifyUpVote: json['email_upvote_comment'],
        isNotifyRequestChat: json['email_chat_request'],
        isNotifyNewFollower: json['email_user_new_follower'],
        isShowPresence: json['show_presence'],
        isShowTopSubreddit: json['top_karma_subreddits']);
  }
}

class SettingsProfilPage extends StatefulWidget {
  const SettingsProfilPage({Key? key}) : super(key: key);
  @override
  State<SettingsProfilPage> createState() => SettingsProfilPageState();
}

class SettingsProfilPageState extends State<SettingsProfilPage> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Editer le profil'),
        backgroundColor: Color.fromARGB(255, 255, 69, 0),
      ),
      body: ListView(
        children: <Widget>[
          Card(
            child: ListTile(
              leading: Icon(Icons.explicit_sharp,
                  size: 40, color: Color.fromARGB(255, 255, 69, 0)),
              title: Text('NSFW'),
              subtitle: Text('Afficher le contenu pour adulte +18'),
              trailing: Switch(
                value: user.settings.isNsfw,
                onChanged: (bool newValue) {
                  user.setSettingUser({"over_18": !user.settings.isNsfw});
                },
              ),
            ),
          ),
          Card(
            child: ListTile(
              leading: Icon(Icons.people_outlined,
                  size: 40, color: Color.fromARGB(255, 255, 69, 0)),
              title: Text('Afficher les communautés actives'),
              subtitle: Text(
                  'Afficher les communautés avec lesquelles vous interragissez sur votre profil'),
              trailing: Switch(
                value: user.settings.isShowTopSubreddit,
                onChanged: (bool newValue) {
                  user.setSettingUser({
                    "top_karma_subreddits": !user.settings.isShowTopSubreddit
                  });
                },
              ),
            ),
          ),
          Card(
              child: ListTile(
            leading: Icon(Icons.person_add_disabled_outlined,
                size: 40, color: Color.fromARGB(255, 255, 69, 0)),
            title: Text('Autoriser les gens à vous suivre'),
            subtitle: Text(
                'Les followers seront informés de vos nouvelles publication'),
            trailing: Switch(
              value: user.settings.isTrackable,
              onChanged: (bool newValue) {
                user.setSettingUser(
                    {"enable_followers": !user.settings.isTrackable});
              },
            ),
          )),
          Card(
              child: ListTile(
            leading: Icon(Icons.email,
                size: 40, color: Color.fromARGB(255, 255, 69, 0)),
            title: Text('Etre notifié par e-mail lors message privé'),
            trailing: Switch(
              value: user.settings.isNotifyPrivateMessage,
              onChanged: (bool newValue) {
                user.setSettingUser({
                  "email_private_message": !user.settings.isNotifyPrivateMessage
                });
              },
            ),
          )),
          Card(
              child: ListTile(
            leading: Icon(Icons.email,
                size: 40, color: Color.fromARGB(255, 255, 69, 0)),
            title: Text("Etre notifié par e-mail lors d'un upvote"),
            trailing: Switch(
              value: user.settings.isNotifyUpVote,
              onChanged: (bool newValue) {
                user.setSettingUser(
                    {"email_upvote_comment": !user.settings.isNotifyUpVote});
              },
            ),
          )),
          Card(
              child: ListTile(
            leading: Icon(Icons.email,
                size: 40, color: Color.fromARGB(255, 255, 69, 0)),
            title: Text("Etre notifié par e-mail lors d'une demande de chat"),
            trailing: Switch(
              value: user.settings.isNotifyRequestChat,
              onChanged: (bool newValue) {
                user.setSettingUser(
                    {"email_chat_request": !user.settings.isNotifyRequestChat});
              },
            ),
          )),
          Card(
              child: ListTile(
            leading: Icon(Icons.email,
                size: 40, color: Color.fromARGB(255, 255, 69, 0)),
            title: Text(
                "Etre notifié par e-mail lors de l'abonnement d'un nouveau abonné"),
            trailing: Switch(
              value: user.settings.isNotifyNewFollower,
              onChanged: (bool newValue) {
                user.setSettingUser({
                  "email_user_new_follower": !user.settings.isNotifyNewFollower
                });
              },
            ),
          )),
          Card(
            child: ListTile(
              leading: Icon(Icons.supervised_user_circle,
                  size: 40, color: Color.fromARGB(255, 255, 69, 0)),
              title: Text('Montrer votre status'),
              subtitle: Text(
                  'Si vous activez se mode, vos amis sauront si vou êtes connecté.'),
              trailing: Switch(
                value: user.settings.isShowPresence,
                onChanged: (bool newValue) {
                  user.setSettingUser(
                      {"show_presence": !user.settings.isShowPresence});
                },
              ),
            ),
          ),
        ],
      ),
      backgroundColor: Colors.grey.shade800,
    );
  }
}
