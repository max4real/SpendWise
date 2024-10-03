import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:iconsax/iconsax.dart';
import 'package:spend_wise/_common/constants/app_svg.dart';
import 'package:spend_wise/_common/data/data_controller.dart';
import 'package:spend_wise/_servies/theme_services/d_dark_theme.dart';
import 'package:spend_wise/_servies/theme_services/w_custon_theme_builder.dart';
import 'package:get/get.dart';
import 'package:spend_wise/modules/create_new/income_new/c_income_new.dart';
import 'package:textfield_tags/textfield_tags.dart';

class IncomeNewPage extends StatelessWidget {
  const IncomeNewPage({super.key});

  @override
  Widget build(BuildContext context) {
    IncomeNewController controller = Get.put(IncomeNewController());
    return MaxThemeBuilder(
      builder: (context, theme, themeController) {
        return Scaffold(
          // resizeToAvoidBottomInset: true,
          backgroundColor: incomeColor,
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: incomeColor,
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
              'Income',
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
                  // height: Get.height-250,
                  height: MediaQuery.of(context).size.height - 250,
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
                        makeTagField(),
                        const SizedBox(height: 20),
                        TextField(
                          onTapOutside: (event) {
                            dismissKeyboard();
                          },
                          controller: controller.txtDescription,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: const BorderSide(color: Colors.grey),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            hintText: 'Description',
                            hintStyle: const TextStyle(
                                color: Color(0XFF91919F),
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                        const SizedBox(height: 30),
                        TextField(
                          onTapOutside: (event) {
                            dismissKeyboard();
                          },
                          controller: controller.txtWallet,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: const BorderSide(color: Colors.grey),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            hintText: 'Wallet',
                            hintStyle: const TextStyle(
                              color: Color(0XFF91919F),
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),
                        GestureDetector(
                          onTap: () {
                            // Get.to(() => const VerificationPage());
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

  Widget makeTagField() {
    IncomeNewController controller = Get.find();
    List<String> initialTags1 = <String>[...controller.categoryTags];
    return Autocomplete<String>(
      optionsViewBuilder: (context, onSelected, options) {
        return Align(
          alignment: Alignment.topLeft,
          child: Card(
            color: primary,
            elevation: 4.0,
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 200, maxWidth: 250),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: options.length,
                itemBuilder: (BuildContext context, int index) {
                  final String option = options.elementAt(index);
                  return TextButton(
                    onPressed: () {
                      onSelected(option);
                    },
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        '#$option',
                        textAlign: TextAlign.left,
                        style: const TextStyle(
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        );
      },
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text == '') {
          return const Iterable<String>.empty();
        }
        return initialTags1.where((String option) {
          return option.contains(textEditingValue.text.toLowerCase());
        });
      },
      onSelected: (String selectedTag) {
        controller.stringTagController.onTagSubmitted(selectedTag);
      },
      fieldViewBuilder:
          (context, textEditingController, focusNode, onFieldSubmitted) {
        return TextFieldTags<String>(
          textEditingController: textEditingController,
          focusNode: focusNode,
          textfieldTagsController: controller.stringTagController,
          // initialTags: const [],
          textSeparators: const [' ', ','],
          letterCase: LetterCase.normal,
          validator: (String tag) {
            if (controller.stringTagController.getTags!
                .contains(tag.toLowerCase())) {
              return 'You\'ve already entered that';
            }
            return null;
          },
          inputFieldBuilder: (context, inputFieldValues) {
            return TextField(
              onTapOutside: (event) {
                dismissKeyboard();
              },
              style: const TextStyle(
                color: Colors.black,
                fontSize: 14,
              ),
              controller: inputFieldValues.textEditingController,
              focusNode: inputFieldValues.focusNode,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: const BorderSide(color: Colors.grey),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                hintText: 'Tags',
                hintStyle: const TextStyle(
                    color: Color(0XFF91919F), fontWeight: FontWeight.w400),
                isDense: true,
                errorText: inputFieldValues.error,
                prefixIcon: inputFieldValues.tags.isNotEmpty
                    ? SingleChildScrollView(
                        controller: inputFieldValues.tagScrollController,
                        scrollDirection: Axis.horizontal,
                        child: Row(
                            children: inputFieldValues.tags.map((String tag) {
                          return Card(
                            child: Padding(
                              padding: const EdgeInsets.all(5),
                              child: Row(
                                children: [
                                  SvgPicture.string(AppSvgs.svgGreenDot),
                                  const SizedBox(width: 4.0),
                                  InkWell(
                                    child: Text(
                                      tag,
                                      style:
                                          const TextStyle(color: Color(0xFF5D5C5C)),
                                    ),
                                    onTap: () {
                                      inputFieldValues.onTagRemoved(tag);
                                    },
                                  ),
                                  const SizedBox(width: 4.0),
                                ],
                              ),
                            ),
                          );
                        }).toList()),
                      )
                    : null,
              ),
              onChanged: inputFieldValues.onTagChanged,
              onSubmitted: inputFieldValues.onTagSubmitted,
            );
          },
        );
      },
    );
  }
}
