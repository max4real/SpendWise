import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spend_wise/_servies/network_services/api_endpoint.dart';
import 'package:spend_wise/_servies/theme_services/d_dark_theme.dart';
import 'package:spend_wise/models/m_caetgory_model.dart';

import '../../models/m_account_model.dart';

class DataController extends GetxController {
  String apiToken = '';
  String spToken = '';
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    initLoad();
  }

  Future initLoad() async {
    getToken();
  }

  Future<void> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    if (token != null) {
      spToken = token;
      apiToken = token;
    } else {
      spToken = "";
      apiToken = "";
    }
  }

  List<String> categoryTags = [
    'Shopping',
    'Subscription',
    'Food',
    'Salary',
    'Transportation',
    'General Use',
    'Loan',
    'Borrow',
    'Other',
  ];

  List<String> accType = [
    'Wallet',
    'Bank',
    'Mobile Banking',
  ];

  //Get SubType list from Account List's subtype
  // List<String> accSubType = [
  //   // 'KBZ Bank',
  //   // 'KBZ Pay',
  //   // 'Wallet',
  // ];

  ValueNotifier<List<String>> accSubType = ValueNotifier([]);
  ValueNotifier<List<AccountModel>> accountList = ValueNotifier([]);

  Future<void> fetchAccountList() async {
    String url = ApiEndpoint.baseUrl2 + ApiEndpoint.account;
    GetConnect client = GetConnect(timeout: const Duration(seconds: 10));

    try {
      final response = await client.get(
        url,
        headers: {
          'Authorization': 'Bearer $apiToken',
          'Content-Type': 'application/json',
        },
      );

      if (response.isOk) {
        print(response.body['_metadata']['message']);
        List<AccountModel> temp = [];
        List<String> temp2 = [];

        Iterable iterable = response.body['_data'] ?? [];

        for (var element in iterable) {
          AccountModel rawData = AccountModel.fromAPI(data: element);
          temp.add(rawData);
          temp2.add(rawData.accSubType);
        }
        accountList.value = [...temp];
        accSubType.value = [...temp2];
      } else {
        print(response.body['_metadata']['message']);
        maxSuccessDialog(
            response.body['_metadata']['message'].toString(), false);
      }
    } catch (e) {}
  }

  ValueNotifier<List<String>> categoryListStr = ValueNotifier([]);
  ValueNotifier<List<CategoryModel>> categoryList = ValueNotifier([]);

  Future<void> fetchCategoryList() async {
    String url = ApiEndpoint.baseUrl2 + ApiEndpoint.category;
    GetConnect client = GetConnect(timeout: const Duration(seconds: 10));

    try {
      final response = await client.get(
        url,
        headers: {
          'Authorization': 'Bearer $apiToken',
          'Content-Type': 'application/json',
        },
      );

      if (response.isOk) {
        print(response.body['_metadata']['message']);
        List<CategoryModel> temp = [];
        List<String> temp2 = [];

        Iterable iterable = response.body['_data'] ?? [];

        for (var element in iterable) {
          CategoryModel rawData = CategoryModel.fromAPI(data: element);
          temp.add(rawData);
          temp2.add(rawData.categoryName);
        }
        categoryList.value = [...temp];
        categoryListStr.value = [...temp2];
        categoryListStr.value.sort((a, b) => a.compareTo(b));
      } else {
        print(response.body['_metadata']['message']);
        maxSuccessDialog(
            response.body['_metadata']['message'].toString(), false);
      }
    } catch (e) {}
  }

  String getImage(String name) {
    if (name == "KBZBANK") {
      return 'assets/images/logo/KBZ_Bank_logo.png';
    } else if (name == "AYABANK") {
      return 'assets/images/logo/AYA_Bank_logo.png';
    } else if (name == "YOMABANK") {
      return 'assets/images/logo/yoma_bank_logo.jpg';
    } else if (name == "CBBANK") {
      return 'assets/images/logo/cb_bank_logo.png';
    } else if (name == "AGDBANK") {
      return 'assets/images/logo/AGD.png';
    } else if (name == "OTHER") {
      ///-----
      return 'assets/images/reset_mail.png';
    } else if (name == "KBZPAY") {
      return 'assets/images/logo/k_pay.png';
    } else if (name == "WAVEPAY") {
      return 'assets/images/logo/wave_pay.png';
    } else if (name == "AYAPAY") {
      return 'assets/images/logo/AYA Pay.jpg';
    } else if (name == "OKDOLLAR") {
      return 'assets/images/logo/ok_dollar.png';
    } else if (name == 'WALLET') {
      ///----
      return "assets/images/logo/Wallet_logo.png";
    } else {
      return "assets/images/reset_mail.png";
    }
  }
}

void dismissKeyboard() {
  FocusManager.instance.primaryFocus?.unfocus();
}

String myFullDateTimeFormat(DateTime rawDate) {
  String formatDate = DateFormat("EEEE d MMMM y  hh:mm a").format(rawDate);
  return formatDate;
}

String myDateFormat(DateTime rawDate) {
  String formatDate = DateFormat("MMMM dd h:mm a").format(rawDate);
  return formatDate;
}

String myTimeFormat(DateTime rawDate) {
  String formatDate = DateFormat("h:mm a").format(rawDate);
  return formatDate;
}

void maxSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
}

void maxSuccessDialog(String message, bool type_) {
  Get.dialog(
    Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                color: type_ ? incomeColor : outcomeColor,
                shape: BoxShape.circle,
              ),
              child: type_
                  ? const Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 36,
                    )
                  : const Icon(
                      Icons.clear_rounded,
                      color: Colors.white,
                      size: 36,
                    ),
            ),
            const SizedBox(height: 16),
            Text(
              message,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    ),
    barrierDismissible: true,
  );
}

void maxSuccessDialog2(
  String message,
  bool type_,
  Function ok,
  String okButton,
  // Function cancle,
  // String cancleButton,
) {
  Get.dialog(
    Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                color: type_ ? incomeColor : outcomeColor,
                shape: BoxShape.circle,
              ),
              child: type_
                  ? const Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 36,
                    )
                  : const Icon(
                      Icons.clear_rounded,
                      color: Colors.white,
                      size: 36,
                    ),
            ),
            const SizedBox(height: 16),
            Text(
              message,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            // Row(
            //   children: [
            //     ElevatedButton(
            //       onPressed: () {
            //         cancle();
            //       },
            //       style: ElevatedButton.styleFrom(
            //         backgroundColor: background2,
            //         minimumSize: const Size(100, 30),
            //       ),
            //       child: Text(
            //         cancleButton,
            //         style: TextStyle(color: background, fontSize: 14),
            //       ),
            //     ),
            //     const Spacer(),
            //     ElevatedButton(
            //       onPressed: () {
            //         ok();
            //       },
            //       style: ElevatedButton.styleFrom(
            //         backgroundColor: background,
            //         minimumSize: const Size(100, 30),
            //       ),
            //       child: Text(
            //         okButton,
            //         style: TextStyle(color: text1, fontSize: 14),
            //       ),
            //     ),
            //   ],
            // )
            ElevatedButton(
              onPressed: () {
                ok();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: background,
                minimumSize: const Size(120, 35),
              ),
              child: Text(
                okButton,
                style: TextStyle(color: text1, fontSize: 14),
              ),
            ),
          ],
        ),
      ),
    ),
    barrierDismissible: false,
  );
}

void maxMessageDialog(String message) {
  Get.dialog(
    Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                color: transferColor,
                shape: BoxShape.circle,
              ),
              // child: const Icon(
              //   Icons.info,
              //   color: Colors.white,
              //   size: 36,
              // ),
              child: const Center(
                child: Text(
                  '!',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              message,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    ),
    barrierDismissible: true,
  );
}

String formatNumber(dynamic data) {
  var formatter = NumberFormat('#,##0');
  return formatter.format(data);
}
