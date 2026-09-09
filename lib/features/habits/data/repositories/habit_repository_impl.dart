// lib/features/habits/data/repositories/habit_repository_impl.dart

import 'package:hive/hive.dart';
import '../../domain/entities/habit.dart';
import '../../domain/repositories/habit_repository.dart';
import '../models/habit_model.dart';

class HabitRepositoryImpl implements HabitRepository {
  final Box<HabitModel> box;

  HabitRepositoryImpl(this.box);

  @override
  Future<List<Habit>> getHabits() async {
    return box.values.map((m) => m.toEntity()).toList();
  }

  @override
  Future<void> addHabit(Habit habit) async {
    final model = HabitModel.fromEntity(habit);
    await box.put(habit.id, model);
  }

  @override
  Future<void> updateHabit(Habit habit) async {
    final model = HabitModel.fromEntity(habit);
    await box.put(habit.id, model);
  }

  @override
  Future<void> deleteHabit(String id) async {
    await box.delete(id);
  }

  @override
  Future<void> toggleCompletion(String habitId, DateTime date) async {
    final model = box.get(habitId);
    if (model == null) return;
    final entity = model.toEntity();
    final already = entity.isCompletedToday;
    final newDates = [...entity.completedDates];
    if (already) {
      newDates.removeWhere((d) =>
          d.year == date.year && d.month == date.month && d.day == date.day);
    } else {
      newDates.add(date);
    }
    final updated = entity.copyWith(completedDates: newDates);
    await box.put(habitId, HabitModel.fromEntity(updated));
  }
}