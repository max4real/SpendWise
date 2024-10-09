import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class AccountEditController extends GetxController {
  TextEditingController txtAmount = TextEditingController();
  TextEditingController txtName = TextEditingController();
  ValueNotifier<String?> selectedType = ValueNotifier(null);
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

  void initLoad(
    String amount,
    String name,
    String accType,
    String accSubType,
  ) {
    txtAmount.text = amount;
    txtName.text = name;
    selectedType.value = accType;
    if (accType.isNotEmpty) {
      if (accType == 'Wallet') {
      } else if (accType == 'Bank') {
        xShowBank.value = true;
      } else if (accType == 'Mobile Banking') {
        xShowMobileBank.value = true;
      }
    }
    switch (accSubType) {
      case 'KBZ Bank':
        bankKBZ.value = true;
      case 'AYA Bank':
        bankAYA.value = true;
      case 'Yoma Bank':
        bankYoma.value = true;
      case 'CB Bank':
        bankCB.value = true;
      case 'AGD Bank':
        bankAGD.value = true;
      case 'Other':
        bankOther.value = true;
      case 'KBZ Pay':
        kPay.value = true;
      case 'Wave Pay':
        wavePay.value = true;
      case 'CB Mobile Banking':
        cbMobile.value = true;
      case 'OK\$':
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

  void printData() {
    print(txtAmount.text);
    print(txtName.text);
    print(selectedType.value);
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
    cbMobile.value = false;
  }

  void controlBankList(String name, bool value) {
    if (name == 'KBZBANK') {
      bankKBZ.value = !value;
      txtName.text = value ? '' : 'KBZ Bank - ';
      subType = value ? '' : 'KBZ Bank';
      bankAYA.value = false;
      bankYoma.value = false;
      bankCB.value = false;
      bankAGD.value = false;
      bankOther.value = false;
    } else if (name == 'AYABANK') {
      bankKBZ.value = false;
      bankAYA.value = !value;
      txtName.text = value ? '' : 'AYA Bank - ';
      subType = value ? '' : 'AYA Bank';
      bankYoma.value = false;
      bankCB.value = false;
      bankAGD.value = false;
      bankOther.value = false;
    } else if (name == 'YOMABANK') {
      bankKBZ.value = false;
      bankAYA.value = false;
      bankYoma.value = !value;
      txtName.text = value ? '' : 'Yoma Bank - ';
      subType = value ? '' : 'Yoma Bank';
      bankCB.value = false;
      bankAGD.value = false;
      bankOther.value = false;
    } else if (name == 'CBBANK') {
      bankKBZ.value = false;
      bankAYA.value = false;
      bankYoma.value = false;
      bankCB.value = !value;
      txtName.text = value ? '' : 'CB Bank - ';
      subType = value ? '' : 'CB Bank';
      bankAGD.value = false;
      bankOther.value = false;
    } else if (name == 'AGDBANK') {
      bankKBZ.value = false;
      bankAYA.value = false;
      bankYoma.value = false;
      bankCB.value = false;
      bankAGD.value = !value;
      txtName.text = value ? '' : 'AGD Bank - ';
      subType = value ? '' : 'AGD Bank';
      bankOther.value = false;
    } else if (name == 'OTHERBANK') {
      bankKBZ.value = false;
      bankAYA.value = false;
      bankYoma.value = false;
      bankCB.value = false;
      bankAGD.value = false;
      bankOther.value = !value;
      txtName.text = value ? '' : 'Other - ';
      subType = value ? '' : 'Other';
    }
  }

  void controlMobileBankList(String name, bool value) {
    if (name == "KPAY") {
      kPay.value = !value;
      txtName.text = value ? '' : 'KBZ Pay - ';
      subType = value ? '' : 'KBZ Pay';
      wavePay.value = false;
      okDollar.value = false;
      cbMobile.value = false;
    } else if (name == "WAVEPAY") {
      kPay.value = false;
      wavePay.value = !value;
      txtName.text = value ? '' : 'Wave Pay - ';
      subType = value ? '' : 'Wave Pay';
      okDollar.value = false;
      cbMobile.value = false;
    } else if (name == "CB") {
      kPay.value = false;
      wavePay.value = false;
      okDollar.value = false;
      cbMobile.value = !value;
      txtName.text = value ? '' : 'CB Mobile Banking - ';
      subType = value ? '' : 'CB Mobile Banking';
    } else if (name == "OKDOLLAR") {
      kPay.value = false;
      wavePay.value = false;
      okDollar.value = !value;
      txtName.text = value ? '' : 'OK\$ - ';
      subType = value ? '' : 'OK\$';
      cbMobile.value = false;
    }
  }
}
