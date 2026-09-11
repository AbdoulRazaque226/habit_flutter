

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:integration_test/integration_test.dart';
import 'package:app_final/app.dart';
import 'package:app_final/features/habits/data/models/habit_model.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() async {
    final dir = await Directory.systemTemp.createTemp();
    Hive.init(dir.path);
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(HabitModelAdapter());
    }
    await Hive.openBox<HabitModel>('habits');
  });

  testWidgets(
      'Full flow: onboarding -> add habit -> see it in list',
      (tester) async {
    await tester.pumpWidget(const ProviderScope(child: App()));
    await tester.pumpAndSettle();

    expect(find.byType(FilledButton), findsOneWidget);
    await tester.tap(find.byType(FilledButton));
    await tester.pumpAndSettle();

    expect(find.byIcon(Icons.add), findsOneWidget);

    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();

    final nameField = find.byType(TextField).last;
    await tester.enterText(nameField, 'Faire du sport');
    await tester.tap(find.text('Commencer'));
    await tester.pumpAndSettle();

    expect(find.text('Faire du sport'), findsOneWidget);
  });

  testWidgets(
      'Navigation: list -> stats -> back',
      (tester) async {
    await tester.pumpWidget(const ProviderScope(child: App()));
    await tester.pumpAndSettle();

    await tester.tap(find.byType(FilledButton));
    await tester.pumpAndSettle();

    await tester.tap(find.byIcon(Icons.bar_chart));
    await tester.pumpAndSettle();

    expect(find.text('Statistiques'), findsOneWidget);

    await tester.pageBack();
    await tester.pumpAndSettle();

    expect(find.byIcon(Icons.add), findsOneWidget);
  });
}