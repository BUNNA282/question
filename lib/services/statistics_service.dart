// ignore_for_file: unnecessary_cast

import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_app_game/models/quiz_result.dart'; // Import QuizResult

class StatisticsService {
  static const String _allQuizResultsKey = 'all_quiz_results';
  static const String _leaderboardScoresKey =
      'leaderboard_scores'; // To get best score

  static Future<List<QuizResult>> getAllQuizResults() async {
    final prefs = await SharedPreferences.getInstance();
    final String? resultsJson = prefs.getString(_allQuizResultsKey);
    if (resultsJson != null) {
      return QuizResult.decode(resultsJson);
    }
    return [];
  }

  static Future<int> getTotalQuizzesPlayed() async {
    final List<QuizResult> results = await getAllQuizResults();
    return results.length;
  }

  static Future<int> getTotalQuestionsAnswered() async {
    final List<QuizResult> results = await getAllQuizResults();
    return results.fold<int>(0, (sum, result) => sum + result.totalQuestions);
  }

  static Future<int> getTotalCorrectAnswers() async {
    final List<QuizResult> results = await getAllQuizResults();
    return results.fold<int>(0, (sum, result) => sum + (result.score as int));
  }

  static Future<double> getAverageScorePercentage() async {
    final List<QuizResult> results = await getAllQuizResults();
    if (results.isEmpty) return 0.0;

    int totalScore = results.fold(0, (sum, result) => sum + result.score);
    int totalPossibleScore = results.fold(
      0,
      (sum, result) => sum + result.totalQuestions,
    );

    if (totalPossibleScore == 0) return 0.0;

    return (totalScore / totalPossibleScore) * 100;
  }

  static Future<int> getBestScore() async {
    final prefs = await SharedPreferences.getInstance();
    final String? leaderboardJson = prefs.getString(_leaderboardScoresKey);

    if (leaderboardJson != null) {
      final List<dynamic> decoded = jsonDecode(leaderboardJson);
      if (decoded.isNotEmpty) {
        // Leaderboard scores are already sorted by score descending
        return decoded.first['score'] as int;
      }
    }
    return 0;
  }

  // Optional: Function to clear all quiz results (for development/reset)
  static Future<void> clearAllQuizResults() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_allQuizResultsKey);
  }
}
