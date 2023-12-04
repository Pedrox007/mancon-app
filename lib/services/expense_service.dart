import 'dart:convert';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:http/http.dart' as http;
import 'package:mancon_app/utils/base_api.dart';
import 'package:mancon_app/utils/endpoints.dart';
import 'package:path/path.dart' as p;
import 'package:uuid/uuid.dart';

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
    File? voucherFile,
    String? voucherFileType,
  }) async {
    String? imageURL;
    String? fileId;

    if (voucherFile != null) {
      final ref = FirebaseStorage.instance.ref(
        "mancon_app/${expense["owner_id"]}",
      );
      String fileExtension = p.extension(voucherFile.path);
      fileId = const Uuid().v1();
      final fileRef = ref.child("$fileId.$fileExtension");

      await fileRef.putFile(voucherFile).whenComplete(
        () async {
          var url = await fileRef.getDownloadURL();
          imageURL = url.toString();
        },
      );
    }

    if (imageURL != null) {
      expense.addAll({
        "voucher_file_url": imageURL,
        "voucher_file_id": fileId,
        "voucher_file_type": voucherFileType,
      });
    }

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

  Future<http.Response> editExpense({
    required Map<String, dynamic> expense,
    File? voucherFile,
    String? voucherFileType,
    String? voucherFileId,
    bool voucherFileEdited = false,
    String? voucherCurrentFileUrl,
    required int id,
  }) async {
    String? imageURL;

    if (voucherFileEdited) {
      Map<String, dynamic> fileFields = {
        "voucher_file_url": null,
        "voucher_file_id": null,
        "voucher_file_type": null,
      };

      if (voucherFile != null) {
        final ref = FirebaseStorage.instance.ref(
          "mancon_app/${expense["owner_id"]}",
        );
        String fileExtension = p.extension(voucherFile.path);
        voucherFileId ??= const Uuid().v1();
        final fileRef = ref.child("$voucherFileId.$fileExtension");

        await fileRef.putFile(voucherFile).whenComplete(
          () async {
            var url = await fileRef.getDownloadURL();
            imageURL = url.toString();
            fileFields.addAll({
              "voucher_file_url": imageURL,
              "voucher_file_id": voucherFileId,
              "voucher_file_type": voucherFileType,
            });
          },
        );
      } else if (voucherFile == null && voucherCurrentFileUrl != null) {
        FirebaseStorage.instance.refFromURL(voucherCurrentFileUrl).delete();
      }

      expense.addAll(fileFields);
    }

    var body = jsonEncode(expense);

    http.Response response = await super.request(
      http.patch,
      super.getURL(
        Endpoints.expenses,
        id,
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
