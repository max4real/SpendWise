import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:spend_wise/my_test/c_test.dart';
import 'package:get/get.dart';

class MyTestPage extends StatelessWidget {
  const MyTestPage({super.key});

  @override
  Widget build(BuildContext context) {
    TestController controller = Get.put(TestController());
    return Scaffold(
      appBar: AppBar(
        title: const Text("Test"),
        actions: [
          IconButton(
            onPressed: () {
              controller.pickImage();
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: 250,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: ValueListenableBuilder(
                      valueListenable: controller.selectedImage,
                      builder: (context, value, child) {
                        if (value != null) {
                          return displayImage(value);
                        } else {
                          return const Center(
                            child: Text("no image yet"),
                          );
                        }
                      },
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton.filled(
                    onPressed: () {
                      controller.selectedImage.value = null;
                    },
                    icon: const Icon(
                      Icons.clear_rounded,
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    controller.saveImage();
                  },
                  child: const Text("Save Image"),
                ),
                const Gap(10),
                ElevatedButton(
                  onPressed: () {
                    controller.loadImage();
                  },
                  child: const Text("Load Image"),
                )
              ],
            ),
            const Gap(15),
            Stack(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: 250,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: ValueListenableBuilder(
                      valueListenable: controller.apiImage,
                      builder: (context, value, child) {
                        if (value != null) {
                          return displayImage(value);
                        } else {
                          return const Center(
                            child: Text("no image yet"),
                          );
                        }
                      },
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton.filled(
                    onPressed: () {
                      controller.selectedImage.value = null;
                    },
                    icon: const Icon(
                      Icons.clear_rounded,
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget displayImage(XFile? pickedFile) {
    if (pickedFile != null) {
      return Image.file(
        File(pickedFile.path),
        fit: BoxFit.cover,
      );
    } else {
      return const Text('No image selected');
    }
  }
}
