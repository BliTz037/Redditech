import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class UserProvider with ChangeNotifier {
  String token = "";

  void setToken(String ntoken) {
    token = ntoken;
    notifyListeners();
  }
}
