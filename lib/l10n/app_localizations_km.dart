// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Khmer Central Khmer (`km`).
class AppLocalizationsKm extends AppLocalizations {
  AppLocalizationsKm([String locale = 'km']) : super(locale);

  @override
  String get quizAppTitle => 'កម្មវិធីសំណួរខ្មែរ';

  @override
  String questionNumber(Object current, Object total) {
    return 'សំណួរទី $current / $total';
  }

  @override
  String get question => 'សំណួរ - ចម្លើយ';

  @override
  String get nextQuestion => 'សំណួរបន្ទាប់';

  @override
  String get viewResults => 'មើលលទ្ធផល';

  @override
  String get questionSaved => 'សំណួរត្រូវបានរក្សាទុក!';

  @override
  String get questionRemovedFromSaved => 'បានលុបចេញពីសំណួរដែលបានរក្សាទុក!';

  @override
  String get questionAlreadySaved => 'សំណួរនេះត្រូវបានរក្សាទុកហើយ!';

  @override
  String get addedToFavorites => 'បានបន្ថែមទៅសំណួរចូលចិត្ត!';

  @override
  String get removedFromFavorites => 'បានលុបចេញពីសំណួរដែលចូលចិត្ត!';

  @override
  String get noQuestionsAvailable =>
      'គ្មានសំណួរសម្រាប់ប្រភេទនេះ ឬមានកំហុសកើតឡើង។';

  @override
  String get leaderboard => 'តារាងពិន្ទុ';

  @override
  String get savedQuestionsTitle => 'បានរក្សាទុក';

  @override
  String get favoriteQuestionsTitle => 'ចូលចិត្ត';

  @override
  String get reportTitle => 'របាយការណ៍';

  @override
  String get appTagline => 'ហ្គេមបណ្តុះប្រាជ្ញា\nនិងបង្កើនចំណេះដឹង';
}
