import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:textfield_tags/textfield_tags.dart';

class TransferNewController extends GetxController {
  late StringTagController stringTagController;
  TextEditingController txtAmount = TextEditingController();
  TextEditingController txtRemark = TextEditingController();
  TextEditingController txtDescription = TextEditingController();
  TextEditingController txtFrom = TextEditingController();
  TextEditingController txtTo = TextEditingController();

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
