class Question {
  final String id; // NEW: Add a unique ID for each question
  final String questionText;
  final List<String> options;
  final int correctAnswerIndex;

  const Question({
    required this.id, // NEW: Make ID required
    required this.questionText,
    required this.options,
    required this.correctAnswerIndex,
  });

  String? get correctAnswer => null;
}
