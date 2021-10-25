import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class UserProvider with ChangeNotifier {
  String token = "";

  void setToken(String ntoken) {
    token = ntoken;
    notifyListeners();
  }

  Future<Response<Map>> fetchPost() async {
    Response<Map> response = await Dio().get(
      'https://oauth.reddit.com/api/v1/me',
      options: Options(headers: {"Authorization": "bearer $token"}),
    );
    if (response.statusCode == 200) {
      return response;
    } else {
      throw Exception('Failed to load post');
    }
  }
}
