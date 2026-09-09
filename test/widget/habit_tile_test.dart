// test/widget/habit_tile_test.dart

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:app_final/features/habits/domain/entities/habit.dart';
import 'package:app_final/features/habits/presentation/widgets/habit_tile.dart';

void main() {
  Widget wrap(Widget child) => MaterialApp(home: Scaffold(body: child));

  final habit = Habit(
    id: '1',
    name: 'Boire de l\'eau',
    icon: '💧',
    completedDates: const [],
    createdAt: DateTime.now(),
  );

  testWidgets('HabitTile displays habit name', (tester) async {
    await tester.pumpWidget(wrap(HabitTile(
      habit: habit,
      onToggle: () {},
      onTap: () {},
    )));
    expect(find.text('Boire de l\'eau'), findsOneWidget);
  });

  testWidgets('HabitTile displays the icon', (tester) async {
    await tester.pumpWidget(wrap(HabitTile(
      habit: habit,
      onToggle: () {},
      onTap: () {},
    )));
    expect(find.text('💧'), findsOneWidget);
  });

  testWidgets('HabitTile checkbox reflects completion state', (tester) async {
    await tester.pumpWidget(wrap(HabitTile(
      habit: habit,
      onToggle: () {},
      onTap: () {},
    )));
    final checkbox = tester.widget<Checkbox>(find.byType(Checkbox));
    expect(checkbox.value, isFalse);
  });

  testWidgets('HabitTile calls onToggle when checkbox tapped', (tester) async {
    var toggled = false;
    await tester.pumpWidget(wrap(HabitTile(
      habit: habit,
      onToggle: () => toggled = true,
      onTap: () {},
    )));
    await tester.tap(find.byType(Checkbox));
    await tester.pump();
    expect(toggled, isTrue);
  });

  testWidgets('HabitTile calls onTap when tile tapped', (tester) async {
    var tapped = false;
    await tester.pumpWidget(wrap(HabitTile(
      habit: habit,
      onToggle: () {},
      onTap: () => tapped = true,
    )));
    await tester.tap(find.byType(ListTile));
    await tester.pump();
    expect(tapped, isTrue);
  });

  testWidgets('HabitTile exposes semantics containing the habit name',
      (tester) async {
    await tester.pumpWidget(wrap(HabitTile(
      habit: habit,
      onToggle: () {},
      onTap: () {},
    )));
    final semanticsNode = tester.getSemantics(find.byType(ListTile));
    expect(semanticsNode.label, contains("Boire de l'eau"));
  });
}