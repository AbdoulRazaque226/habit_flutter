// lib/features/habits/data/models/habit_model.dart

import 'package:hive/hive.dart';
import '../../domain/entities/habit.dart';

part 'habit_model.g.dart';

@HiveType(typeId: 0)
class HabitModel extends HiveObject {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String icon;
  @HiveField(3)
  final List<DateTime> completedDates;
  @HiveField(4)
  final DateTime createdAt;

  HabitModel({
    required this.id,
    required this.name,
    required this.icon,
    required this.completedDates,
    required this.createdAt,
  });

  factory HabitModel.fromEntity(Habit habit) => HabitModel(
        id: habit.id,
        name: habit.name,
        icon: habit.icon,
        completedDates: habit.completedDates,
        createdAt: habit.createdAt,
      );

  Habit toEntity() => Habit(
        id: id,
        name: name,
        icon: icon,
        completedDates: completedDates,
        createdAt: createdAt,
      );
}