// test/unit/habit_entity_test.dart
 // 7 tests unitaires
import 'package:flutter_test/flutter_test.dart';
import 'package:app_final/features/habits/domain/entities/habit.dart';

void main() {
  group('Habit entity', () {
    test('isCompletedToday returns true when completed today', () {
      final habit = Habit(
        id: '1',
        name: 'Lire',
        icon: '📖',
        completedDates: [DateTime.now()],
        createdAt: DateTime.now(),
      );
      expect(habit.isCompletedToday, isTrue);
    });

    test('isCompletedToday returns false when never completed', () {
      final habit = Habit(
        id: '1',
        name: 'Lire',
        icon: '📖',
        completedDates: const [],
        createdAt: DateTime.now(),
      );
      expect(habit.isCompletedToday, isFalse);
    });

    test('isCompletedToday returns false for a past date only', () {
      final habit = Habit(
        id: '1',
        name: 'Lire',
        icon: '📖',
        completedDates: [DateTime.now().subtract(const Duration(days: 5))],
        createdAt: DateTime.now(),
      );
      expect(habit.isCompletedToday, isFalse);
    });

    test('currentStreak is 0 when no completed dates', () {
      final habit = Habit(
        id: '1',
        name: 'Lire',
        icon: '📖',
        completedDates: const [],
        createdAt: DateTime.now(),
      );
      expect(habit.currentStreak, 0);
    });

    test('currentStreak is 1 for a single completion today', () {
      final habit = Habit(
        id: '1',
        name: 'Lire',
        icon: '📖',
        completedDates: [DateTime.now()],
        createdAt: DateTime.now(),
      );
      expect(habit.currentStreak, 1);
    });

    test('currentStreak counts consecutive days correctly', () {
      final now = DateTime.now();
      final habit = Habit(
        id: '1',
        name: 'Lire',
        icon: '📖',
        completedDates: [
          now,
          now.subtract(const Duration(days: 1)),
          now.subtract(const Duration(days: 2)),
        ],
        createdAt: now,
      );
      expect(habit.currentStreak, 3);
    });

    test('currentStreak stops at a gap in dates', () {
      final now = DateTime.now();
      final habit = Habit(
        id: '1',
        name: 'Lire',
        icon: '📖',
        completedDates: [
          now,
          now.subtract(const Duration(days: 5)), // trou
        ],
        createdAt: now,
      );
      expect(habit.currentStreak, 1);
    });

    test('copyWith updates only the given fields', () {
      final habit = Habit(
        id: '1',
        name: 'Lire',
        icon: '📖',
        completedDates: const [],
        createdAt: DateTime.now(),
      );
      final updated = habit.copyWith(name: 'Courir');
      expect(updated.name, 'Courir');
      expect(updated.id, habit.id);
      expect(updated.icon, habit.icon);
    });
  });
}