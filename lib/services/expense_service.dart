import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mancon_app/utils/base_api.dart';
import 'package:mancon_app/utils/endpoints.dart';

class ExpenseService extends BaseAPI {
  Future<http.Response> getExpenses({required int ownerId}) async {
    Map<String, dynamic> queryParams = {"owner_id": ownerId.toString()};

    http.Response response = await super.request(
      http.get,
      super.getURL(
        Endpoints.expenses,
        null,
        queryParams,
      ),
      null,
    );

    return response;
  }

  Future<http.Response> createExpense({
    required Map<String, dynamic> expense,
  }) async {
    var body = jsonEncode(expense);

    http.Response response = await super.request(
      http.post,
      super.getURL(
        Endpoints.expenses,
        null,
        null,
      ),
      body,
    );

    return response;
  }

  Future<http.Response> deleteExpense({required int id}) async {
    http.Response response = await super.request(
      http.delete,
      super.getURL(
        Endpoints.expenses,
        id,
        null,
      ),
      null,
    );

    return response;
  }
}
