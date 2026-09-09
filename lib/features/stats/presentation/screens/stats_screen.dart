// lib/features/stats/presentation/screens/stats_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:app_final/l10n/app_localizations.dart';
import '../../../habits/presentation/providers/habit_providers.dart';

class StatsScreen extends ConsumerWidget {
  const StatsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final habitsAsync = ref.watch(habitsProvider);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.statsTitle)),
      body: habitsAsync.when(
        data: (habits) {
          final total = habits.length;
          final completedToday =
              habits.where((h) => h.isCompletedToday).length;
          final rate = total == 0 ? 0.0 : completedToday / total;
          final bestStreak = habits.isEmpty
              ? 0
              : habits.map((h) => h.currentStreak).reduce((a, b) => a > b ? a : b);

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              _StatCard(label: l10n.totalHabits, value: '$total'),
              const SizedBox(height: 12),
              _StatCard(
                label: l10n.completionRate,
                value: '${(rate * 100).toStringAsFixed(0)}%',
              ),
              const SizedBox(height: 12),
              _StatCard(label: l10n.bestStreak, value: l10n.daysUnit(bestStreak)),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (_, _) => Center(child: Text(l10n.errorLoadingHabits)),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String label;
  final String value;

  const _StatCard({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(label),
        trailing: Text(
          value,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
    );
  }
}