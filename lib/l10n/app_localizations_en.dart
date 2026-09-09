// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get onboardingTitle => 'Build better habits';

  @override
  String get onboardingSubtitle => 'Track your daily habits and build streaks that stick.';

  @override
  String get getStarted => 'Get started';

  @override
  String get getStartedButtonLabel => 'Get started, go to habits list';

  @override
  String get habitsTitle => 'My habits';

  @override
  String get statsTooltip => 'Statistics';

  @override
  String get settingsTooltip => 'Settings';

  @override
  String get noHabitsYet => 'No habits yet. Tap + to add one.';

  @override
  String get errorLoadingHabits => 'Couldn\'t load your habits.';

  @override
  String get addHabitButtonLabel => 'Add a new habit';

  @override
  String get habitDetailTitle => 'Habit detail';

  @override
  String get currentStreak => 'Current streak';

  @override
  String daysUnit(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count days',
      one: '1 day',
      zero: '0 days',
    );
    return '$_temp0';
  }

  @override
  String get history => 'History';

  @override
  String get deleteHabit => 'Delete habit';

  @override
  String get confirmDelete => 'Delete this habit?';

  @override
  String get cancel => 'Cancel';

  @override
  String get delete => 'Delete';

  @override
  String get statsTitle => 'Statistics';

  @override
  String get completionRate => 'Completion rate';

  @override
  String get totalHabits => 'Total habits';

  @override
  String get bestStreak => 'Best streak';

  @override
  String get settingsTitle => 'Settings';

  @override
  String get language => 'Language';

  @override
  String get theme => 'Theme';

  @override
  String get lightTheme => 'Light';

  @override
  String get darkTheme => 'Dark';

  @override
  String get systemTheme => 'System';
}
