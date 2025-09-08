// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get quizAppTitle => 'Khmer Quiz App';

  @override
  String questionNumber(Object current, Object total) {
    return 'Question $current / $total';
  }

  @override
  String get question => 'Question - Answer';

  @override
  String get nextQuestion => 'Next Question';

  @override
  String get viewResults => 'View Results';

  @override
  String get questionSaved => 'Question saved!';

  @override
  String get questionRemovedFromSaved => 'Question removed from saved!';

  @override
  String get questionAlreadySaved => 'Question already saved!';

  @override
  String get addedToFavorites => 'Added to favorites!';

  @override
  String get removedFromFavorites => 'Removed from favorites!';

  @override
  String get noQuestionsAvailable =>
      'No questions available for this category or an error occurred.';

  @override
  String get leaderboard => 'Leaderboard';

  @override
  String get savedQuestionsTitle => 'Saved';

  @override
  String get favoriteQuestionsTitle => 'Favorite';

  @override
  String get reportTitle => 'Report';

  @override
  String get appTagline => 'A game to cultivate wisdom\nand enhance knowledge';
}
