import 'package:flutter/services.dart';

class CPFCNPJmask extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String finalText = newValue.text;
    finalText =
        newValue.text.replaceAll(RegExp(r"[^0-9]", caseSensitive: false), '');
    int tamanho = finalText.length;
    if (tamanho <= 11) {
      if (tamanho > 3) {
        finalText = finalText.substring(0, 3) + "." + finalText.substring(3);
      }
      if (tamanho > 6) {
        finalText = finalText.substring(0, 7) + "." + finalText.substring(7);
      }
      if (tamanho >= 10) {
        finalText = finalText.substring(0, 11) + "-" + finalText.substring(11);
      }
    } else if (tamanho > 11 && tamanho <= 14) {
      if (tamanho >= 12) {
        finalText = finalText.substring(0, 2) +
            '.' +
            finalText.substring(2, 5) +
            '.' +
            finalText.substring(5, 8) +
            '/' +
            finalText.substring(8);
      }
      if (tamanho > 12) {
        finalText = finalText.substring(0, 15) + '-' + finalText.substring(15);
      }
    } else {
      finalText = oldValue.text;
    }

    return TextEditingValue(
        text: finalText.toString(),
        selection:
            TextSelection.fromPosition(TextPosition(offset: finalText.length)));
  }
}
