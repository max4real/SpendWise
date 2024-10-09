import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class CommaTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final text = newValue.text.replaceAll(',', ''); // Remove existing commas
    if (text.isEmpty) {
      return newValue.copyWith(text: '');
    }

    // Add commas in every 3 digits
    final newText = NumberFormat.decimalPattern().format(int.parse(text));

    return newValue.copyWith(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}
