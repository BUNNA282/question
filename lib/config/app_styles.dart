import 'package:flutter/material.dart';
import 'package:flutter_app_game/config/app_colors.dart'; // កែពី khmer_quiz_app// កុំភ្លេច import

class AppStyles {
  static TextStyle headerTextStyle = TextStyle(
    color: AppColors.white,
    fontSize: 18,
    fontWeight: FontWeight.bold,
    shadows: [
      Shadow(
        blurRadius: 5.0,
        color: AppColors.blackOpacity(0.3),
        offset: Offset(2.0, 2.0),
      ),
    ],
  );

  static TextStyle quizLogoQ = TextStyle(
    fontSize: 80,
    fontWeight: FontWeight.bold,
    color: AppColors.white,
    shadows: [
      Shadow(
        blurRadius: 10.0,
        color: AppColors.blackOpacity(0.5),
        offset: Offset(3.0, 3.0),
      ),
    ],
  );

  static TextStyle quizLogoUiz = TextStyle(
    fontSize: 60,
    fontWeight: FontWeight.w600,
    color: AppColors.whiteOpacity(0.8),
    shadows: [
      Shadow(
        blurRadius: 10.0,
        color: AppColors.blackOpacity(0.5),
        offset: Offset(3.0, 3.0),
      ),
    ],
  );

  static TextStyle knowledgeText = TextStyle(
    color: AppColors.whiteOpacity(0.7),
    fontSize: 20,
    letterSpacing: 2,
    fontWeight: FontWeight.w300,
  );

  static TextStyle bottomTagline = TextStyle(
    color: AppColors.whiteOpacity(0.9),
    fontSize: 20,
    fontWeight: FontWeight.bold,
    height: 1.5,
    shadows: [
      Shadow(
        blurRadius: 8.0,
        color: AppColors.blackOpacity(0.4),
        offset: Offset(2.0, 2.0),
      ),
    ],
  );

  static const TextStyle questionTextStyle = TextStyle(
    color: AppColors.white,
    fontSize: 22,
    fontWeight: FontWeight.bold,
    shadows: [
      Shadow(
        blurRadius: 5.0,
        color: Color(0x80000000), // 50% opacity black
        offset: Offset(1.0, 1.0),
      ),
    ],
  );

  static const TextStyle optionButtonTextStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
  );

  static ButtonStyle primaryButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: AppColors.primaryLightBlue,
    foregroundColor: AppColors.white,
    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
    textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    elevation: 5,
  );

  static BoxDecoration questionBoxDecoration = BoxDecoration(
    color: AppColors.primaryMediumBlue,
    borderRadius: BorderRadius.circular(20),
    border: Border.all(color: AppColors.whiteOpacity(0.7), width: 2.0),
    boxShadow: [
      BoxShadow(
        color: AppColors.blackOpacity(0.4),
        spreadRadius: 2,
        blurRadius: 8,
        offset: const Offset(0, 5),
      ),
    ],
  );

  static var resultTextStyle;

  static var questionNumberStyle;

  static var optionTextStyle;
}
