import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:spend_wise/_common/data/data_controller.dart';

class TestController extends GetxController {
  ValueNotifier<XFile?> selectedImage = ValueNotifier(null);
  ValueNotifier<XFile?> apiImage = ValueNotifier(null);
  String title = "Hello";
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
    String url = 'https://a-saung-ls3v.onrender.com/api/v1/image';
    if (selectedImage.value != null) {
      final File imageFile = File(selectedImage.value!.path);

      final formData = FormData(
        {
          'image': MultipartFile(
            imageFile,
            filename: imageFile.path.split('/').last,
          ),
        },
      );

      final response = await GetConnect().post(
        url,
        formData,
      );

      if (response.isOk) {
        print(response.body['_data']['filename']);
        maxSuccessDialog("Image uploaded successfully!", true);
      } else {
        maxSuccessDialog(
            "Failed to upload image. Status: ${response}", false);
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
// Future<Response?> formDataPost({
//     required String endPoint,
//     Map<String, dynamic> data = const {},
//     Map<String, dio.MultipartFile?> files = const {},
//     bool xNeedToken = false,
//     bool xBaseUrlIncluded = true,
//     int sendTimeout = 100,
//   }) async {
//     final xHasInternet = await checkInternet();
//     checkApiToken();
//     if (xHasInternet) {
//       Response? response;
//       try {
//         dio.Dio dioClient = dio.Dio();
//         dio.FormData formData = dio.FormData.fromMap({...data, ...files});
//         DataController dataController = Get.find();
//         var dioResponse = await dioClient.post(
//             xBaseUrlIncluded
//                 ? "${dataController.baseUrl}${dataController.apiPort}${dataController.apiPrefix}$endPoint"
//                 : endPoint,
//             options: dio.Options(
//               // contentType: 'text/html; charset=utf-8',
//               sendTimeout: Duration(seconds: sendTimeout),
//               headers: <String, String>{
//                 "accept": "*/*",
//                 "Content-Type": "multipart/form-data",
//                 if (xNeedToken)
//                   "Authorization": "Bearer ${dataController.apiToken}",
//               },
//             ),
//             data: formData);
//         superPrint(dioResponse.data, title: dioResponse.statusCode);
//         if (dioResponse.statusCode! >= 200 && dioResponse.statusCode! <= 299) {
//           response = Response(
//             statusCode: 201,
//             headers: {},
//             body: dioResponse.data,
//             statusText: "",
//           );
//         }
//       } catch (e1, e2) {
//         saveLogFromException(e1, e2);
//         superPrint(e1, title: e2);
//         response = Response(statusCode: -1, body: null, bodyString: "");
//         if (e1 is dio.DioException) {
//           try {
//             superPrint(e1.response!.data, title: e1.response!.statusCode);
//             response = Response(
//                 statusCode: e1.response!.statusCode,
//                 body: e1.response!.data,
//                 bodyString: e1.response!.data.toString());
//           } catch (e1, e2) {
//             saveLogFromException(e1, e2);
//             response = const Response(
//                 statusCode: 0, body: {}, bodyString: "Something went wrong!");
//           }
//         }
//       }
//       return response;
//     } else {
//       DataController dataController = Get.find();
//       return Response(
//           request: Request(
//         url: Uri.parse(xBaseUrlIncluded
//             ? "${dataController.baseUrl}${dataController.apiPort}${dataController.apiPrefix}$endPoint"
//             : endPoint),
//         headers: {
//           "accept": "*/*",
//           "Content-Type": "application/json",
//           if (xNeedToken) "Authorization": "Bearer ${dataController.apiToken}",
//         },
//         method: 'POST/FORM_DATA',
//       ));
//     }
//   }