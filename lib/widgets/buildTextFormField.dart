import 'package:flutter/material.dart';

buildTextFormField(
    {required String hintText,
    required IconData perfixIcon,
    IconData? sufix,
      void Function(String)? onChanged,
    // void Function(String?)? onSaved,
    // String? Function(String?)? validator,
    required TextEditingController controller}) {
  return TextFormField(
    onChanged: onChanged,
    validator: (input) {
      if (controller.text.isEmpty) {
        return ('$hintText is required');
      } else {
        return null;
      }
    },
    controller: controller,
    // onSaved: onSaved,
    decoration: InputDecoration(
        hintText: (hintText),
        prefixIcon: Icon(
          perfixIcon,
          color: Colors.blue, // Set the color to blue
        ),
        suffixIcon: Icon(
          sufix,
          color: Colors.blue, // Set the color to blue
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15))),
  );
}
