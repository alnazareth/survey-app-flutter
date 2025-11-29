import 'package:flutter/material.dart';
import 'name_field.dart';
import 'email_field.dart';
import 'comments_field.dart';
import 'rating_field.dart';

class SurveyForm extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final Function(Map<String, dynamic>) onSubmit;

  const SurveyForm({
    super.key,
    required this.formKey,
    required this.onSubmit,
  });

  @override
  State<SurveyForm> createState() => _SurveyFormState();
}

class _SurveyFormState extends State<SurveyForm> {
  final Map<String, dynamic> _answers = {};

  void _submitForm() {

    if (_answers['calificacion'] == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Select a valid rating value'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // Validar el formulario completo
    if (widget.formKey.currentState!.validate()) {
      widget.formKey.currentState!.save();
      widget.onSubmit(_answers);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        children: [

          NameField(
            onSaved: (value) => _answers['nombre'] = value,
          ),
          const SizedBox(height: 16),

          EmailField(
            onSaved: (value) => _answers['email'] = value,
          ),
          const SizedBox(height: 16),

          CommentsField(
            onSaved: (value) => _answers['comentarios'] = value,
          ),
          const SizedBox(height: 16),

          RatingField(
            onRatingSelected: (rating) => _answers['calificacion'] = rating,
          ),
          const SizedBox(height: 32),

          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _submitForm,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Text(
                'Send',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}