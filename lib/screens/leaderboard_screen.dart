// lib/screens/leaderboard_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_app_game/config/app_colors.dart';
import 'package:flutter_app_game/config/app_styles.dart';
import 'package:flutter_app_game/widgets/background_pattern.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_app_game/models/score_entry.dart';

class LeaderboardScreen extends StatefulWidget {
  const LeaderboardScreen({super.key});

  @override
  State<LeaderboardScreen> createState() => _LeaderboardScreenState();
}

class _LeaderboardScreenState extends State<LeaderboardScreen> {
  List<ScoreEntry> _scores = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadScores();
  }

  Future<void> _loadScores() async {
    final prefs = await SharedPreferences.getInstance();
    final String? scoresJson = prefs.getString('leaderboard_scores');

    if (scoresJson != null) {
      setState(() {
        _scores = ScoreEntry.decode(scoresJson);
        _isLoading = false;
      });
    } else {
      setState(() {
        _isLoading = false;
      });
    }
  }

  // NEW: Function to remove a score entry
  Future<void> _removeScoreEntry(int indexToRemove) async {
    setState(() {
      _scores.removeAt(indexToRemove); // Remove from current list
    });

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      'leaderboard_scores',
      ScoreEntry.encode(_scores),
    ); // Save updated list

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('ធាតុពិន្ទុត្រូវបានលុបដោយជោគជ័យ!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('តារាងពិន្ទុ (ចាត់ថ្នាក់)'),
        backgroundColor: AppColors.primaryDarkBlue,
        foregroundColor: AppColors.white,
      ),
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
            _isLoading
                ? const Center(
                  child: CircularProgressIndicator(
                    color: AppColors.accentYellow,
                  ),
                )
                : _scores.isEmpty
                ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.leaderboard,
                        size: 80,
                        color: AppColors.accentYellow,
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'មិនទាន់មានទិន្នន័យពិន្ទុ',
                        style: AppStyles.headerTextStyle.copyWith(fontSize: 24),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'លេង Quiz ដើម្បីចាប់ផ្តើមបង្ហាញពិន្ទុនៅទីនេះ!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppColors.whiteOpacity(0.8),
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                )
                : Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'ពិន្ទុខ្ពស់បំផុត',
                        style: AppStyles.headerTextStyle.copyWith(
                          fontSize: 26,
                          color: AppColors.white,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Expanded(
                        child: ListView.builder(
                          itemCount: _scores.length,
                          itemBuilder: (context, index) {
                            final entry = _scores[index];
                            return Card(
                              color: AppColors.whiteOpacity(0.9),
                              margin: const EdgeInsets.symmetric(vertical: 8.0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: ListTile(
                                leading: CircleAvatar(
                                  backgroundColor: AppColors.primaryDarkBlue,
                                  child: Text(
                                    '${index + 1}',
                                    style: const TextStyle(
                                      color: AppColors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                title: Text(
                                  entry.name,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.primaryDarkBlue,
                                  ),
                                ),
                                subtitle: Text(
                                  '${entry.date.day}/${entry.date.month}/${entry.date.year}',
                                  style: TextStyle(
                                    color: AppColors.primaryDarkBlue
                                        .withOpacity(0.7),
                                  ),
                                ),
                                trailing: Row(
                                  // NEW: Use Row to contain multiple trailing widgets
                                  mainAxisSize:
                                      MainAxisSize
                                          .min, // Make row only as wide as its children
                                  children: [
                                    Text(
                                      '${entry.score} ពិន្ទុ',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.successGreen,
                                      ),
                                    ),
                                    IconButton(
                                      // NEW: Delete button
                                      icon: const Icon(
                                        Icons.delete,
                                        color: AppColors.errorRed,
                                      ),
                                      onPressed: () => _removeScoreEntry(index),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
          ],
        ),
      ),
    );
  }
}
