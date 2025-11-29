import 'package:cloud_firestore/cloud_firestore.dart'; // ← AGREGAR ESTE IMPORT

class Survey {
  final String? id;
  final String title;
  final String description;

  Survey({
    this.id,
    required this.title,
    required this.description,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
    };
  }

  factory Survey.fromMap(String id, Map<String, dynamic> map) {
    return Survey(
      id: id,
      title: map['title'] ?? '',
      description: map['description'] ?? '',
    );
  }
}

class SurveyResponse {
  final String? id;
  final String surveyId;
  final Map<String, dynamic> answers;
  final Timestamp createdAt;

  SurveyResponse({
    this.id,
    required this.surveyId,
    required this.answers,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'surveyId': surveyId,
      'answers': answers,
      'createdAt': createdAt,
    };
  }


  factory SurveyResponse.fromMap(String id, Map<String, dynamic> map) {
    return SurveyResponse(
      id: id,
      surveyId: map['surveyId'] ?? '',
      answers: Map<String, dynamic>.from(map['answers'] ?? {}),
      createdAt: map['createdAt'] ?? Timestamp.now(),
    );
  }
}