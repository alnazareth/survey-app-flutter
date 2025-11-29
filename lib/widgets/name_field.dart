import 'package:flutter/material.dart';

class NameField extends StatelessWidget {
  final ValueChanged<String> onSaved;

  const NameField({super.key, required this.onSaved});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: const InputDecoration(
        labelText: 'NAme',
        border: OutlineInputBorder(),
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Type your name here';
        }
        return null;
      },
      onSaved: (value) => onSaved(value ?? ''),
    );
  }
}