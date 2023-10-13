import 'dart:convert';

import 'package:mancon_app/utils/base_api.dart';
import 'package:http/http.dart' as http;
import 'package:mancon_app/utils/endpoints.dart';

class UserService extends BaseAPI {
  Future<http.Response> getToken(String username, String password) async {
    String body = jsonEncode({"username": username, "password": password});

    http.Response response = await http.post(
        super.getURL(Endpoints.token, null),
        body: body,
        headers: super.headers);

    return response;
  }

  Future<http.Response> getUser() async {
    http.Response response =
        await super.request(http.get, super.getURL(Endpoints.user, null), null);

    return response;
  }
}
