// lib/features/habits/presentation/screens/habit_detail_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:app_final/l10n/app_localizations.dart';
import '../../domain/entities/habit.dart';
import '../providers/habit_providers.dart';

class HabitDetailScreen extends ConsumerWidget {
  final String habitId;

  const HabitDetailScreen({super.key, required this.habitId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;

    // Ne rebuild que si CETTE habitude (ou l'état loading/error) change,
    // pas à chaque modification d'une autre habitude dans la liste.
    final habitAsync = ref.watch(habitsProvider.select(
      (asyncHabits) => asyncHabits.whenData(
        (habits) => habits.where((h) => h.id == habitId).firstOrNull,
      ),
    ));

    return habitAsync.when(
      data: (habit) {
        if (habit == null) {
          return Scaffold(
            appBar: AppBar(title: Text(l10n.habitDetailTitle)),
            body: Center(child: Text(l10n.noHabitsYet)),
          );
        }

        return Scaffold(
          appBar: AppBar(
            title: Text(habit.name),
            actions: [
              IconButton(
                icon: const Icon(Icons.delete_outline),
                tooltip: l10n.deleteHabit,
                onPressed: () => _confirmDelete(context, ref, l10n, habit.id),
              ),
            ],
          ),
          body: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      const Text('🔥', style: TextStyle(fontSize: 40)),
                      const SizedBox(height: 8),
                      Text(l10n.currentStreak,
                          style: Theme.of(context).textTheme.labelLarge),
                      Text(
                        l10n.daysUnit(habit.currentStreak),
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(l10n.history, style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 8),
              _HistoryGrid(dates: habit.completedDates),
            ],
          ),
        );
      },
      loading: () => const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      ),
      error: (_, _) => Scaffold(
        appBar: AppBar(title: Text(l10n.habitDetailTitle)),
        body: Center(child: Text(l10n.errorLoadingHabits)),
      ),
    );
  }

  void _confirmDelete(BuildContext context, WidgetRef ref,
      AppLocalizations l10n, String id) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l10n.confirmDelete),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(l10n.cancel),
          ),
          TextButton(
            onPressed: () {
              ref.read(habitsProvider.notifier).deleteHabit(id);
              Navigator.pop(ctx);
              Navigator.pop(context);
            },
            child: Text(l10n.delete),
          ),
        ],
      ),
    );
  }
}

class _HistoryGrid extends StatelessWidget {
  final List<DateTime> dates;

  const _HistoryGrid({required this.dates});

  @override
  Widget build(BuildContext context) {
    final last30 = List.generate(30, (i) {
      final day = DateTime.now().subtract(Duration(days: 29 - i));
      final done = dates.any((d) =>
          d.year == day.year && d.month == day.month && d.day == day.day);
      return done;
    });

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 10,
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
      ),
      itemCount: last30.length,
      itemBuilder: (context, i) {
        final done = last30[i];
        return Semantics(
          label: done ? 'completed' : 'not completed',
          child: Container(
            decoration: BoxDecoration(
              color: done
                  ? Theme.of(context).colorScheme.primary
                  : Theme.of(context).colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        );
      },
    );
  }
}