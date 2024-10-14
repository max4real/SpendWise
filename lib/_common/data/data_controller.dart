import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spend_wise/_servies/theme_services/d_dark_theme.dart';

class DataController extends GetxController {
  String apiToken = '';
  String spToken = '';
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    initLoad();
  }

  void initLoad() {
    getToken();
  }

  Future<void> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    if (token != null) {
      spToken = token;
    } else {
      spToken = "";
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
  List<String> accSubType = [
    'KBZ Bank',
    'KBZ Pay',
    'Wallet',
  ];
  String getImage(String name) {
    if (name == "KBZ Bank") {
      return 'assets/images/logo/KBZ_Bank_logo.png';
    } else if (name == "AYA Bank") {
      return 'assets/images/logo/AYA_Bank_logo.png';
    } else if (name == "Yoma Bank") {
      return 'assets/images/logo/yoma_bank_logo.jpg';
    } else if (name == "CB Bank") {
      return 'assets/images/logo/cb_bank_logo.png';
    } else if (name == "AGD Bank") {
      return 'assets/images/logo/AGD.png';
    } else if (name == "Other") {
      return 'assets/images/reset_mail.png';
    } else if (name == "KBZ Pay") {
      return 'assets/images/logo/k_pay.png';
    } else if (name == "Wave Pay") {
      return 'assets/images/logo/wave_pay.png';
    } else if (name == "CB Mobile Banking") {
      return 'assets/images/logo/CB.png';
    } else if (name == "OK\$") {
      return 'assets/images/logo/ok_dollar.png';
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
