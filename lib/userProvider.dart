import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:redditech/post.dart';
import 'searchSub.dart';

class UserProvider with ChangeNotifier {
  String token = "";
  String username = "";
  String icon = "";
  int karma = 0;
  String subSearched = "";

  void setSubSearched(String searched) {
    subSearched = searched;
    notifyListeners();
  }

  void setToken(String ntoken) {
    token = ntoken;
    notifyListeners();
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
    print(subSearched);
    var response = await Dio().get(
      'https://oauth.reddit.com/subreddits/${subSearched.length == 0 ? "" : "search/?q=$subSearched"}',
      options: Options(headers: {"Authorization": "bearer $token"}),
    );
    print(response.data);
    if (response.statusCode == 200) {
      var listPost = response.data!['data']['children'] as List;
      return listPost
          .map<SearchSubType>((subReddit) => SearchSubType.fromJson(subReddit))
          .toList();
    } else {
      throw Exception('Failed to load User');
    }
  }

  Future<List<PostType>> fetchSubreddits(String tag) async {
    final response = await Dio().get(
      'https://oauth.reddit.com$tag',
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
}
