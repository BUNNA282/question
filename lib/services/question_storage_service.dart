import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_app_game/data/quiz_data.dart';
import 'package:flutter_app_game/models/question.dart';

class QuestionStorageService {
  static const String _savedQuestionsKey = 'saved_question_ids';
  static const String _favoriteQuestionsKey = 'favorite_question_ids';

  // Helper function to get all questions by ID
  static Map<String, Question> _getAllQuestionsMap() {
    final Map<String, Question> allQuestionsMap = {};
    categorizedQuizQuestions.forEach((category, questions) {
      for (var q in questions) {
        allQuestionsMap[q.id] = q;
      }
    });
    return allQuestionsMap;
  }

  // --- Saved Questions (បានរក្សាទុក) ---
  static Future<List<String>> getSavedQuestionIds() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_savedQuestionsKey) ?? [];
  }

  static Future<List<Question>> getSavedQuestions() async {
    final List<String> ids = await getSavedQuestionIds();
    final Map<String, Question> allQuestions = _getAllQuestionsMap();
    return ids.map((id) => allQuestions[id]).whereType<Question>().toList();
  }

  static Future<void> toggleSavedQuestion(String questionId) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> ids = await getSavedQuestionIds();
    if (ids.contains(questionId)) {
      ids.remove(questionId);
    } else {
      ids.add(questionId);
    }
    await prefs.setStringList(_savedQuestionsKey, ids);
  }

  static Future<bool> isQuestionSaved(String questionId) async {
    final List<String> ids = await getSavedQuestionIds();
    return ids.contains(questionId);
  }

  // --- Favorite Questions (ចូលចិត្ត) ---
  static Future<List<String>> getFavoriteQuestionIds() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_favoriteQuestionsKey) ?? [];
  }

  static Future<List<Question>> getFavoriteQuestions() async {
    final List<String> ids = await getFavoriteQuestionIds();
    final Map<String, Question> allQuestions = _getAllQuestionsMap();
    return ids.map((id) => allQuestions[id]).whereType<Question>().toList();
  }

  static Future<void> toggleFavoriteQuestion(String questionId) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> ids = await getFavoriteQuestionIds();
    if (ids.contains(questionId)) {
      ids.remove(questionId);
    } else {
      ids.add(questionId);
    }
    await prefs.setStringList(_favoriteQuestionsKey, ids);
  }

  static Future<bool> isQuestionFavorite(String questionId) async {
    final List<String> ids = await getFavoriteQuestionIds();
    return ids.contains(questionId);
  }
}
