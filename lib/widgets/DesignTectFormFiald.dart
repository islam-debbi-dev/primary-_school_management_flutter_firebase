import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final TextInputType keyboardType;

  const CustomTextFormField({
    super.key,
    required this.controller,
    required this.labelText,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: labelText,
          alignLabelWithHint: true,
          contentPadding: const EdgeInsets.symmetric(vertical: 15),
        ),
        keyboardType: keyboardType,
        textAlign: TextAlign.center,
      ),
    );
  }
}
