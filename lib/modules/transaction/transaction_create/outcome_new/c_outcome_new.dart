import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:spend_wise/_common/data/data_controller.dart';
import 'package:spend_wise/_servies/network_services/api_endpoint.dart';

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
    dataController.fetchCategoryList();
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
      createGateway();
    }
  }

  String getSubTypeID(String subtype) {
    for (var element in dataController.accountList.value) {
      if (element.accSubType == subtype) {
        return element.accId;
      }
    }
    return '';
  }

  String getCategoryID(String categoryName) {
    for (var element in dataController.categoryList.value) {
      if (element.categoryName == categoryName) {
        return element.categoryID;
      }
    }
    return '';
  }

  Future<String> createCategory(String categoryName) async {
    String url = ApiEndpoint.baseUrl2 + ApiEndpoint.category;
    GetConnect client = GetConnect(timeout: const Duration(seconds: 10));
    try {
      final response = await client.post(
        url,
        {
          "name": categoryName,
          "icon": "",
          "private": true,
        },
        headers: {
          'Authorization': 'Bearer ${dataController.apiToken}',
          'Content-Type': 'application/json',
        },
      );
      if (response.isOk) {
        String newCategoryID = response.body['_data']['id'].toString();
        return newCategoryID;
      } else {
        print(response.body['_metadata']['message']);
        maxSuccessDialog(
            response.body['_metadata']['message'].toString(), false);
      }
    } catch (e) {}
    return 'ID';
  }

  Future<void> createTransaction(String categoryID) async {
    String url = ApiEndpoint.baseUrl2 + ApiEndpoint.transaction;
    GetConnect client = GetConnect(timeout: const Duration(seconds: 10));

    try {
      Get.dialog(const Center(
        child: CircularProgressIndicator(),
      ));

      final response = await client.post(
        url,
        {
          'categoryID': categoryID,
        },
        headers: {
          'Authorization': 'Bearer ${dataController.apiToken}',
          'Content-Type': 'application/json',
        },
      );

      Get.back();
      if (response.isOk) {
        print(response.body['_metadata']['message'].toString());
        Get.back();
      } else {
        print(response.body['_metadata']['message'].toString());
        maxSuccessDialog(
            response.body['_metadata']['message'].toString(), false);
      }
    } catch (e) {}
  }

  void createGateway() async {
    if (xCustom.value) {
      //create new category
      String newCategoryID = await createCategory(txtCustomCategory.text);
      createTransaction(newCategoryID);
    } else {
      //use existing category
      createTransaction(getCategoryID(selectedCategory.value.toString()));
    }
  }

  void printData() async {
    print('Transaction Type - ' + transactionType);
    print('Amount - ' + txtAmount.text);

    if (xCustom.value) {
      //create new
      print('Category - ' + txtCustomCategory.text);
      String newCategoryID = await createCategory(txtCustomCategory.text);
      print('new category id - ' + newCategoryID);
    } else {
      //use existing
      print('Category - ' + selectedCategory.value.toString());
      print(
          'Category ID - ' + getCategoryID(selectedCategory.value.toString()));
    }

    print('Remark - ' + txtRemark.text);
    print('Description - ' + txtDescription.text);
    print('Account - ' + selectedSubType.value.toString());
    print('Account ID - ' + getSubTypeID(selectedSubType.value.toString()));

    if (selectedImage.value == null) {
      print('Has Image - False');
    } else {
      print('Has Image - True');
    }
  }
}
