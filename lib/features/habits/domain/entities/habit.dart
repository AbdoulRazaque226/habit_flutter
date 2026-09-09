// lib/features/habits/domain/entities/habit.dart

class Habit {
  final String id;
  final String name;
  final String icon;
  final List<DateTime> completedDates;
  final DateTime createdAt;

  const Habit({
    required this.id,
    required this.name,
    required this.icon,
    required this.completedDates,
    required this.createdAt,
  });

  bool get isCompletedToday {
    final today = DateTime.now();
    return completedDates.any((d) =>
        d.year == today.year && d.month == today.month && d.day == today.day);
  }

  int get currentStreak {
    if (completedDates.isEmpty) return 0;
    final sorted = [...completedDates]..sort((a, b) => b.compareTo(a));
    var streak = 0;
    var cursor = DateTime.now();
    for (final date in sorted) {
      final diff = cursor.difference(date).inDays;
      if (diff <= 1) {
        streak++;
        cursor = date;
      } else {
        break;
      }
    }
    return streak;
  }

  Habit copyWith({
    String? id,
    String? name,
    String? icon,
    List<DateTime>? completedDates,
    DateTime? createdAt,
  }) {
    return Habit(
      id: id ?? this.id,
      name: name ?? this.name,
      icon: icon ?? this.icon,
      completedDates: completedDates ?? this.completedDates,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}