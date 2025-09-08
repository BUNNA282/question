import 'package:flutter/material.dart';
import 'package:flutter_app_game/config/app_colors.dart';
import 'package:flutter_app_game/config/app_styles.dart';
import 'package:flutter_app_game/widgets/background_pattern.dart';
import 'package:flutter_app_game/services/statistics_service.dart'; // NEW: Import StatisticsService

class ReportScreen extends StatefulWidget {
  const ReportScreen({super.key});

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  int _totalQuizzes = 0;
  int _totalQuestionsAnswered = 0;
  int _totalCorrectAnswers = 0;
  double _averageScorePercentage = 0.0;
  int _bestScore = 0;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadStatistics();
  }

  Future<void> _loadStatistics() async {
    setState(() {
      _isLoading = true;
    });

    _totalQuizzes = await StatisticsService.getTotalQuizzesPlayed();
    _totalQuestionsAnswered =
        await StatisticsService.getTotalQuestionsAnswered();
    _totalCorrectAnswers = await StatisticsService.getTotalCorrectAnswers();
    _averageScorePercentage =
        await StatisticsService.getAverageScorePercentage();
    _bestScore = await StatisticsService.getBestScore();

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('របាយការណ៍'),
        backgroundColor: AppColors.primaryDarkBlue,
        foregroundColor: AppColors.white,
        actions: [
          IconButton(
            // Optional: Add a refresh button
            icon: const Icon(Icons.refresh),
            onPressed: _loadStatistics,
          ),
          IconButton(
            // Optional: Add a clear data button for testing
            icon: const Icon(Icons.delete_sweep),
            onPressed: () async {
              await StatisticsService.clearAllQuizResults();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('បានលុបទិន្នន័យរបាយការណ៍ទាំងអស់ហើយ!'),
                ),
              );
              _loadStatistics(); // Reload to show empty state
            },
          ),
        ],
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
                : SingleChildScrollView(
                  // Use SingleChildScrollView for scrollability
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'ស្ថិតិរួមកម្មវិធី',
                        style: AppStyles.headerTextStyle.copyWith(
                          fontSize: 28,
                          color: AppColors.white,
                        ),
                      ),
                      const SizedBox(height: 30),
                      _buildStatisticCard(
                        icon: Icons.play_arrow,
                        title: 'ចំនួន Quiz ដែលបានលេង',
                        value: '$_totalQuizzes ដង',
                        color: AppColors.successGreen,
                      ),
                      _buildStatisticCard(
                        icon: Icons.question_answer,
                        title: 'ចំនួនសំណួរដែលបានឆ្លើយ',
                        value: '$_totalQuestionsAnswered សំណួរ',
                        color: AppColors.accentYellow,
                      ),
                      _buildStatisticCard(
                        icon: Icons.check_circle,
                        title: 'ចំនួនចម្លើយត្រឹមត្រូវ',
                        value: '$_totalCorrectAnswers ចម្លើយ',
                        color: AppColors.primaryLightBlue,
                      ),
                      _buildStatisticCard(
                        icon: Icons.bar_chart,
                        title: 'ពិន្ទុជាមធ្យម',
                        value: '${_averageScorePercentage.toStringAsFixed(2)}%',
                        color: AppColors.errorRed,
                      ),
                      _buildStatisticCard(
                        icon: Icons.emoji_events,
                        title: 'ពិន្ទុខ្ពស់បំផុត',
                        value: '$_bestScore ពិន្ទុ',
                        color:
                            AppColors
                                .accentYellow, // Reusing color for consistency
                      ),
                      const SizedBox(height: 20),
                      // You can add more sections here if needed, e.g., recent quiz history
                    ],
                  ),
                ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatisticCard({
    required IconData icon,
    required String title,
    required String value,
    required Color color,
  }) {
    return Card(
      color: AppColors.whiteOpacity(0.95),
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Icon(icon, size: 40, color: color),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryDarkBlue,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    value,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: color,
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
