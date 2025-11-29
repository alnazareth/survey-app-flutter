import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/survey_model.dart';

class SurveyRepository {
  final FirebaseFirestore _firestore;

  SurveyRepository({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;


  Future<void> initialize() async {
    try {
      await _firestore.enablePersistence(
        const PersistenceSettings(synchronizeTabs: true),
      );
      print(" offline test on");
    } catch (e) {
      print("⚠️ Error : $e");
    }
  }


  Stream<List<Survey>> getSurveys() {
    return _firestore
        .collection('surveys')
        .snapshots()
        .map((snapshot) => snapshot.docs
        .map((doc) => Survey.fromMap(doc.id, doc.data()))
        .toList());
  }


  Future<void> submitSurveyResponse({
    required String surveyId,
    required Map<String, dynamic> answers,
  }) async {
    try {
      final responseData = {
        'createdAt': Timestamp.now(),
        'answers': answers,
        'surveyId': surveyId,
      };

      await _firestore
          .collection('surveys')
          .doc(surveyId)
          .collection('responses')
          .add(responseData);

      print(": $surveyId");
    } catch (e) {
      print("Error : $e");
      throw Exception('Error submitting response: $e');
    }
  }
}