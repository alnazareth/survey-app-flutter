import 'package:flutter/material.dart';

class EmailField extends StatelessWidget {
  final ValueChanged<String> onSaved;

  const EmailField({super.key, required this.onSaved});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: const InputDecoration(
        labelText: 'Email',
        border: OutlineInputBorder(),
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'type your email';
        }
        if (!value.contains('@')) {
          return 'Type a valid email';
        }
        return null;
      },
      onSaved: (value) => onSaved(value ?? ''),
    );
  }
}