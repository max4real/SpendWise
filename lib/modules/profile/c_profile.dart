import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spend_wise/modules/auth/login/v_login_page.dart';

class ProfileController extends GetxController {
  ValueNotifier<XFile?> selectedImage = ValueNotifier(null);

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  void logOut() {
    removeToken();
    Get.offAll(() => const LoginPage());
  }

  Future<void> removeToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', '');
  }

  Future<XFile?> pickImage() async {
    ImagePicker iPicker = ImagePicker();
    XFile? result = await iPicker.pickImage(source: ImageSource.camera);
    if (result != null) {
      selectedImage.value = result;
      print("Call IMAGE API");
    }
    return result;
  }
}
