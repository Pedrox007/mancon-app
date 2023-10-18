import 'package:http/http.dart' as http;
import 'package:mancon_app/utils/base_api.dart';
import 'package:mancon_app/utils/endpoints.dart';

class ExpenseTypeService extends BaseAPI {
  Future<http.Response> getExpenseTypes() async {
    http.Response response = await super.request(
      http.get,
      super.getURL(Endpoints.expenseType, null, null),
      null,
    );

    return response;
  }
}
