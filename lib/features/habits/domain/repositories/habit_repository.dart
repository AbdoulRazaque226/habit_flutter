// lib/features/habits/domain/repositories/habit_repository.dart

import '../entities/habit.dart';

abstract class HabitRepository {
  Future<List<Habit>> getHabits();
  Future<void> addHabit(Habit habit);
  Future<void> updateHabit(Habit habit);
  Future<void> deleteHabit(String id);
  Future<void> toggleCompletion(String habitId, DateTime date);
}