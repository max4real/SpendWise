import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:spend_wise/_common/data/data_controller.dart';

class OutcomeNewController extends GetxController {
  DataController dataController = Get.find();
  final String transactionType = "Expense";
  TextEditingController txtAmount = TextEditingController();

  ValueNotifier<String?> selectedCategory = ValueNotifier(null);
  TextEditingController txtCustomCategory = TextEditingController();

  TextEditingController txtRemark = TextEditingController();
  TextEditingController txtDescription = TextEditingController();
  ValueNotifier<String?> selectedSubType = ValueNotifier(null);
  ValueNotifier<XFile?> selectedImage = ValueNotifier(null);

  ValueNotifier<bool> xCustom = ValueNotifier(false);
  ValueNotifier<bool> imagePickState = ValueNotifier(false);

  List<String> walletList = [];

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    initLoad();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void initLoad() {
    dataController.fetchAccountList();
  }

  Future<XFile?> pickImage() async {
    ImagePicker iPicker = ImagePicker();
    XFile? result = await iPicker.pickImage(source: ImageSource.camera);
    if (result != null) {
      selectedImage.value = result;
      imagePickState.value = true;
    }
    return result;
  }

  void switchCustom() {
    xCustom.value = !xCustom.value;
  }

  bool checkAllField() {
    if (txtAmount.text.isEmpty) {
      maxMessageDialog('Please Enter Amount.');
      return false;
    } else if (txtRemark.text.isEmpty) {
      maxMessageDialog('Please Enter Remark.');
      return false;
    } else if (selectedSubType.value == null) {
      maxMessageDialog('Please Select Account.');
      return false;
    } else if (xCustom.value) {
      if (txtCustomCategory.text.isEmpty) {
        maxMessageDialog('Please Enter New Category.');
        return false;
      } else {
        return true;
      }
    } else {
      if (selectedCategory.value == null) {
        maxMessageDialog('Please Select Category.');
        return false;
      } else {
        return true;
      }
    }
  }

  void proceedToSave() {
    if (checkAllField()) {
      printData();
    }
  }

  void printData() {
    print('Transaction Type - ' + transactionType);
    print('Amount - ' + txtAmount.text);

    if (xCustom.value) {
      print('Category - ' + txtCustomCategory.text);
    } else {
      print('Category - ' + selectedCategory.value.toString());
    }

    print('Remark - ' + txtRemark.text);
    print('Description - ' + txtDescription.text);
    print('Account - ' + selectedSubType.value.toString());

    if (selectedImage.value == null) {
      print('Has Image - False');
    } else {
      print('Has Image - True');
    }
  }
}
