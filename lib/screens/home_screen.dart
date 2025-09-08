// lib/screens/home_screen.dart
// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:flutter_app_game/config/app_colors.dart';
import 'package:flutter_app_game/config/app_styles.dart';
import 'package:flutter_app_game/data/quiz_data.dart'; // Make sure this path is correct
import 'package:flutter_app_game/l10n/app_localizations.dart';
import 'package:flutter_app_game/screens/quiz_screen.dart';
import 'package:flutter_app_game/widgets/background_pattern.dart';
import 'package:flutter_app_game/widgets/category_card.dart';

// IMPORTS for other screens
import 'package:flutter_app_game/screens/leaderboard_screen.dart';
import 'package:flutter_app_game/screens/saved_questions_screen.dart';
import 'package:flutter_app_game/screens/favorite_questions_screen.dart';
import 'package:flutter_app_game/screens/report_screen.dart';
import 'package:flutter_app_game/screens/settings_screen.dart';
import 'package:flutter_app_game/services/audio_service.dart';
// CORRECTED IMPORT: Use your project's package name and the 'generated' folder
import 'package:flutter_app_game/generated/gen_l10n/app_localizations.dart';

class HomeScreen extends StatelessWidget {
  final Function(Locale) setLocale;

  const HomeScreen({super.key, required this.setLocale});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF1A237E),
              Color(0xFF0D47A1),
            ], // Dark to light blue gradient
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Stack(
          children: [
            const BackgroundPattern(), // Reusing background pattern
            SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header Icons (Settings and Language Selector)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Settings Button with sound
                        IconButton(
                          icon: const Icon(
                            Icons.settings,
                            color: AppColors.white,
                            size: 30,
                          ),
                          onPressed: () {
                            AudioService.playButtonClick(); // Play sound on tap
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const SettingsScreen(),
                              ),
                            );
                          },
                        ),
                        // Language Selector Button
                        PopupMenuButton<Locale>(
                          icon: const Icon(
                            Icons.language,
                            color: AppColors.white,
                            size: 30,
                          ), // Language icon
                          onSelected: (Locale selectedLocale) {
                            AudioService.playButtonClick(); // Play sound on selection
                            setLocale(
                              selectedLocale,
                            ); // Call the setter from main.dart
                          },
                          itemBuilder:
                              (BuildContext context) =>
                                  <PopupMenuEntry<Locale>>[
                                    const PopupMenuItem<Locale>(
                                      value: Locale('en', ''),
                                      child: Text('English'),
                                    ),
                                    const PopupMenuItem<Locale>(
                                      value: Locale('km', ''),
                                      child: Text('ខ្មែរ'),
                                    ),
                                  ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),

                    // Quiz Logo
                    Center(
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(text: 'Q', style: AppStyles.quizLogoQ),
                            TextSpan(text: 'uiz', style: AppStyles.quizLogoUiz),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Center(
                      child: Text('knowledge', style: AppStyles.knowledgeText),
                    ),
                    const SizedBox(height: 50),

                    // Top Menu Buttons (Localized text)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildTopMenuButton(
                          context,
                          Icons.leaderboard,
                          appLocalizations.leaderboard, // LOCALIZED
                          const LeaderboardScreen(),
                        ),
                        _buildTopMenuButton(
                          context,
                          Icons.archive,
                          appLocalizations.savedQuestionsTitle, // LOCALIZED
                          const SavedQuestionsScreen(),
                        ),
                        _buildTopMenuButton(
                          context,
                          Icons.favorite,
                          appLocalizations.favoriteQuestionsTitle, // LOCALIZED
                          const FavoriteQuestionsScreen(),
                        ),
                        _buildTopMenuButton(
                          context,
                          Icons.assessment, // Icon for report/statistics
                          appLocalizations.reportTitle, // LOCALIZED
                          const ReportScreen(),
                        ),
                      ],
                    ),
                    const SizedBox(height: 40),

                    // Categories Grid with sound
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: categoriesData.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 1.2,
                            crossAxisSpacing: 15,
                            mainAxisSpacing: 15,
                          ),
                      itemBuilder: (context, index) {
                        final categoryName =
                            categoriesData[index]['name'] as String;
                        return CategoryCard(
                          icon: categoriesData[index]['icon'] as IconData,
                          name:
                              categoryName, // This remains as is, as category names are typically fixed in data
                          onTap: () {
                            AudioService.playButtonClick(); // Play sound on category tap
                            final questions =
                                categorizedQuizQuestions[categoryName];
                            if (questions != null && questions.isNotEmpty) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (context) => QuizScreen(
                                        questions: questions,
                                        categoryName: categoryName,
                                      ),
                                ),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    appLocalizations.noQuestionsAvailable,
                                  ), // Localized message
                                ),
                              );
                            }
                          },
                        );
                      },
                    ),

                    const SizedBox(height: 20),
                    // Bottom Text (Localized tagline)
                    Center(
                      child: Text(
                        appLocalizations.appTagline, // LOCALIZED
                        textAlign: TextAlign.center,
                        style: AppStyles.bottomTagline,
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Modified _buildTopMenuButton to play sound
  Widget _buildTopMenuButton(
    BuildContext context,
    IconData icon,
    String label,
    Widget destinationScreen,
  ) {
    return InkWell(
      onTap: () {
        AudioService.playButtonClick(); // Play sound on top menu button tap
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => destinationScreen),
        );
      },
      borderRadius: BorderRadius.circular(10),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 8.0),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.whiteOpacity(0.2),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: AppColors.white, size: 28),
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: TextStyle(
                color: AppColors.whiteOpacity(0.8),
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
