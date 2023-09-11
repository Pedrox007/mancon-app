import 'package:flutter/material.dart';
import 'package:mancon_app/models/user.dart';

class LoggedUser with ChangeNotifier {
  User? _user;

  User? get user {
    return _user;
  }

  void setUser(User user) {
    _user = user;
  }

  void setMockedUser({String username = "teste"}) {
    if (username.isEmpty) {
      _user = User.fromMap({"username": "teste"});
    } else {
      _user = User.fromMap({"username": username});
    }
  }

  void logout() {
    _user = null;
    notifyListeners();
  }
}
