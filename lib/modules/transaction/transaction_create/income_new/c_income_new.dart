import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:spend_wise/_common/data/data_controller.dart';

import '../../../../_servies/network_services/api_endpoint.dart';

class IncomeNewController extends GetxController {
  DataController dataController = Get.find();
  final String transactionType = "INCOME";
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

  void createGateway() async {
    if (xCustom.value) {
      //create new category
      createCategory(txtCustomCategory.text);
    } else {
      //use existing category
      createTransaction(getCategoryID(selectedCategory.value.toString()));
    }
  }

  Future<void> createCategory(String categoryName) async {
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
        if (newCategoryID != '') {
          createTransaction(newCategoryID);
        } else {
          maxSuccessDialog("Something went wrong.", false);
        }
      } else {
        print(response.body['_metadata']['message']);
        maxSuccessDialog(
            response.body['_metadata']['message'].toString(), false);
      }
    } catch (e) {}
  }

  Future<void> createTransaction(String categoryID) async {
    print('--------------------------');
    print('Create Transaction ------');
    String url = ApiEndpoint.baseUrl2 + ApiEndpoint.transaction;
    GetConnect client = GetConnect(timeout: const Duration(seconds: 10));

    try {
      Get.dialog(const Center(child: CircularProgressIndicator()));

      MultipartFile? multipartFile;

      if (selectedImage.value != null) {
        final File imageFile = File(selectedImage.value!.path);
        multipartFile = MultipartFile(
          imageFile,
          filename: imageFile.path.split('/').last,
        );
      } else {
        multipartFile = null;
      }

      final formData = FormData(
        {
          'remark': txtRemark.text,
          if (txtDescription.text.isNotEmpty)
            'description': txtDescription.text,
          'amount': int.tryParse(txtAmount.text) ?? -1,
          'type': transactionType,
          'from': getSubTypeID(selectedSubType.value.toString()),
          // 'to': ,
          'categoryId': categoryID,
          if (multipartFile != null) 'image': multipartFile,
        },
      );

      formData.fields.forEach((field) {
        print('${field.key}: ${field.value}');
      });
      if (multipartFile != null) {
        print('image: ${multipartFile.filename}');
      }
      final response = await client.post(
        url,
        formData,
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

  void printData() {
    print('Transaction Type - ' + transactionType);
    print('Amount - ' + txtAmount.text);

    if (xCustom.value) {
      print('Category - ' + txtCustomCategory.text);
    } else {
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
