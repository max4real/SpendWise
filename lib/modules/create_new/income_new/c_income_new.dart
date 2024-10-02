import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:textfield_tags/textfield_tags.dart';

class IncomeNewController extends GetxController {
  late StringTagController stringTagController;
  TextEditingController txtAmount = TextEditingController();
  TextEditingController txtDescription = TextEditingController();
  TextEditingController txtWallet = TextEditingController();

  List<String> walletList = [];
  List<String> categoryTags = <String>[
    'shopping',
    'netflix',
    'foods',
    'dinner'
  ];

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
}
