import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:redditech/SettingsProfilPage.dart';
import 'package:redditech/post.dart';
import 'package:redditech/Comment.dart';
import 'searchSub.dart';

class UserProvider with ChangeNotifier {
  String token = "";
  String username = "";
  String icon = "";
  int karma = 0;
  String subSearched = "";
  String commentsSelected = "";
  SettingType settings = SettingType(
      isNsfw: false,
      isNightMode: false,
      isTrackable: false,
      isNotifyPrivateMessage: false,
      isNotifyUpVote: false,
      isNotifyRequestChat: false,
      isNotifyNewFollower: false,
      isShowPresence: false,
      isShowTopSubreddit: false);

  SearchSubType subSelected = SearchSubType(
      title: "title",
      name: "name",
      communityIcon: "communityIcon",
      nbMembers: "nbMembers",
      description: "description",
      banner: "banner",
      isSubscribe: "false");

  Future<void> setSettingUser(Map<String, dynamic> params) async {
    final response = await Dio().patch(
        'https://oauth.reddit.com/api/v1/me/prefs',
        options: Options(
            responseType: ResponseType.json,
            contentType: 'application/json',
            headers: {
              "Authorization": "bearer $token",
            }),
        data: json.encode(params));
    settings = SettingType.fromJson(response.data);
    notifyListeners();
  }

  void setcommentsSelected(String permalink) {
    commentsSelected = permalink;
    notifyListeners();
  }

  void setSubSearched(String searched) {
    subSearched = searched;
    notifyListeners();
  }

  void setSubSelected(SearchSubType sub) {
    subSelected = sub;
    notifyListeners();
  }

  void setToken(String ntoken) {
    token = ntoken;
    notifyListeners();
  }

  Future<SettingType> fetchUserSettings() async {
    final response = await Dio().get(
      'https://oauth.reddit.com/api/v1/me/prefs',
      options: Options(headers: {"Authorization": "bearer $token"}),
    );
    if (response.statusCode == 200) {
      settings = SettingType.fromJson(response.data);
      notifyListeners();
      return SettingType.fromJson(response.data);
    } else {
      throw Exception('Failed to load Settings');
    }
  }

  Future<Map<String, dynamic>> fetchUserDetails() async {
    final response = await Dio().get(
      'https://oauth.reddit.com/api/v1/me',
      options: Options(headers: {"Authorization": "bearer $token"}),
    );
    if (response.statusCode == 200) {
      username = response.data!['name'];
      karma = response.data!["total_karma"];
      icon = response.data!['icon_img'];
      notifyListeners();
      return (response.data);
    } else {
      throw Exception('Failed to load User');
    }
  }

  Future<List<SearchSubType>> fetchSearchSubreddits() async {
    var response = await Dio().get(
      'https://oauth.reddit.com/subreddits/${subSearched.length == 0 ? "" : "search/?q=$subSearched"}',
      options: Options(headers: {"Authorization": "bearer $token"}),
    );
    if (response.statusCode == 200) {
      var listPost = response.data!['data']['children'] as List;
      return listPost
          .map<SearchSubType>((subReddit) => SearchSubType.fromJson(subReddit))
          .toList();
    } else {
      throw Exception('Failed to load User');
    }
  }

  Future<List<CommentType>> fetchCommentsPost() async {
    var response = await Dio().get(
      'https://oauth.reddit.com/$commentsSelected',
      queryParameters: {"limit": "100"},
      options: Options(headers: {"Authorization": "bearer $token"}),
    );
    if (response.statusCode == 200) {
      var listPost = response.data[1]!['data']['children'] as List;
      return listPost
          .map<CommentType>((comments) => CommentType.fromJson(comments))
          .toList();
    } else {
      throw Exception('Failed to load comments');
    }
  }

  Future<List<PostType>> fetchSubreddits(String tag) async {
    final response = await Dio().get(
      'https://oauth.reddit.com$tag',
      queryParameters: {"limit": "100"},
      options: Options(headers: {"Authorization": "bearer $token"}),
    );
    if (response.statusCode == 200) {
      var listPost = response.data!['data']!['children'] as List;
      return listPost.map<PostType>((post) => PostType.fromJson(post)).toList();
    } else {
      throw Exception('Failed to load User');
    }
  }

  void postVote(String name, String statusVote) async {
    final response = await Dio().post(
      'https://oauth.reddit.com/api/vote/?id=$name&dir=$statusVote',
      options: Options(headers: {"Authorization": "bearer $token"}),
    );
    if (response.statusCode == 200) {
      notifyListeners();
      return;
    } else {
      throw Exception('Failed to load User');
    }
  }

  void setSubscribeSub(String status) async {
    final response = await Dio().post('https://oauth.reddit.com/api/subscribe/',
        options: Options(headers: {
          "Authorization": "bearer $token",
          'Content-Type': 'application/x-www-form-urlencoded'
        }),
        data: {"action": status, "sr_name": "r/" + subSelected.name});
    if (response.statusCode == 200) {
      if (subSelected.isSubscribe == "true") {
        subSelected.isSubscribe = "false";
      } else {
        subSelected.isSubscribe = "true";
      }
      notifyListeners();
      return;
    } else {
      throw Exception('Failed to load User');
    }
  }
}
