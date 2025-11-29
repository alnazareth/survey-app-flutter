import 'package:flutter/foundation.dart';
import '../data/models/survey_model.dart';
import '../data/repositories/survey_repository.dart';

class SurveyProvider with ChangeNotifier {
  final SurveyRepository _repository;
  List<Survey> _surveys = [];
  Survey? _currentSurvey;
  Map<String, dynamic> _currentAnswers = {};
  bool _isLoading = false;
  String? _error;


  List<Survey> get surveys => _surveys;
  Survey? get currentSurvey => _currentSurvey;
  Map<String, dynamic> get currentAnswers => _currentAnswers;
  bool get isLoading => _isLoading;
  String? get error => _error;

  SurveyProvider(this._repository) {
    _loadSurveys();
  }


  Future<void> _loadSurveys() async {
    try {
      setLoading(true);

      _repository.getSurveys().listen((surveys) {
        _surveys = surveys;
        notifyListeners();
      });
    } catch (e) {
      setError('Error loading surveys: $e');
    } finally {
      setLoading(false);
    }
  }


  void setCurrentSurvey(Survey survey) {
    _currentSurvey = survey;
    _currentAnswers = {};
    _error = null;
    notifyListeners();
  }


  void updateAnswer(String question, dynamic answer) {
    _currentAnswers[question] = answer;
    notifyListeners();
  }

  void updateAnswers(Map<String, dynamic> answers) {
    _currentAnswers = Map.from(answers);
    notifyListeners();
  }


  Future<bool> submitCurrentSurvey() async {
    if (_currentSurvey == null) return false;

    try {
      setLoading(true);
      setError(null);

      await _repository.submitSurveyResponse(
        surveyId: _currentSurvey!.id!,
        answers: _currentAnswers,
      );

      return true;
    } catch (e) {
      setError('Error submitting survey: $e');
      return false;
    } finally {
      setLoading(false);
    }
  }

  void setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void setError(String? error) {
    _error = error;
    notifyListeners();
  }
}