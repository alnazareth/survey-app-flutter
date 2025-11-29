import 'package:flutter/material.dart';

class CommentsField extends StatelessWidget {
  final ValueChanged<String> onSaved;

  const CommentsField({super.key, required this.onSaved});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: const InputDecoration(
        labelText: 'Comments',
        border: OutlineInputBorder(),
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
      maxLines: 4,
      onSaved: (value) => onSaved(value ?? ''),
    );
  }
}