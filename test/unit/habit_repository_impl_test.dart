// test/unit/habit_repository_impl_test.dart

import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:hive_test/hive_test.dart';
import 'package:app_final/features/habits/data/models/habit_model.dart';
import 'package:app_final/features/habits/data/repositories/habit_repository_impl.dart';
import 'package:app_final/features/habits/domain/entities/habit.dart';

void main() {
  late Box<HabitModel> box;
  late HabitRepositoryImpl repository;

  setUp(() async {
    await setUpTestHive();
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(HabitModelAdapter());
    }
    box = await Hive.openBox<HabitModel>('test_habits');
    repository = HabitRepositoryImpl(box);
  });

  tearDown(() async {
    await tearDownTestHive();
  });

  test('getHabits returns empty list initially', () async {
    final habits = await repository.getHabits();
    expect(habits, isEmpty);
  });

  test('addHabit persists a habit', () async {
    final habit = Habit(
      id: '1',
      name: 'Méditer',
      icon: '🧘',
      completedDates: const [],
      createdAt: DateTime.now(),
    );
    await repository.addHabit(habit);
    final habits = await repository.getHabits();
    expect(habits.length, 1);
    expect(habits.first.name, 'Méditer');
  });

  test('deleteHabit removes the habit', () async {
    final habit = Habit(
      id: '1',
      name: 'Méditer',
      icon: '🧘',
      completedDates: const [],
      createdAt: DateTime.now(),
    );
    await repository.addHabit(habit);
    await repository.deleteHabit('1');
    final habits = await repository.getHabits();
    expect(habits, isEmpty);
  });

  test('toggleCompletion adds today when not completed', () async {
    final habit = Habit(
      id: '1',
      name: 'Méditer',
      icon: '🧘',
      completedDates: const [],
      createdAt: DateTime.now(),
    );
    await repository.addHabit(habit);
    await repository.toggleCompletion('1', DateTime.now());
    final habits = await repository.getHabits();
    expect(habits.first.isCompletedToday, isTrue);
  });

  test('toggleCompletion removes today when already completed', () async {
    final habit = Habit(
      id: '1',
      name: 'Méditer',
      icon: '🧘',
      completedDates: [DateTime.now()],
      createdAt: DateTime.now(),
    );
    await repository.addHabit(habit);
    await repository.toggleCompletion('1', DateTime.now());
    final habits = await repository.getHabits();
    expect(habits.first.isCompletedToday, isFalse);
  });
}