import 'package:flutter/material.dart';

class SignWidgets {
  static Widget inputField(TextEditingController controller,
      TextInputType keyboardType, bool obscureText) {
    return TextField(
        controller: controller,
        keyboardType: keyboardType,
        autocorrect: false,
        obscureText: obscureText);
  }

  static Widget formButton(Function() onPressed, String text) {
    return TextButton(onPressed: onPressed, child: Text(text));
  }
}
