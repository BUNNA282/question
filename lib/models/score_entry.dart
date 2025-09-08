import 'dart:convert';

class ScoreEntry {
  final String name;
  final int score;
  final DateTime date;

  ScoreEntry({required this.name, required this.score, required this.date});

  // Convert a ScoreEntry into a Map. The keys must correspond to the names of the
  // columns in the database.
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'score': score,
      'date': date.toIso8601String(), // Convert DateTime to String for storage
    };
  }

  // Create a ScoreEntry from a Map (retrieved from storage)
  factory ScoreEntry.fromJson(Map<String, dynamic> json) {
    return ScoreEntry(
      name: json['name'] as String,
      score: json['score'] as int,
      date: DateTime.parse(
        json['date'] as String,
      ), // Convert String back to DateTime
    );
  }

  // Helper to convert list of ScoreEntry to JSON string
  static String encode(List<ScoreEntry> scores) => json.encode(
    scores.map<Map<String, dynamic>>((score) => score.toJson()).toList(),
  );

  // Helper to convert JSON string to list of ScoreEntry
  static List<ScoreEntry> decode(String scoresJson) =>
      (json.decode(scoresJson) as List<dynamic>)
          .map<ScoreEntry>(
            (item) => ScoreEntry.fromJson(item as Map<String, dynamic>),
          )
          .toList();
}
