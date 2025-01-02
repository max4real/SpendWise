import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../_common/data/data_controller.dart';
import '../../../_servies/network_services/api_endpoint.dart';

class TransactionDetailsController extends GetxController {
  DataController dataController = Get.find();
  ValueNotifier<String> from = ValueNotifier("-");
  ValueNotifier<String> to = ValueNotifier("-");

  Future<void> fetchTransferDetails({required String transferGroupId}) async {
    String url =
        "${ApiEndpoint.baseUrl}${ApiEndpoint.transactionTransfer}/$transferGroupId";

    GetConnect client = GetConnect(timeout: const Duration(seconds: 30));

    try {
      final response = await client.get(
        url,
        headers: {
          'Authorization': 'Bearer ${dataController.apiToken}',
          'Content-Type': 'application/json',
        },
      );

      if (response.isOk) {
        from.value = response.body["transferOutTransaction"]["account"]
            ["accountSubType"];
        to.value = response.body["transferInTransaction"]["account"]
            ["accountSubType"];
      } else {
        print(response.body);
        maxSuccessDialog(response.body['message'].toString(), false);
      }
    } catch (e) {}
  }
}
