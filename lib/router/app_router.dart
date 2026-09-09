// lib/router/app_router.dart

import 'package:go_router/go_router.dart';
import '../features/onboarding/presentation/screens/onboarding_screen.dart';
import '../features/habits/presentation/screens/habits_list_screen.dart';
import '../features/habits/presentation/screens/habit_detail_screen.dart';
import '../features/stats/presentation/screens/stats_screen.dart';
import '../features/settings/presentation/screens/settings_screen.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', builder: (context, state) => const OnboardingScreen()),
    GoRoute(
        path: '/habits', builder: (context, state) => const HabitsListScreen()),
    GoRoute(
      path: '/habits/:id',
      builder: (context, state) =>
          HabitDetailScreen(habitId: state.pathParameters['id']!),
    ),
    GoRoute(path: '/stats', builder: (context, state) => const StatsScreen()),
    GoRoute(
        path: '/settings', builder: (context, state) => const SettingsScreen()),
  ],
);