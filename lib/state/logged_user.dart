import 'package:flutter/material.dart';
import 'package:mancon_app/models/user.dart';
import 'package:mancon_app/utils/mocked_data.dart';

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
      _user = MockData().user;
    } else {
      _user = User.fromMap({"id": 1, "username": username});
    }
    notifyListeners();
  }

  void logout() {
    _user = null;
    notifyListeners();
  }
}
