import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:textfield_tags/textfield_tags.dart';

class TransferNewController extends GetxController {
  late StringTagController stringTagController;
  TextEditingController txtAmount = TextEditingController();
  TextEditingController txtDescription = TextEditingController();
  TextEditingController txtFrom= TextEditingController();
  TextEditingController txtTo= TextEditingController();


  
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

  }

  @override
  void dispose() {
    super.dispose();

  }
}
