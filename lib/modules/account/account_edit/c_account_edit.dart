import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:spend_wise/models/m_account_model.dart';
import 'package:spend_wise/modules/account/account_detail/c_account_detail.dart';
import 'package:spend_wise/modules/account/c_account_list.dart';

import '../../../_common/data/data_controller.dart';
import '../../../_servies/network_services/api_endpoint.dart';

class AccountEditController extends GetxController {
  DataController dataController = Get.find();
  final FocusNode focusNode = FocusNode();
  String accId = '';
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
  ValueNotifier<bool> ayaPay = ValueNotifier(false);

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(Get.context!).requestFocus(focusNode);
    });
  }

  @override
  void onClose() {
    // Dispose the FocusNode to prevent memory leaks
    focusNode.dispose();
    super.onClose();
  }

  String getTypeName(String acctype) {
    switch (acctype) {
      case 'WALLET':
        return 'Wallet';
      case 'BANK':
        return 'Bank';
      case 'PAY':
        return 'Mobile Banking';
      default:
        return '';
    }
  }

  void initLoad(
    String id,
    int amount,
    String name,
    String accType,
    String accSubType,
  ) {
    accId = id;
    txtAmount.text = amount.toString();
    txtName.text = name;
    selectedType.value = getTypeName(accType);
    subType = accSubType;

    if (accType.isNotEmpty) {
      if (accType == 'WALLET') {
      } else if (accType == 'BANK') {
        xShowBank.value = true;
      } else if (accType == 'PAY') {
        xShowMobileBank.value = true;
      }
    }
    switch (accSubType) {
      case 'KBZBANK':
        bankKBZ.value = true;
      case 'AYABANK':
        bankAYA.value = true;
      case 'YOMABANK':
        bankYoma.value = true;
      case 'CBBANK':
        bankCB.value = true;
      case 'AGDBANK':
        bankAGD.value = true;
      case 'OTHER':
        bankOther.value = true;
      case 'KBZPAY':
        kPay.value = true;
      case 'WAVEPAY':
        wavePay.value = true;
      case 'AYAPAY':
        ayaPay.value = true;
      case 'OKDOLLAR':
        okDollar.value = true;
    }
  }

  void checkType(String? selected) {
    clearAllControl();
    txtName.clear();

    if (selected == 'Wallet') {
      txtName.text = "Wallet";
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

///// save ////
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
      editAccount();
    }
  }

  Future<void> editAccount() async {
    getType();
    printData();
    String url = '${ApiEndpoint.baseUrl2}${ApiEndpoint.account}/$accId';

    GetConnect client = GetConnect(timeout: const Duration(seconds: 10));
    try {
      Get.dialog(const Center(
        child: CircularProgressIndicator(),
      ));

      //Add Account ID here
      final response = await client.patch(
        url,
        {
          "name": txtName.text,
        },
        headers: {
          'Authorization': 'Bearer ${dataController.apiToken}',
          'Content-Type': 'application/json',
        },
      );

      Get.back();
      if (response.isOk) {
        print(response.body['_metadata']['message'].toString());

        AccountDetailController accountDetailController = Get.find();
        accountDetailController.accName.value = txtName.text;

        AccountListController accountListController = Get.find();
        List<AccountModel> temp = accountListController.accountList.value;
        for (var element in temp) {
          if (element.accId == accId) {
            element.accName = txtName.text;
          }
        }
        accountListController.accountList.value = [...temp];

        Get.back();
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
///// save ////

  void printData() {
    print(accId);
    print(txtAmount.text);
    print(txtName.text);
    print(type);
    print(subType);
  }

  void clearAllControl() {
    bankKBZ.value = false;
    bankAYA.value = false;
    bankYoma.value = false;
    bankCB.value = false;
    bankAGD.value = false;
    bankOther.value = false;

    kPay.value = false;
    wavePay.value = false;
    okDollar.value = false;
    ayaPay.value = false;
  }

  void controlBankList(String name, bool value) {
    // if (name == 'KBZBANK') {
    //   bankKBZ.value = !value;
    //   txtName.text = value ? '' : 'KBZ Bank - ';
    //   subType = value ? '' : 'KBZBANK';
    //   bankAYA.value = false;
    //   bankYoma.value = false;
    //   bankCB.value = false;
    //   bankAGD.value = false;
    //   bankOther.value = false;
    // } else if (name == 'AYABANK') {
    //   bankKBZ.value = false;
    //   bankAYA.value = !value;
    //   txtName.text = value ? '' : 'AYA Bank - ';
    //   subType = value ? '' : 'AYABANK';
    //   bankYoma.value = false;
    //   bankCB.value = false;
    //   bankAGD.value = false;
    //   bankOther.value = false;
    // } else if (name == 'YOMABANK') {
    //   bankKBZ.value = false;
    //   bankAYA.value = false;
    //   bankYoma.value = !value;
    //   txtName.text = value ? '' : 'Yoma Bank - ';
    //   subType = value ? '' : 'YOMABANK';
    //   bankCB.value = false;
    //   bankAGD.value = false;
    //   bankOther.value = false;
    // } else if (name == 'CBBANK') {
    //   bankKBZ.value = false;
    //   bankAYA.value = false;
    //   bankYoma.value = false;
    //   bankCB.value = !value;
    //   txtName.text = value ? '' : 'CB Bank - ';
    //   subType = value ? '' : 'CBBANK';
    //   bankAGD.value = false;
    //   bankOther.value = false;
    // } else if (name == 'AGDBANK') {
    //   bankKBZ.value = false;
    //   bankAYA.value = false;
    //   bankYoma.value = false;
    //   bankCB.value = false;
    //   bankAGD.value = !value;
    //   txtName.text = value ? '' : 'AGD Bank - ';
    //   subType = value ? '' : 'AGDBANK';
    //   bankOther.value = false;
    // } else if (name == 'OTHERBANK') {
    //   bankKBZ.value = false;
    //   bankAYA.value = false;
    //   bankYoma.value = false;
    //   bankCB.value = false;
    //   bankAGD.value = false;
    //   bankOther.value = !value;
    //   txtName.text = value ? '' : 'Other - ';
    //   subType = value ? '' : 'OTHER';
    // }
  }

  void controlMobileBankList(String name, bool value) {
    // if (name == "KPAY") {
    //   kPay.value = !value;
    //   txtName.text = value ? '' : 'KBZ Pay - ';
    //   subType = value ? '' : 'KBZPAY';
    //   wavePay.value = false;
    //   okDollar.value = false;
    //   ayaPay.value = false;
    // } else if (name == "WAVEPAY") {
    //   kPay.value = false;
    //   wavePay.value = !value;
    //   txtName.text = value ? '' : 'Wave Pay - ';
    //   subType = value ? '' : 'WAVEPAY';
    //   okDollar.value = false;
    //   ayaPay.value = false;
    // } else if (name == "AYA Pay") {
    //   kPay.value = false;
    //   wavePay.value = false;
    //   okDollar.value = false;
    //   ayaPay.value = !value;
    //   txtName.text = value ? '' : 'AYA Pay - ';
    //   subType = value ? '' : 'AYAPAY';
    // } else if (name == "OKDOLLAR") {
    //   kPay.value = false;
    //   wavePay.value = false;
    //   okDollar.value = !value;
    //   txtName.text = value ? '' : 'OK\$ - ';
    //   subType = value ? '' : 'OKDOLLAR';
    //   ayaPay.value = false;
    // }
  }
}
