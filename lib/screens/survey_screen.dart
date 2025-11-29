import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/survey_provider.dart';
import '../data/models/survey_model.dart';
import '../widgets/survey_form.dart';
import 'confirmation_screen.dart';

class SurveyScreen extends StatefulWidget {
  final Survey survey;

  const SurveyScreen({super.key, required this.survey});

  @override
  State<SurveyScreen> createState() => _SurveyScreenState();
}

class _SurveyScreenState extends State<SurveyScreen> {
  final _formKey = GlobalKey<FormState>();

  void _submitSurvey(Map<String, dynamic> answers) async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final surveyProvider = context.read<SurveyProvider>();

      answers.forEach((key, value) {
        surveyProvider.updateAnswer(key, value);
      });
      surveyProvider.updateAnswers(answers);
      final success = await surveyProvider.submitCurrentSurvey();

      if (success && mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => ConfirmationScreen(
              surveyTitle: widget.survey.title,
              answers: answers,
            ),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final surveyProvider = context.watch<SurveyProvider>();

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.survey.title),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: surveyProvider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.survey.title,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              widget.survey.description,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 24),
            if (surveyProvider.error != null)
              Container(
                padding: const EdgeInsets.all(16),
                margin: const EdgeInsets.only(bottom: 16),
                color: Colors.red[50],
                child: Row(
                  children: [
                    const Icon(Icons.error, color: Colors.red),
                    const SizedBox(width: 8),
                    Expanded(child: Text(surveyProvider.error!)),
                  ],
                ),
              ),
            SurveyForm(
              formKey: _formKey,
              onSubmit: _submitSurvey,
            ),
          ],
        ),
      ),
    );
  }
}