import 'package:flutter/material.dart';
import 'package:meme_generator/constants/form_decoration.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final String hintText;
  final TextInputType keyboardType;
  final bool obscureText;
  final List<CustomTextFormField> forms = [];
  CustomTextFormField(
      {super.key, required this.controller,
      required this.hintText,
      this.keyboardType = TextInputType.text,
      this.obscureText = false,
      required this.labelText,});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 8),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        obscureText: obscureText,
        decoration: textInputDecoration.copyWith(
            hintText: hintText, labelText: labelText),
      ),
    );
  }
}
