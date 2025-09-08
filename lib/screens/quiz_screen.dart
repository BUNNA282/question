// lib/screens/quiz_screen.dart
// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:flutter_app_game/config/app_colors.dart';
import 'package:flutter_app_game/config/app_styles.dart';
import 'package:flutter_app_game/l10n/app_localizations.dart';
import 'package:flutter_app_game/models/question.dart';
import 'package:flutter_app_game/screens/result_screen.dart';
import 'package:flutter_app_game/widgets/background_pattern.dart';
import 'package:flutter_app_game/widgets/option_button.dart';
import 'package:flutter_app_game/services/audio_service.dart';
import 'package:flutter_app_game/services/question_storage_service.dart';
import 'dart:async';
// CORRECTED IMPORT: Use your project's package name and the 'generated' folder
import 'package:flutter_app_game/generated/gen_l10n/app_localizations.dart';

class QuizScreen extends StatefulWidget {
  final List<Question> questions;
  final String categoryName;

  const QuizScreen({
    super.key,
    required this.questions,
    required this.categoryName,
  });

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int _currentQuestionIndex = 0;
  int _score = 0;
  bool _hasAnswered = false;
  int? _selectedOptionIndex;
  bool _isCurrentQuestionSaved = false;
  bool _isCurrentQuestionFavorite = false;

  // Timer variables
  Timer? _questionTimer;
  int _secondsRemaining =
      30; // Changed to 30 seconds as per user's last request

  @override
  void initState() {
    super.initState();
    _checkStatus();
    _startQuestionTimer();
  }

  @override
  void dispose() {
    _questionTimer?.cancel();
    super.dispose();
  }

  // Function to start the question timer
  void _startQuestionTimer() {
    _secondsRemaining = 30; // Reset time for new question
    _questionTimer?.cancel(); // Cancel any existing timer

    _questionTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining > 0) {
        setState(() {
          _secondsRemaining--;
        });
      } else {
        // Time's up, move to next question (consider it unanswered/wrong)
        timer.cancel();
        _answerQuestion(
          -1,
        ); // Pass -1 to indicate time ran out (no option selected)
      }
    });
  }

  // Checks and updates the saved/favorite status of the current question
  void _checkStatus() async {
    if (widget.questions.isNotEmpty &&
        _currentQuestionIndex < widget.questions.length) {
      final currentQuestionId = widget.questions[_currentQuestionIndex].id;
      final isSaved = await QuestionStorageService.isQuestionSaved(
        currentQuestionId,
      );
      final isFavorite = await QuestionStorageService.isQuestionFavorite(
        currentQuestionId,
      );
      setState(() {
        _isCurrentQuestionSaved = isSaved;
        _isCurrentQuestionFavorite = isFavorite;
      });
    }
  }

  // Handles when an answer option is tapped
  void _answerQuestion(int selectedIndex) {
    if (_hasAnswered) return; // Prevent multiple taps

    _questionTimer?.cancel(); // Stop the timer when an answer is selected

    setState(() {
      _selectedOptionIndex = selectedIndex; // Mark the selected option
      _hasAnswered = true; // Mark question as answered

      if (selectedIndex != -1) {
        // Only check score if an option was actually selected
        // Check if the selected answer is correct
        if (selectedIndex ==
            widget.questions[_currentQuestionIndex].correctAnswerIndex) {
          _score++;
          AudioService.playCorrectAnswer(); // Play sound for correct answer
        } else {
          AudioService.playWrongAnswer(); // Play sound for wrong answer
        }
      } else {
        // Time ran out scenario (selectedIndex == -1)
        AudioService.playWrongAnswer(); // Play wrong sound as it's effectively wrong/unanswered
      }
    });

    // Automatically move to the next question after a delay
    Future.delayed(const Duration(seconds: 2), () {
      _nextQuestion();
    });
  }

  // Moves to the next question or ends the quiz
  void _nextQuestion() {
    setState(() {
      _currentQuestionIndex++; // Increment question index
      _hasAnswered = false; // Reset answered status for the new question
      _selectedOptionIndex = null; // Clear selected option

      // Check if all questions have been answered
      if (_currentQuestionIndex >= widget.questions.length) {
        _questionTimer?.cancel(); // Cancel timer when quiz ends
        AudioService.playQuizComplete(); // Play sound for quiz completion
        Navigator.pushReplacement(
          // Replace current screen with ResultScreen
          context,
          MaterialPageRoute(
            builder:
                (context) => ResultScreen(
                  score: _score,
                  totalQuestions: widget.questions.length,
                ),
          ),
        );
      } else {
        _checkStatus(); // Update saved/favorite status for the new question
        _startQuestionTimer(); // Start timer for the next question
      }
    });
  }

  // Toggles the saved status of the current question
  void _toggleSaved(BuildContext context) async {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    if (widget.questions.isNotEmpty &&
        _currentQuestionIndex < widget.questions.length) {
      final currentQuestionId = widget.questions[_currentQuestionIndex].id;
      await QuestionStorageService.toggleSavedQuestion(currentQuestionId);
      _checkStatus();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            _isCurrentQuestionSaved
                ? appLocalizations.questionRemovedFromSaved
                : appLocalizations.questionSaved,
          ), // Use localized messages
        ),
      );
    }
  }

  // Toggles the favorite status of the current question
  void _toggleFavorite(BuildContext context) async {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    if (widget.questions.isNotEmpty &&
        _currentQuestionIndex < widget.questions.length) {
      final currentQuestionId = widget.questions[_currentQuestionIndex].id;
      await QuestionStorageService.toggleFavoriteQuestion(currentQuestionId);
      _checkStatus();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            _isCurrentQuestionFavorite
                ? appLocalizations.removedFromFavorites
                : appLocalizations.addedToFavorites,
          ), // Use localized messages
        ),
      );
    }
  }

  // Determines the background color of an option button based on answer status
  Color _getOptionButtonBackgroundColor(int optionIndex) {
    if (!_hasAnswered) {
      return AppColors.white; // Default color if not answered
    }
    // If answered, highlight correct/wrong answers
    if (optionIndex ==
        widget.questions[_currentQuestionIndex].correctAnswerIndex) {
      return AppColors.successGreen; // Correct answer
    } else if (optionIndex == _selectedOptionIndex) {
      return AppColors.errorRed; // Wrong answer that was selected
    } else if (_selectedOptionIndex == -1 &&
        optionIndex ==
            widget.questions[_currentQuestionIndex].correctAnswerIndex) {
      // If time ran out and this is the correct answer, show it
      return AppColors.successGreen;
    } else {
      return AppColors.whiteOpacity(0.7); // Other wrong answers (faded)
    }
  }

  // Determines the text color of an option button
  Color _getOptionButtonTextColor(int optionIndex) {
    if (!_hasAnswered) {
      return AppColors.primaryDarkBlue; // Default color if not answered
    }
    // If answered, text color is white for correct/selected answers
    if (optionIndex ==
            widget.questions[_currentQuestionIndex].correctAnswerIndex ||
        optionIndex == _selectedOptionIndex) {
      return AppColors.white;
    } else {
      return AppColors
          .primaryDarkBlue; // Other wrong answers (default text color)
    }
  }

  // Determines the border color of an option button
  Color _getOptionButtonBorderColor(int optionIndex) {
    if (!_hasAnswered) {
      return AppColors.primaryDarkBlue; // Default border if not answered
    }
    // If answered, border color matches background for correct/selected
    if (optionIndex ==
        widget.questions[_currentQuestionIndex].correctAnswerIndex) {
      return AppColors.successGreen; // Use the same green color for border
    } else if (optionIndex == _selectedOptionIndex) {
      return AppColors.errorRed; // Use the same red color for border
    } else {
      return AppColors
          .primaryDarkBlue; // Default border for other wrong answers
    }
  }

  @override
  Widget build(BuildContext context) {
    // Access localized strings
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;

    // Handle case where questions list might be empty or index out of bounds
    if (widget.questions.isEmpty ||
        _currentQuestionIndex >= widget.questions.length) {
      return Scaffold(
        appBar: AppBar(
          title: Text(appLocalizations.quizAppTitle), // Localized title
          backgroundColor: AppColors.primaryDarkBlue,
          foregroundColor: AppColors.white,
        ),
        body: Center(
          child: Text(
            appLocalizations.noQuestionsAvailable, // Localized message
            textAlign: TextAlign.center,
            style: const TextStyle(color: AppColors.white, fontSize: 18),
          ),
        ),
      );
    }

    final currentQuestion = widget.questions[_currentQuestionIndex];

    return Scaffold(
      appBar: AppBar(
        // Use localized question number
        title: Text(
          '${widget.categoryName} - ${appLocalizations.questionNumber((_currentQuestionIndex + 1).toString(), widget.questions.length.toString())}',
        ),
        backgroundColor: AppColors.primaryDarkBlue,
        foregroundColor: AppColors.white,
        actions: const [
          // IMPORTANT: Removed Bookmark and Favorite icons from AppBar.actions
          // They are now placed inside the question bubble in the body.
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
            Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      appLocalizations.question, // Localized string
                      style: AppStyles.headerTextStyle,
                    ),
                    const SizedBox(height: 30),

                    // Question Bubble
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(25.0),
                      decoration: AppStyles.questionBoxDecoration,
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.topRight,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                // Timer Icon and Text
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: AppColors.whiteOpacity(0.9),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.timer,
                                        color:
                                            _secondsRemaining <= 5 &&
                                                    _secondsRemaining > 0
                                                ? AppColors.errorRed
                                                : AppColors.primaryDarkBlue,
                                      ),
                                      if (_secondsRemaining > 0 ||
                                          !_hasAnswered) // Display time if not answered or still counting down
                                        Padding(
                                          padding: const EdgeInsets.only(
                                            left: 4.0,
                                          ),
                                          child: Text(
                                            '$_secondsRemaining',
                                            style: TextStyle(
                                              color:
                                                  _secondsRemaining <= 5 &&
                                                          _secondsRemaining > 0
                                                      ? AppColors.errorRed
                                                      : AppColors
                                                          .primaryDarkBlue,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 5),
                                // Save/Unsave button (NOW IN BODY)
                                InkWell(
                                  onTap: () {
                                    AudioService.playButtonClick();
                                    _toggleSaved(context); // Pass context
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color:
                                          _isCurrentQuestionSaved
                                              ? AppColors.accentYellow
                                              : AppColors.whiteOpacity(0.9),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      _isCurrentQuestionSaved
                                          ? Icons.bookmark_added
                                          : Icons.bookmark_add,
                                      color:
                                          AppColors
                                              .primaryDarkBlue, // Color consistent regardless of state
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 5),
                                // Favorite/Unfavorite button (NOW IN BODY)
                                InkWell(
                                  onTap: () {
                                    AudioService.playButtonClick();
                                    _toggleFavorite(context); // Pass context
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color:
                                          _isCurrentQuestionFavorite
                                              ? AppColors
                                                  .errorRed // Red for favorite
                                              : AppColors.whiteOpacity(0.9),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      _isCurrentQuestionFavorite
                                          ? Icons.favorite
                                          : Icons.favorite_border,
                                      color:
                                          _isCurrentQuestionFavorite
                                              ? AppColors
                                                  .white // White icon for favorite
                                              : AppColors.primaryDarkBlue,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            currentQuestion.questionText,
                            textAlign: TextAlign.center,
                            style: AppStyles.questionTextStyle,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 40),

                    // Options Grid using OptionButton widget
                    Column(
                      children: [
                        Row(
                          children: [
                            OptionButton(
                              text: currentQuestion.options[0],
                              index: 0,
                              onTap: () => _answerQuestion(0),
                              backgroundColor: _getOptionButtonBackgroundColor(
                                0,
                              ),
                              textColor: _getOptionButtonTextColor(0),
                              borderColor: _getOptionButtonBorderColor(0),
                            ),
                            const SizedBox(width: 15),
                            OptionButton(
                              text: currentQuestion.options[1],
                              index: 1,
                              onTap: () => _answerQuestion(1),
                              backgroundColor: _getOptionButtonBackgroundColor(
                                1,
                              ),
                              textColor: _getOptionButtonTextColor(1),
                              borderColor: _getOptionButtonBorderColor(1),
                            ),
                          ],
                        ),
                        const SizedBox(height: 15),
                        Row(
                          children: [
                            OptionButton(
                              text: currentQuestion.options[2],
                              index: 2,
                              onTap: () => _answerQuestion(2),
                              backgroundColor: _getOptionButtonBackgroundColor(
                                2,
                              ),
                              textColor: _getOptionButtonTextColor(2),
                              borderColor: _getOptionButtonBorderColor(2),
                            ),
                            const SizedBox(width: 15),
                            OptionButton(
                              text: currentQuestion.options[3],
                              index: 3,
                              onTap: () => _answerQuestion(3),
                              backgroundColor: _getOptionButtonBackgroundColor(
                                3,
                              ),
                              textColor: _getOptionButtonTextColor(3),
                              borderColor: _getOptionButtonBorderColor(3),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),

                    // Next Question button (only visible after answering)
                    if (_hasAnswered)
                      ElevatedButton(
                        onPressed: _nextQuestion,
                        style: AppStyles.primaryButtonStyle,
                        child: Text(
                          _currentQuestionIndex + 1 < widget.questions.length
                              ? appLocalizations.nextQuestion
                              : appLocalizations.viewResults,
                        ), // Localized button text
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
