import 'package:flutter/services.dart';

class NoTrailingSpaceFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    // Check if the new text ends with a space
    if (newValue.text.isNotEmpty && newValue.text.endsWith(' ')) {
      // Remove the trailing space
      String trimmedText = newValue.text.trimRight();
      // Calculate the new selection index after trimming
      int selectionIndex = newValue.selection.baseOffset -
          (newValue.text.length - trimmedText.length);
      return TextEditingValue(
        text: trimmedText,
        selection: TextSelection.collapsed(offset: selectionIndex),
      );
    }
    return newValue;
  }
}
