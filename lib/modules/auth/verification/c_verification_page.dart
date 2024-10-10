import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VerificationController extends GetxController {
  String strEmail = 'komyintmyatsoe@icloud.com';
  TextEditingController pinController = TextEditingController();
  FocusNode focusNode = FocusNode();
  ValueNotifier<int> remainingSeconds = ValueNotifier(300);
  ValueNotifier<bool> xSendAgain = ValueNotifier(false);
  // Widget textEamil =
  //     Text("strEmail", style: TextStyle(fontSize: 15, color: background));

  Timer? timer;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    initLoad();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    timer?.cancel();
  }

  void initLoad() {
    startCountdown();
  }

  void startCountdown() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainingSeconds.value > 0) {
        remainingSeconds.value--;
      } else {
        xSendAgain.value=true;
        timer.cancel();
      }
    });
  }

  String formatTime(int seconds) {
    final int minutes = seconds ~/ 60;
    final int remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  String? validateCode(String? value) {
    if (value == '222222') {
      print(value);
      return null;
    } else {
      print(value);
      return 'Incorrect Pin';
    }
  }
}
