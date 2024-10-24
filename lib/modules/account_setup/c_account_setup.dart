import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:spend_wise/_servies/network_services/api_endpoint.dart';
import 'package:spend_wise/modules/account_setup/v_setup_done.dart';

import '../../_common/data/data_controller.dart';

class AccountSetupController extends GetxController {
  DataController dataController = Get.find();
  TextEditingController txtAmount = TextEditingController();
  TextEditingController txtName = TextEditingController();
  ValueNotifier<String?> selectedType = ValueNotifier(null);
  String type = '';
  String subType = '';

  ValueNotifier<bool> xShowBank = ValueNotifier(false);
  ValueNotifier<bool> xShowMobileBank = ValueNotifier(false);

  ValueNotifier<bool> bankKBZ = ValueNotifier(false);
  ValueNotifier<bool> bankAYA = ValueNotifier(false);
  ValueNotifier<bool> bankYoma = ValueNotifier(false);
  ValueNotifier<bool> bankCB = ValueNotifier(false);
  ValueNotifier<bool> bankAGD = ValueNotifier(false);
  ValueNotifier<bool> bankOther = ValueNotifier(false);

  ValueNotifier<bool> kPay = ValueNotifier(false);
  ValueNotifier<bool> wavePay = ValueNotifier(false);
  ValueNotifier<bool> okDollar = ValueNotifier(false);
  ValueNotifier<bool> cbMobile = ValueNotifier(false);

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  void checkType(String? selected) {
    clearAllControl();
    txtName.clear();

    if (selected == 'Wallet') {
      txtName.text = "Wallet";
      subType = 'WALLET';
      xShowMobileBank.value = false;
      xShowBank.value = false;
    } else if (selected == 'Bank') {
      xShowMobileBank.value = false;
      xShowBank.value = true;
    } else if (selected == 'Mobile Banking') {
      xShowMobileBank.value = true;
      xShowBank.value = false;
    }
  }

  void checkAllField() {
    if (txtAmount.text.isEmpty) {
      maxMessageDialog('Please Enter Balance.');
    } else if (txtName.text.isEmpty) {
      maxMessageDialog('Please Enter Name.');
    } else if (selectedType.value == null) {
      maxMessageDialog('Please Select Account Type.');
    } else if (subType == '') {
      maxMessageDialog('Please Select Account Sub Type.');
    }
  }

  void proceedToSave() {
    checkAllField();
    if (txtAmount.text.isNotEmpty &&
        txtName.text.isNotEmpty &&
        selectedType.value != null &&
        subType != '') {
      saveAccount();
    }
  }

  Future<void> saveAccount() async {
    getType();

    String url = ApiEndpoint.baseUrl2 + ApiEndpoint.account;

    GetConnect client = GetConnect(timeout: const Duration(seconds: 10));
    try {
      Get.dialog(const Center(
        child: CircularProgressIndicator(),
      ));

      final response = await client.post(
        url,
        {
          "name": txtName.text,
          "type": type,
          "subType": subType,
          "balance": int.tryParse(txtAmount.text) ?? -1,
        },
        headers: {
          'Authorization': 'Bearer ${dataController.apiToken}',
          'Content-Type': 'application/json',
        },
      );

      Get.back();
      if (response.isOk) {
        print(response.body['_metadata']['message'].toString());
        Get.offAll(() => const SetupDone());
      } else {
        print(response.body['_metadata']['message'].toString());
        maxSuccessDialog(
            response.body['_metadata']['message'].toString(), false);
      }
    } catch (e1) {}
  }

  void getType() {
    switch (selectedType.value) {
      case 'Wallet':
        type = 'WALLET';
      case 'Bank':
        type = 'BANK';
      case 'Mobile Banking':
        type = 'PAY';
    }
  }

  void clearAllControl() {
    subType = '';
    bankKBZ.value = false;
    bankAYA.value = false;
    bankYoma.value = false;
    bankCB.value = false;
    bankAGD.value = false;
    bankOther.value = false;

    kPay.value = false;
    wavePay.value = false;
    okDollar.value = false;
    cbMobile.value = false;
  }

  void controlBankList(String name, bool value) {
    if (name == 'KBZBANK') {
      bankKBZ.value = !value;
      txtName.text = value ? '' : 'KBZ Bank - ';
      subType = value ? '' : 'KBZBANK';
      bankAYA.value = false;
      bankYoma.value = false;
      bankCB.value = false;
      bankAGD.value = false;
      bankOther.value = false;
    } else if (name == 'AYABANK') {
      bankKBZ.value = false;
      bankAYA.value = !value;
      txtName.text = value ? '' : 'AYA Bank - ';
      subType = value ? '' : 'AYABANK';
      bankYoma.value = false;
      bankCB.value = false;
      bankAGD.value = false;
      bankOther.value = false;
    } else if (name == 'YOMABANK') {
      bankKBZ.value = false;
      bankAYA.value = false;
      bankYoma.value = !value;
      txtName.text = value ? '' : 'Yoma Bank - ';
      subType = value ? '' : 'YOMABANK';
      bankCB.value = false;
      bankAGD.value = false;
      bankOther.value = false;
    } else if (name == 'CBBANK') {
      bankKBZ.value = false;
      bankAYA.value = false;
      bankYoma.value = false;
      bankCB.value = !value;
      txtName.text = value ? '' : 'CB Bank - ';
      subType = value ? '' : 'CBBANK';
      bankAGD.value = false;
      bankOther.value = false;
    } else if (name == 'AGDBANK') {
      bankKBZ.value = false;
      bankAYA.value = false;
      bankYoma.value = false;
      bankCB.value = false;
      bankAGD.value = !value;
      txtName.text = value ? '' : 'AGD Bank - ';
      subType = value ? '' : 'AGDBANK';
      bankOther.value = false;
    } else if (name == 'OTHERBANK') {
      bankKBZ.value = false;
      bankAYA.value = false;
      bankYoma.value = false;
      bankCB.value = false;
      bankAGD.value = false;
      bankOther.value = !value;
      txtName.text = value ? '' : 'Other - ';
      subType = value ? '' : 'OTHER';
    }
  }

  void controlMobileBankList(String name, bool value) {
    if (name == "KPAY") {
      kPay.value = !value;
      txtName.text = value ? '' : 'KBZ Pay - ';
      subType = value ? '' : 'KBZPAY';
      wavePay.value = false;
      okDollar.value = false;
      cbMobile.value = false;
    } else if (name == "WAVEPAY") {
      kPay.value = false;
      wavePay.value = !value;
      txtName.text = value ? '' : 'Wave Pay - ';
      subType = value ? '' : 'WAVEPAY';
      okDollar.value = false;
      cbMobile.value = false;
    } else if (name == "AYA Pay") {
      kPay.value = false;
      wavePay.value = false;
      okDollar.value = false;
      cbMobile.value = !value;
      txtName.text = value ? '' : 'AYA Pay - ';
      subType = value ? '' : 'AYAPAY';
    } else if (name == "OKDOLLAR") {
      kPay.value = false;
      wavePay.value = false;
      okDollar.value = !value;
      txtName.text = value ? '' : 'OK\$ - ';
      subType = value ? '' : 'OKDOLLAR';
      cbMobile.value = false;
    }
  }
}
