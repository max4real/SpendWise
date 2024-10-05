import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class OutcomeNewController extends GetxController {
  TextEditingController txtAmount = TextEditingController();
  TextEditingController txtDescription = TextEditingController();
  TextEditingController txtRemark = TextEditingController();
  TextEditingController txtWallet = TextEditingController();
  ValueNotifier<String?> selectedCategory = ValueNotifier(null);

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
}
