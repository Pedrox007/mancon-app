import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mancon_app/utils/endpoints.dart';
import 'package:mancon_app/utils/secure_storage.dart';

class BaseAPI {
  static String baseURL = const String.fromEnvironment(
    "MANCON_API_BASE_URL",
    defaultValue: "",
  );
  Map<String, String> headers = {
    "Content-Type": "application/json",
  };

  Uri getURL(String endpointURL, int? id, Map<String, dynamic>? queryParams) {
    String idLookup = id != null ? "${id.toString()}/" : "";

    Uri url = Uri.parse(
      baseURL + endpointURL + idLookup,
    ).replace(
      queryParameters: queryParams,
    );

    return url;
  }

  Future<bool> renewToken() async {
    bool success = false;
    String refreshToken = await SecureStorage().readSecureData("refresh_token");

    var body = jsonEncode({
      "refresh": refreshToken,
    });

    http.Response response = await http.post(
      getURL(Endpoints.tokenRefresh, null, null),
      body: body,
      headers: headers,
    );

    if (response.statusCode == 200) {
      String token = jsonDecode(response.body)["access"];
      updateAuthorization(token);
      SecureStorage().writeSecureData("access_token", token);
      success = true;
    }

    return success;
  }

  Future<http.Response> request(Function method, Uri url, String? body) async {
    http.Response response;

    if (body != null) {
      response = await method(url, body: body, headers: headers);
    } else {
      response = await method(url, headers: headers);
    }

    if (response.statusCode == 401) {
      bool refreshSuccess = await renewToken();

      if (refreshSuccess) {
        if (body != null) {
          response = await method(url, body: body, headers: headers);
        } else {
          response = await method(url, headers: headers);
        }
      }
    }

    return response;
  }

  void updateAuthorization(String token) {
    headers["Authorization"] = "Bearer $token";
  }
}
