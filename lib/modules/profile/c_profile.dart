import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spend_wise/modules/auth/login/v_login_page.dart';

import '../../_common/data/data_controller.dart';

class ProfileController extends GetxController {
  ValueNotifier<XFile?> selectedImage = ValueNotifier(null);

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  Future<void> uploadProfileImage() async {
    print("Call IMAGE API");
  }

  Future<void> pickImage() async {
    maxImagePickerDialog(
      "Choose Profile Image From",
      () {
        pickImageFromCamera();
        Get.back();
      },
      () {
        pickImageFromGallary();
        Get.back();
      },
    );
  }

  Future<void> pickImageFromCamera() async {
    ImagePicker iPicker = ImagePicker();

    XFile? result = await iPicker.pickImage(
      source: ImageSource.camera,
      preferredCameraDevice: CameraDevice.front,
    );
    if (result != null) {
      selectedImage.value = result;
      uploadProfileImage();
    }
  }

  Future<void> pickImageFromGallary() async {
    ImagePicker iPicker = ImagePicker();

    XFile? result = await iPicker.pickImage(source: ImageSource.gallery);
    if (result != null) {
      selectedImage.value = result;
      uploadProfileImage();
    }
  }

  void logOut() {
    removeToken();
    Get.offAll(() => const LoginPage());
  }

  Future<void> removeToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', '');
  }
}
