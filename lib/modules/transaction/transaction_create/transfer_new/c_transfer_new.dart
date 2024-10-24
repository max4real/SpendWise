import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:spend_wise/_common/data/data_controller.dart';

import '../../../../_servies/network_services/api_endpoint.dart';

class TransferNewController extends GetxController {
  DataController dataController = Get.find();
  final String transactionType = "TRANSFER";
  TextEditingController txtAmount = TextEditingController();
  TextEditingController txtRemark = TextEditingController();
  TextEditingController txtDescription = TextEditingController();

  ValueNotifier<String?> selectedSubTypeFrom = ValueNotifier(null);
  ValueNotifier<String?> selectedSubTypeTo = ValueNotifier(null);

  ValueNotifier<XFile?> selectedImage = ValueNotifier(null);
  ValueNotifier<bool> imagePickState = ValueNotifier(false);

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

  bool checkAllField() {
    if (txtAmount.text.isEmpty) {
      maxMessageDialog('Please Enter Amount.');
      return false;
    } else if (txtRemark.text.isEmpty) {
      maxMessageDialog('Please Enter Remark.');
      return false;
    } else if (selectedSubTypeFrom.value == null) {
      maxMessageDialog('Please Select Transfer Account.');
      return false;
    } else if (selectedSubTypeTo.value == null) {
      maxMessageDialog('Please Select Receving Account.');
      return false;
    } else if (selectedSubTypeFrom.value == selectedSubTypeTo.value) {
      maxMessageDialog('Can\'t Transfer From Same Account.');
      return false;
    } else {
      return true;
    }
  }

  void proceedToSave() {
    if (checkAllField()) {
      createTransaction();
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

  Future<void> createTransaction() async {
    print('------------------------------------------------------------------');
    print('----------------------- Create Transaction -----------------------');
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
          'from': getSubTypeID(selectedSubTypeFrom.value.toString()),
          'to': getSubTypeID(selectedSubTypeTo.value.toString()),
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
        print(response.bodyString);
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
    txtRemark.text = '';
    txtDescription.text = '';
    selectedSubTypeFrom.value = null;
    selectedSubTypeTo.value = null;
    selectedImage.value = null;
    imagePickState.value = false;
  }
}
