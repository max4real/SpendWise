import 'package:flutter/material.dart';

class MaxTagsFields extends StatelessWidget {
  const MaxTagsFields({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
// Widget makeTagField() {
//     IncomeNewController controller = Get.find();
//     List<String> initialTags1 = <String>[...controller.categoryTags];
//     return Autocomplete<String>(
//       optionsViewBuilder: (context, onSelected, options) {
//         return Align(
//           alignment: Alignment.topLeft,
//           child: Card(
//             color: primary,
//             elevation: 4.0,
//             child: ConstrainedBox(
//               constraints: const BoxConstraints(maxHeight: 200, maxWidth: 250),
//               child: ListView.builder(
//                 shrinkWrap: true,
//                 itemCount: options.length,
//                 itemBuilder: (BuildContext context, int index) {
//                   final String option = options.elementAt(index);
//                   return TextButton(
//                     onPressed: () {
//                       onSelected(option);
//                     },
//                     child: Align(
//                       alignment: Alignment.centerLeft,
//                       child: Text(
//                         '#$option',
//                         textAlign: TextAlign.left,
//                         style: const TextStyle(
//                           color: Colors.black87,
//                         ),
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ),
//         );
//       },
//       optionsBuilder: (TextEditingValue textEditingValue) {
//         if (textEditingValue.text == '') {
//           return const Iterable<String>.empty();
//         }
//         return initialTags1.where((String option) {
//           return option.contains(textEditingValue.text.toLowerCase());
//         });
//       },
//       onSelected: (String selectedTag) {
//         controller.stringTagController.onTagSubmitted(selectedTag);
//       },
//       fieldViewBuilder:
//           (context, textEditingController, focusNode, onFieldSubmitted) {
//         return TextFieldTags<String>(
//           textEditingController: textEditingController,
//           focusNode: focusNode,
//           textfieldTagsController: controller.stringTagController,
//           // initialTags: const [],
//           textSeparators: const [' ', ','],
//           letterCase: LetterCase.normal,
//           validator: (String tag) {
//             if (controller.stringTagController.getTags!
//                 .contains(tag.toLowerCase())) {
//               return 'You\'ve already entered that';
//             }
//             return null;
//           },
//           inputFieldBuilder: (context, inputFieldValues) {
//             return TextField(
//               onTapOutside: (event) {
//                 dismissKeyboard();
//               },
//               style: const TextStyle(
//                 color: Colors.black,
//                 fontSize: 14,
//               ),
//               controller: inputFieldValues.textEditingController,
//               focusNode: inputFieldValues.focusNode,
//               decoration: InputDecoration(
//                 enabledBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(15),
//                   borderSide: const BorderSide(color: Colors.grey),
//                 ),
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(15),
//                 ),
//                 hintText: 'Tags',
//                 hintStyle: const TextStyle(
//                     color: Color(0XFF91919F), fontWeight: FontWeight.w400),
//                 isDense: true,
//                 errorText: inputFieldValues.error,
//                 prefixIcon: inputFieldValues.tags.isNotEmpty
//                     ? SingleChildScrollView(
//                         controller: inputFieldValues.tagScrollController,
//                         scrollDirection: Axis.horizontal,
//                         child: Row(
//                             children: inputFieldValues.tags.map((String tag) {
//                           return Card(
//                             child: Padding(
//                               padding: const EdgeInsets.all(5),
//                               child: Row(
//                                 children: [
//                                   SvgPicture.string(AppSvgs.svgGreenDot),
//                                   const SizedBox(width: 4.0),
//                                   InkWell(
//                                     child: Text(
//                                       tag,
//                                       style: const TextStyle(
//                                           color: Color(0xFF5D5C5C)),
//                                     ),
//                                     onTap: () {
//                                       inputFieldValues.onTagRemoved(tag);
//                                     },
//                                   ),
//                                   const SizedBox(width: 4.0),
//                                 ],
//                               ),
//                             ),
//                           );
//                         }).toList()),
//                       )
//                     : null,
//               ),
//               onChanged: inputFieldValues.onTagChanged,
//               onSubmitted: inputFieldValues.onTagSubmitted,
//             );
//           },
//         );
//       },
//     );
//   }