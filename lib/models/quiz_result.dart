import 'dart:convert';

class QuizResult {
  final int score;
  final int totalQuestions;
  final DateTime date;

  QuizResult({
    required this.score,
    required this.totalQuestions,
    required this.date,
  });

  // Convert a QuizResult into a Map.
  Map<String, dynamic> toJson() {
    return {
      'score': score,
      'totalQuestions': totalQuestions,
      'date': date.toIso8601String(),
    };
  }

  // Create a QuizResult from a Map.
  factory QuizResult.fromJson(Map<String, dynamic> json) {
    return QuizResult(
      score: json['score'] as int,
      totalQuestions: json['totalQuestions'] as int,
      date: DateTime.parse(json['date'] as String),
    );
  }

  // Helper to convert list of QuizResult to JSON string
  static String encode(List<QuizResult> results) => json.encode(
    results.map<Map<String, dynamic>>((result) => result.toJson()).toList(),
  );

  // Helper to convert JSON string to list of QuizResult
  static List<QuizResult> decode(String resultsJson) =>
      (json.decode(resultsJson) as List<dynamic>)
          .map<QuizResult>(
            (item) => QuizResult.fromJson(item as Map<String, dynamic>),
          )
          .toList();
}
