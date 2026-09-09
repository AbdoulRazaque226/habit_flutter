// lib/features/habits/presentation/screens/habits_list_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:app_final/l10n/app_localizations.dart';
import '../providers/habit_providers.dart';
import '../widgets/habit_tile.dart';

import 'package:uuid/uuid.dart'; // ajoute uuid: ^4.5.1 dans pubspec.yaml
import '../../domain/entities/habit.dart';


class HabitsListScreen extends ConsumerWidget {
  const HabitsListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final habitsAsync = ref.watch(habitsProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.habitsTitle),
        actions: [
          IconButton(
            icon: const Icon(Icons.bar_chart),
            tooltip: l10n.statsTooltip,
            onPressed: () => context.push('/stats'),
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            tooltip: l10n.settingsTooltip,
            onPressed: () => context.push('/settings'),
          ),
        ],
      ),
      body: habitsAsync.when(
        data: (habits) {
          if (habits.isEmpty) {
            return Center(child: Text(l10n.noHabitsYet));
          }
          return ListView.builder(
            itemCount: habits.length,
            itemBuilder: (context, index) {
              final habit = habits[index];
              return HabitTile(
                key: ValueKey(habit.id),
                habit: habit,
                onToggle: () =>
                    ref.read(habitsProvider.notifier).toggleCompletion(habit.id),
                onTap: () => context.push('/habits/${habit.id}'),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) => Center(child: Text(l10n.errorLoadingHabits)),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddHabitDialog(context, ref, l10n),
        child: Semantics(
          label: l10n.addHabitButtonLabel,
          child: const Icon(Icons.add),
        ),
      ),
    );
  }


void _showAddHabitDialog(
    BuildContext context, WidgetRef ref, AppLocalizations l10n) {
  final nameController = TextEditingController();
  final iconController = TextEditingController(text: '⭐');

  showDialog(
    context: context,
    builder: (ctx) => AlertDialog(
      title: Text(l10n.addHabitButtonLabel),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: iconController,
            decoration: const InputDecoration(labelText: 'Emoji'),
            maxLength: 2,
          ),
          TextField(
            controller: nameController,
            decoration: InputDecoration(labelText: l10n.habitsTitle),
            autofocus: true,
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(ctx),
          child: Text(l10n.cancel),
        ),
        FilledButton(
          onPressed: () {
            final name = nameController.text.trim();
            if (name.isEmpty) return;
            final habit = Habit(
              id: const Uuid().v4(),
              name: name,
              icon: iconController.text.trim().isEmpty
                  ? '⭐'
                  : iconController.text.trim(),
              completedDates: const [],
              createdAt: DateTime.now(),
            );
            ref.read(habitsProvider.notifier).addHabit(habit);
            Navigator.pop(ctx);
          },
          child: Text(l10n.getStarted),
        ),
      ],
    ),
  );
}
}