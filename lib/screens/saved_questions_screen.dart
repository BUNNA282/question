import 'package:flutter/material.dart';
import 'package:flutter_app_game/config/app_colors.dart';
import 'package:flutter_app_game/config/app_styles.dart';
import 'package:flutter_app_game/widgets/background_pattern.dart';
import 'package:flutter_app_game/models/question.dart';
import 'package:flutter_app_game/services/question_storage_service.dart'; // Import the service

class SavedQuestionsScreen extends StatefulWidget {
  const SavedQuestionsScreen({super.key});

  @override
  State<SavedQuestionsScreen> createState() => _SavedQuestionsScreenState();
}

class _SavedQuestionsScreenState extends State<SavedQuestionsScreen> {
  List<Question> _savedQuestions = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadSavedQuestions();
  }

  Future<void> _loadSavedQuestions() async {
    final questions = await QuestionStorageService.getSavedQuestions();
    setState(() {
      _savedQuestions = questions;
      _isLoading = false;
    });
  }

  // Optional: Function to remove a question from saved list directly from this screen
  void _removeQuestion(String questionId) async {
    await QuestionStorageService.toggleSavedQuestion(questionId);
    _loadSavedQuestions(); // Reload list after removal
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('បានលុបសំណួរចេញពីបញ្ជីរក្សាទុកហើយ!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('សំណួរដែលបានរក្សាទុក'),
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
                : _savedQuestions.isEmpty
                ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.archive,
                        size: 80,
                        color: AppColors.accentYellow,
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'មិនទាន់មានសំណួរបានរក្សាទុក',
                        style: AppStyles.headerTextStyle.copyWith(fontSize: 24),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'ចុចរូបសញ្ញា Bookmark នៅក្នុង Quiz ដើម្បីរក្សាទុកសំណួរ។',
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
                        'សំណួរដែលអ្នកបានរក្សាទុក:',
                        style: AppStyles.headerTextStyle.copyWith(
                          fontSize: 26,
                          color: AppColors.white,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Expanded(
                        child: ListView.builder(
                          itemCount: _savedQuestions.length,
                          itemBuilder: (context, index) {
                            final question = _savedQuestions[index];
                            return Card(
                              color: AppColors.whiteOpacity(0.9),
                              margin: const EdgeInsets.symmetric(vertical: 8.0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: ListTile(
                                title: Text(
                                  question.questionText,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.primaryDarkBlue,
                                  ),
                                ),
                                subtitle: Text(
                                  question.options[question
                                      .correctAnswerIndex], // Show correct answer
                                  style: TextStyle(
                                    color: AppColors.successGreen,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                trailing: IconButton(
                                  icon: const Icon(
                                    Icons.delete,
                                    color: AppColors.errorRed,
                                  ),
                                  onPressed: () => _removeQuestion(question.id),
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
