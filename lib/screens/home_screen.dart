import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/survey_provider.dart';
import '../data/models/survey_model.dart'; // ← AGREGAR ESTE IMPORT
import 'survey_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final surveyProvider = context.watch<SurveyProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Surveys'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: _buildBody(surveyProvider),
    );
  }

  Widget _buildBody(SurveyProvider provider) {
    if (provider.isLoading && provider.surveys.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    if (provider.error != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error, size: 64, color: Colors.red),
            const SizedBox(height: 16),
            Text('Error: ${provider.error}'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => _loadSurveys(provider),
              child: const Text('Try again'),
            ),
          ],
        ),
      );
    }

    if (provider.surveys.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.assignment, size: 64, color: Colors.grey),
            SizedBox(height: 16),
            Text('No surveys available'),
                      ],
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView.builder(
        itemCount: provider.surveys.length,
        itemBuilder: (context, index) {
          final survey = provider.surveys[index];
          return _buildSurveyCard(context, survey);
        },
      ),
    );
  }


  void _loadSurveys(SurveyProvider provider) {
   provider.setError(null);
  }

  Widget _buildSurveyCard(BuildContext context, Survey survey) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.only(bottom: 16),
      child: InkWell(
        onTap: () {
          context.read<SurveyProvider>().setCurrentSurvey(survey);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SurveyScreen(survey: survey),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              const Icon(Icons.assignment, size: 40, color: Colors.blue),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      survey.title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      survey.description,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.arrow_forward_ios, size: 16),
            ],
          ),
        ),
      ),
    );
  }
}