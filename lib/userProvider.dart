import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:redditech/post.dart';

class UserProvider with ChangeNotifier {
  String token = "";
  String username = "";
  String icon = "";
  int karma = 0;
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

  Future<List<PostType>> fetchSearchSubreddits() async {
    final response = await Dio().get(
      'https://oauth.reddit.com/subreddits/search/?q=',
      options: Options(headers: {"Authorization": "bearer $token"}),
    );
    var listPost = response.data!['data']!['children'] as List;
    if (response.statusCode == 200) {
      notifyListeners();
      return listPost.map<PostType>((post) => PostType.fromJson(post)).toList();
    } else {
      throw Exception('Failed to load User');
    }
  }

  Future<List<PostType>> fetchSubreddits() async {
    print("Hello request");
    final response = await Dio().get(
      'https://oauth.reddit.com/hot',
      options: Options(headers: {"Authorization": "bearer $token"}),
    );
    var listPost = response.data!['data']!['children'] as List;
    if (response.statusCode == 200) {
      notifyListeners();
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
    print(response.data);
    if (response.statusCode == 200) {
      notifyListeners();
      return;
    } else {
      throw Exception('Failed to load User');
    }
  }
}
