import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class IncomeNewController extends GetxController {
  // late StringTagController stringTagController;
  TextEditingController txtAmount = TextEditingController();
  TextEditingController txtRemark = TextEditingController();
  TextEditingController txtDescription = TextEditingController();
  // TextEditingController txtWallet = TextEditingController();
  ValueNotifier<String?> selectedCategory = ValueNotifier(null);
  ValueNotifier<String?> selectedSubType = ValueNotifier(null);
  ValueNotifier<XFile?> selectedImage = ValueNotifier(null);

  ValueNotifier<bool> imagePickState = ValueNotifier(false);

  List<String> walletList = [];

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  @override
  void dispose() {
    super.dispose();
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

  void ptrintData() {
    print(txtAmount.text);
  }
}
