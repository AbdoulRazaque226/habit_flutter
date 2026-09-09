// lib/features/habits/presentation/widgets/habit_tile.dart

import 'package:flutter/material.dart';
import '../../domain/entities/habit.dart';

class HabitTile extends StatelessWidget {
  final Habit habit;
  final VoidCallback onToggle;
  final VoidCallback onTap;

  const HabitTile({
    super.key,
    required this.habit,
    required this.onToggle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return MergeSemantics(
      child: ListTile(
        onTap: onTap,
        leading: Text(habit.icon, style: const TextStyle(fontSize: 28)),
        title: Text(habit.name),
        subtitle: Text('🔥 ${habit.currentStreak}'),
        trailing: Checkbox(
          value: habit.isCompletedToday,
          onChanged: (_) => onToggle(),
        ),
      ),
    );
  }
}