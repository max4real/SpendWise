import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spend_wise/_common/data/data_controller.dart';
import 'package:spend_wise/models/m_caetgory_model.dart';

import '../../_servies/network_services/api_endpoint.dart';

class CategoryController extends GetxController {
  DataController dataController = Get.find();
  ValueNotifier<List<CategoryModel>> categoryList = ValueNotifier([]);
  ValueNotifier<bool> xFetching = ValueNotifier(false);

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    initLoad();
  }

  void initLoad() {
    fetchCategoryList();
  }

  Future<void> fetchCategoryList() async {
    String url = ApiEndpoint.baseUrl2 + ApiEndpoint.category;
    GetConnect client = GetConnect(timeout: const Duration(seconds: 10));

    try {
      xFetching.value = true;
      final response = await client.get(
        url,
        headers: {
          'Authorization': 'Bearer ${dataController.apiToken}',
          'Content-Type': 'application/json',
        },
      );
      xFetching.value = false;
      if (response.isOk) {
        print(response.body['_metadata']['message']);
        List<CategoryModel> temp = [];

        Iterable iterable = response.body['_data'] ?? [];

        for (var element in iterable) {
          CategoryModel rawData = CategoryModel.fromAPI(data: element);
          temp.add(rawData);
        }
        categoryList.value = [...temp];
        categoryList.value.sort((a, b) => b.categoryPrivacy
            .toString()
            .compareTo(a.categoryPrivacy.toString()));
      } else {
        print(response.body['_metadata']['message']);
        maxSuccessDialog(
            response.body['_metadata']['message'].toString(), false);
      }
    } catch (e) {}
  }

  Future<void> deleteCategory(String id) async {
    String url = '${ApiEndpoint.baseUrl2}${ApiEndpoint.category}/$id';

    GetConnect client = GetConnect(timeout: const Duration(seconds: 10));
    try {
      Get.dialog(const Center(child: CircularProgressIndicator()));

      final response = await client.delete(
        url,
        headers: {
          'Authorization': 'Bearer ${dataController.apiToken}',
          'Content-Type': 'application/json',
        },
      );

      Get.back();
      if (response.isOk) {
        print(response.body['_metadata']['message'].toString());

        List<CategoryModel> temp = [...categoryList.value];
        temp.removeWhere((category) => category.categoryID == id);
        categoryList.value = [...temp];
      } else {
        print(response.body['_metadata']['message'].toString());
        maxSuccessDialog(
            response.body['_metadata']['message'].toString(), false);
      }
    } catch (e1) {}
  }
}
