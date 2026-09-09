// lib/features/habits/presentation/providers/habit_providers.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:hive/hive.dart';
import '../../data/models/habit_model.dart';
import '../../data/repositories/habit_repository_impl.dart';
import '../../domain/entities/habit.dart';
import '../../domain/repositories/habit_repository.dart';

final habitBoxProvider = Provider<Box<HabitModel>>((ref) {
  return Hive.box<HabitModel>('habits');
});

final habitRepositoryProvider = Provider<HabitRepository>((ref) {
  final box = ref.watch(habitBoxProvider);
  return HabitRepositoryImpl(box);
});

class HabitsNotifier extends StateNotifier<AsyncValue<List<Habit>>> {
  final HabitRepository repository;

  HabitsNotifier(this.repository) : super(const AsyncValue.loading()) {
    loadHabits();
  }

  Future<void> loadHabits() async {
    state = const AsyncValue.loading();
    try {
      final habits = await repository.getHabits();
      state = AsyncValue.data(habits);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> addHabit(Habit habit) async {
    await repository.addHabit(habit);
    await loadHabits();
  }

  Future<void> toggleCompletion(String id) async {
    await repository.toggleCompletion(id, DateTime.now());
    await loadHabits();
  }

  Future<void> deleteHabit(String id) async {
    await repository.deleteHabit(id);
    await loadHabits();
  }
}

final habitsProvider =
    StateNotifierProvider<HabitsNotifier, AsyncValue<List<Habit>>>((ref) {
  final repo = ref.watch(habitRepositoryProvider);
  return HabitsNotifier(repo);
});