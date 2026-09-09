// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get onboardingTitle => 'Construis de meilleures habitudes';

  @override
  String get onboardingSubtitle => 'Suis tes habitudes quotidiennes et enchaîne les séries.';

  @override
  String get getStarted => 'Commencer';

  @override
  String get getStartedButtonLabel => 'Commencer, aller à la liste des habitudes';

  @override
  String get habitsTitle => 'Mes habitudes';

  @override
  String get statsTooltip => 'Statistiques';

  @override
  String get settingsTooltip => 'Réglages';

  @override
  String get noHabitsYet => 'Aucune habitude pour l\'instant. Appuie sur + pour en ajouter une.';

  @override
  String get errorLoadingHabits => 'Impossible de charger tes habitudes.';

  @override
  String get addHabitButtonLabel => 'Ajouter une nouvelle habitude';

  @override
  String get habitDetailTitle => 'Détail de l\'habitude';

  @override
  String get currentStreak => 'Série en cours';

  @override
  String daysUnit(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count jours',
      one: '1 jour',
      zero: '0 jour',
    );
    return '$_temp0';
  }

  @override
  String get history => 'Historique';

  @override
  String get deleteHabit => 'Supprimer l\'habitude';

  @override
  String get confirmDelete => 'Supprimer cette habitude ?';

  @override
  String get cancel => 'Annuler';

  @override
  String get delete => 'Supprimer';

  @override
  String get statsTitle => 'Statistiques';

  @override
  String get completionRate => 'Taux de complétion';

  @override
  String get totalHabits => 'Total d\'habitudes';

  @override
  String get bestStreak => 'Meilleure série';

  @override
  String get settingsTitle => 'Réglages';

  @override
  String get language => 'Langue';

  @override
  String get theme => 'Thème';

  @override
  String get lightTheme => 'Clair';

  @override
  String get darkTheme => 'Sombre';

  @override
  String get systemTheme => 'Système';
}
