import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class TransferNewController extends GetxController {
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
