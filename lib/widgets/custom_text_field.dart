import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final String? Function(String?)? validator;
  final void Function(String?)? onSaved;
  final int maxLines;

  const CustomTextField({
    super.key,
    required this.label,
    this.validator,
    this.onSaved,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
      ),
      validator: validator,
      onSaved: onSaved,
      maxLines: maxLines,
    );
  }
}