import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:spend_wise/_common/data/data_controller.dart';

class TestController extends GetxController {
  ValueNotifier<XFile?> selectedImage = ValueNotifier(null);
  ValueNotifier<XFile?> apiImage = ValueNotifier(null);

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  Future<XFile?> pickImage() async {
    ImagePicker iPicker = ImagePicker();
    XFile? result = await iPicker.pickImage(source: ImageSource.camera);
    if (result != null) {
      selectedImage.value = result;
    }
    return result;
  }

  Future<void> saveImage() async {
    String url = '';
    if (selectedImage.value != null) {
      final File imageFile = File(selectedImage.value!.path);

      final formData = FormData({
        'file':
            MultipartFile(imageFile, filename: imageFile.path.split('/').last),
      });

      final response = await GetConnect().post(url, formData);

      if (response.isOk) {
        maxSuccessDialog("Image uploaded successfully!", true);
      } else {
        maxSuccessDialog(
            "Failed to upload image. Status: ${response.statusCode}", true);
      }
    }
  }

  Future<void> loadImage() async {}
}

// Future<void> createGroup() async {
//   Response? response;
//   try {
//     response = await ApiService().formDataPost(
//         endPoint: ApiEndPoints.createGroup,
//         xNeedToken: true,
//         data: {
//           "name": txtGroupName.text,
//           "members": selectedEmployee.value
//               .map(
//                 (e) => e.id.toString(),
//               )
//               .toList()
//         },
//         files: {
//           "photo": uploadedGroupImage.value == null
//               ? null
//               : await dio.MultipartFile.fromFile(
//                   uploadedGroupImage.value!.path,
//                   filename: uploadedGroupImage.value!.path,
//                 )
//         });
//   } catch (e1, e2) {
//     saveLogFromException(e1, e2);
//     null;
//   }
//   DialogService().dismissDialog();
//   ApiResponse apiResponse = ApiService().validateResponse(response: response);
//   superPrint(apiResponse.bodyData);
// }
