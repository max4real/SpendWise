import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:spend_wise/_common/data/data_controller.dart';
import 'package:spend_wise/_servies/network_services/api_endpoint.dart';

class OutcomeNewController extends GetxController {
  DataController dataController = Get.find();
  final String transactionType = "EXPENSE";
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
    XFile? result =
        await iPicker.pickImage(source: ImageSource.camera, imageQuality: 50);
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
    print('------------------------------------------------------------------');
    print('------------------------- Create CATEGORY ------------------------');
    String url = ApiEndpoint.baseUrl + ApiEndpoint.category;
    GetConnect client = GetConnect(timeout: const Duration(minutes: 1));
    try {
      final formData = FormData(
        {
          "name": categoryName,
          "icon": "",
          "private": true,
        },
      );
      final response = await client.post(
        url,
        formData,
        headers: {
          'Authorization': 'Bearer ${dataController.apiToken}',
        },
      );
      if (response.isOk) {
        String newCategoryID = response.body['id'].toString();
        if (newCategoryID != '') {
          createTransaction(newCategoryID);
        } else {
          maxSuccessDialog("Something went wrong.", false);
        }
      } else {
        print(response.body['message']);
        maxSuccessDialog(response.body['message'].toString(), false);
      }
    } catch (e) {}
  }

  Future<void> createTransaction(String categoryID) async {
    print('------------------------------------------------------------------');
    print('----------------------- Create Transaction -----------------------');
    String url = ApiEndpoint.baseUrl2 + ApiEndpoint.transaction;
    GetConnect client = GetConnect(timeout: const Duration(minutes: 1));

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
          'to': getSubTypeID(selectedSubType.value.toString()),
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
        // contentType: 'multipart/form-data',
        headers: {
          'Authorization': 'Bearer ${dataController.apiToken}',
          // 'Content-Type': 'application/json',
          // 'Content-Type': 'multipart/form-data'
        },
      );

      Get.back();
      if (response.isOk) {
        print("ok");
        print(response.bodyString);
        dataController.fetchCategoryList();
        maxSuccessDialog2(
          response.body['_metadata']['message'].toString(),
          true,
          () {
            clearAllField();
            Get.back();
          },
          'Continue',
        );
      } else {
        print('not ok');
        print(response.bodyString);
        maxSuccessDialog(
            response.body['_metadata']['message'].toString(), false);
      }
    } catch (e) {
      // print('Error: $e');
    }
  }

  void clearAllField() {
    txtAmount.text = '';
    txtCustomCategory.text = '';
    selectedCategory.value = null;
    txtRemark.text = '';
    txtDescription.text = '';
    selectedSubType.value = null;
    selectedImage.value = null;
    imagePickState.value = false;
  }

  void printData() async {
    print('Transaction Type - ' + transactionType);
    print('Amount - ' + txtAmount.text);

    if (xCustom.value) {
      //create new
      print('Category - ' + txtCustomCategory.text);
      // String newCategoryID = await createCategory(txtCustomCategory.text);
      // print('new category id - ' + newCategoryID);
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
