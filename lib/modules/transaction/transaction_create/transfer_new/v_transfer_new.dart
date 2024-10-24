import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';
import 'package:spend_wise/_common/constants/app_svg.dart';
import 'package:spend_wise/_servies/theme_services/d_dark_theme.dart';
import 'package:spend_wise/_servies/theme_services/w_custon_theme_builder.dart';
import 'package:get/get.dart';
import 'package:spend_wise/modules/transaction/transaction_create/transfer_new/c_transfer_new.dart';

import '../../../../_common/data/data_controller.dart';

class TransferNewPage extends StatelessWidget {
  const TransferNewPage({super.key});

  @override
  Widget build(BuildContext context) {
    TransferNewController controller = Get.put(TransferNewController());
    return MaxThemeBuilder(
      builder: (context, theme, themeController) {
        return Scaffold(
          // resizeToAvoidBottomInset: true,
          backgroundColor: transferColor,
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: transferColor,
            leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(
                Iconsax.arrow_left,
                color: Colors.white,
                size: 30,
              ),
            ),
            title: const Text(
              'Transfer',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  width: Get.width,
                  height: 200,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 18,
                      vertical: 15,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'How Much?',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                        //Amount Text Field row
                        Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: controller.txtAmount,
                                keyboardType: TextInputType.number,
                                onTapOutside: (event) {
                                  dismissKeyboard();
                                },
                                // inputFormatters: [CommaTextInputFormatter()],
                                cursorColor: theme.background,
                                cursorHeight: 30,
                                style: const TextStyle(
                                  fontSize: 30,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                ),
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: '0 Ks',
                                  hintStyle: TextStyle(
                                    fontSize: 30,
                                    color: Color.fromARGB(255, 235, 234, 234),
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            const Text(
                              'MMK',
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height - 150,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(18),
                    child: Column(
                      children: [
                        FromToFields(),
                        const SizedBox(height: 20),
                        TextField(
                          onTapOutside: (event) {
                            dismissKeyboard();
                          },
                          controller: controller.txtRemark,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: const BorderSide(color: Colors.grey),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            hintText: 'Remark',
                            hintStyle: const TextStyle(
                                color: Color(0XFF91919F),
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                        const SizedBox(height: 20),
                        TextField(
                          onTapOutside: (event) {
                            dismissKeyboard();
                          },
                          controller: controller.txtDescription,
                          keyboardType: TextInputType.multiline,
                          textInputAction: TextInputAction.newline,
                          maxLines: 2,
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: const BorderSide(color: Colors.grey),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            hintText: 'Description (optional)',
                            hintStyle: const TextStyle(
                                color: Color(0XFF91919F),
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                        const SizedBox(height: 20),
                        //Image Picker
                        ValueListenableBuilder(
                          valueListenable: controller.imagePickState,
                          builder: (context, value, child) {
                            if (value) {
                              return Stack(
                                children: [
                                  SizedBox(
                                    width: double.infinity,
                                    height: 120,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: ValueListenableBuilder(
                                        valueListenable:
                                            controller.selectedImage,
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
                                        controller.imagePickState.value = false;
                                      },
                                      icon: const Icon(
                                        Icons.clear_rounded,
                                        color: Colors.white,
                                      ),
                                    ),
                                  )
                                ],
                              );
                            } else {
                              return GestureDetector(
                                onTap: () {
                                  controller.pickImage();
                                },
                                child: DottedBorder(
                                  borderType: BorderType.RRect,
                                  radius: const Radius.circular(15),
                                  dashPattern: const [8, 2],
                                  color: Colors.grey,
                                  strokeWidth: 1,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 14, horizontal: 24),
                                    child: const Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(
                                          Iconsax.attach_square,
                                          color: Colors.grey,
                                        ),
                                        SizedBox(width: 8),
                                        Text(
                                          'Add attachment',
                                          style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }
                          },
                        ),
                        const SizedBox(height: 30),
                        GestureDetector(
                          onTap: () {
                            controller.proceedToSave();
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: theme.background,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            padding: const EdgeInsets.symmetric(
                                vertical: 13, horizontal: 110),
                            child: const Text(
                              "Continue",
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
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

// ignore: must_be_immutable
class FromToFields extends StatelessWidget {
  TransferNewController controller = Get.find();
  DataController dataController = Get.find();

  FromToFields({super.key});
  @override
  Widget build(BuildContext context) {
    return MaxThemeBuilder(
      builder: (context, theme, themeController) {
        return Stack(
          children: [
            Row(
              children: [
                Expanded(
                  child: ValueListenableBuilder(
                    valueListenable: dataController.accSubType,
                    builder: (context, accSubType, child) {
                      return ValueListenableBuilder(
                        valueListenable: controller.selectedSubTypeFrom,
                        builder: (context, value, child) {
                          return Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                              value: value,
                              elevation: 8,
                              borderRadius: BorderRadius.circular(20),
                              menuWidth: Get.width * 0.6,
                              menuMaxHeight: 300,
                              padding: const EdgeInsets.symmetric(vertical: 2),
                              style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                              ),
                              hint: const Text(
                                'From',
                                style: TextStyle(
                                  color: Color(0XFF91919F),
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              isExpanded: true,
                              icon: Icon(
                                Iconsax.arrow_right_3,
                                color: theme.background,
                              ),
                              items: accSubType.map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(
                                    value,
                                    style: const TextStyle(
                                      color: Color(0xFF5D5C5C),
                                    ),
                                  ),
                                );
                              }).toList(),
                              onChanged: (newValue) {
                                controller.selectedSubTypeFrom.value = newValue;
                              },
                            )),
                          );
                        },
                      );
                    },
                  ),
                ),
                const SizedBox(
                  width: 40,
                ),
                Expanded(
                  child: ValueListenableBuilder(
                    valueListenable: dataController.accSubType,
                    builder: (context, accSubType, child) {
                      return ValueListenableBuilder(
                        valueListenable: controller.selectedSubTypeTo,
                        builder: (context, value, child) {
                          return Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                              value: value,
                              elevation: 8,
                              borderRadius: BorderRadius.circular(20),
                              menuWidth: Get.width * 0.6,
                              menuMaxHeight: 300,
                              padding: const EdgeInsets.symmetric(vertical: 2),
                              style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                              ),
                              hint: const Text(
                                'To',
                                style: TextStyle(
                                  color: Color(0XFF91919F),
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              isExpanded: true,
                              icon: Icon(
                                Iconsax.arrow_right_3,
                                color: theme.background,
                              ),
                              items: accSubType.map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(
                                    value,
                                    style: const TextStyle(
                                      color: Color(0xFF5D5C5C),
                                    ),
                                  ),
                                );
                              }).toList(),
                              onChanged: (newValue) {
                                controller.selectedSubTypeTo.value = newValue;
                              },
                            )),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
            Align(
              alignment: Alignment.center,
              child: Container(
                height: 60,
                width: 60,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.grey.shade300),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: SvgPicture.string(AppSvgs.svgSwap),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
