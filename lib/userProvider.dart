import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

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

  Future<List<Map<String, dynamic>>> fetchSubreddits() async {
    final response = await Dio().get(
      'https://oauth.reddit.com/',
      options: Options(headers: {"Authorization": "bearer $token"}),
    );
    if (response.statusCode == 200) {
      notifyListeners();
      return (response.data);
    } else {
      throw Exception('Failed to load User');
    }
  }
}
