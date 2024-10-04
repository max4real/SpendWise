import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:textfield_tags/textfield_tags.dart';

class IncomeNewController extends GetxController {
  late StringTagController stringTagController;
  TextEditingController txtAmount = TextEditingController();
  TextEditingController txtRemark = TextEditingController();
  TextEditingController txtDescription = TextEditingController();
  TextEditingController txtWallet = TextEditingController();
  ValueNotifier<String?> selectedCategory = ValueNotifier(null);
  ValueNotifier<XFile?> selectedImage = ValueNotifier(null);

  ValueNotifier<bool> imagePickState = ValueNotifier(false);

  List<String> walletList = [];

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    stringTagController = StringTagController();
  }

  @override
  void dispose() {
    super.dispose();
    stringTagController.dispose();
  }

  void testPrint() {
    List<String>? list_ = stringTagController.getTags;
    if (list_!.isNotEmpty) {
      list_.forEach(print);
    } else {
      print('empty');
    }
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
