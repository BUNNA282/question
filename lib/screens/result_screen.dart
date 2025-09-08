import 'package:flutter/material.dart';
import 'package:flutter_app_game/config/app_colors.dart';
import 'package:flutter_app_game/config/app_styles.dart';
import 'package:flutter_app_game/widgets/background_pattern.dart';
import 'package:flutter_app_game/screens/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_app_game/models/score_entry.dart';
import 'package:flutter_app_game/models/quiz_result.dart'; // NEW: Import QuizResult model

class ResultScreen extends StatefulWidget {
  final int score;
  final int totalQuestions;

  const ResultScreen({
    super.key,
    required this.score,
    required this.totalQuestions,
  });

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  final TextEditingController _nameController = TextEditingController();
  bool _scoreSaved = false;
  bool _quizResultRecorded =
      false; // NEW: To ensure quiz result is recorded once

  @override
  void initState() {
    super.initState();
    _recordQuizResult(); // NEW: Record quiz result when screen initializes
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  // NEW: Function to record quiz result
  Future<void> _recordQuizResult() async {
    if (_quizResultRecorded) return; // Prevent double recording

    final prefs = await SharedPreferences.getInstance();
    final String key = 'all_quiz_results';
    final String? existingResultsJson = prefs.getString(key);

    List<QuizResult> results = [];
    if (existingResultsJson != null) {
      results = QuizResult.decode(existingResultsJson);
    }

    final newQuizResult = QuizResult(
      score: widget.score,
      totalQuestions: widget.totalQuestions,
      date: DateTime.now(),
    );

    results.add(newQuizResult);
    await prefs.setString(key, QuizResult.encode(results));

    setState(() {
      _quizResultRecorded = true;
    });
    // print('Quiz Result Recorded: Score ${widget.score}, Total ${widget.totalQuestions}'); // For debugging
  }

  Future<void> _saveScore() async {
    if (_nameController.text.trim().isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('សូមបញ្ចូលឈ្មោះរបស់អ្នក!')));
      return;
    }

    final prefs = await SharedPreferences.getInstance();
    final String key = 'leaderboard_scores';
    final String? existingScoresJson = prefs.getString(key);

    List<ScoreEntry> scores = [];
    if (existingScoresJson != null) {
      scores = ScoreEntry.decode(existingScoresJson);
    }

    final newScoreEntry = ScoreEntry(
      name: _nameController.text.trim(),
      score: widget.score,
      date: DateTime.now(),
    );

    scores.add(newScoreEntry);
    scores.sort(
      (a, b) => b.score.compareTo(a.score),
    ); // Sort by score descending

    // Optionally keep only top N scores, e.g., top 10
    if (scores.length > 10) {
      scores = scores.sublist(0, 10);
    }

    await prefs.setString(key, ScoreEntry.encode(scores));

    setState(() {
      _scoreSaved = true;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('ពិន្ទុរបស់អ្នកត្រូវបានរក្សាទុកហើយ!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.primaryDarkBlue, AppColors.primaryLightBlue],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Stack(
          children: [
            const BackgroundPattern(),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.emoji_events, // Trophy icon
                      size: 100,
                      color: AppColors.accentYellow,
                    ),
                    const SizedBox(height: 20),
                    Text('លទ្ធផលរបស់អ្នក', style: AppStyles.headerTextStyle),
                    const SizedBox(height: 10),
                    Text(
                      'អ្នកបានឆ្លើយត្រូវ ${widget.score} ក្នុងចំណោម ${widget.totalQuestions} សំណួរ!',
                      textAlign: TextAlign.center,
                      style: AppStyles.resultTextStyle,
                    ),
                    const SizedBox(height: 40),

                    // Name input for leaderboard
                    if (!_scoreSaved) ...[
                      TextField(
                        controller: _nameController,
                        style: const TextStyle(
                          color: AppColors.primaryDarkBlue,
                        ),
                        decoration: InputDecoration(
                          hintText: 'បញ្ចូលឈ្មោះរបស់អ្នក...',
                          hintStyle: TextStyle(
                            color: AppColors.primaryDarkBlue.withOpacity(0.7),
                          ),
                          filled: true,
                          fillColor: AppColors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 15,
                          ),
                        ),
                        maxLength: 15,
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: _saveScore,
                        style: AppStyles.primaryButtonStyle.copyWith(
                          backgroundColor: MaterialStateProperty.all(
                            AppColors.successGreen,
                          ),
                        ),
                        child: const Text(
                          'រក្សាទុកពិន្ទុ',
                          style: TextStyle(color: AppColors.white),
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],

                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder:
                                (context) =>
                                    HomeScreen(setLocale: (Locale locale) {}),
                          ),
                          (route) => false,
                        );
                      },
                      style: AppStyles.primaryButtonStyle,
                      child: const Text('ត្រឡប់ទៅទំព័រដើម'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
