import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../presentation/screens/splash/splash_screen.dart';
import '../../presentation/screens/login/login_screen.dart';
import '../../presentation/screens/onboarding/theme_selection_screen.dart';
import '../../presentation/screens/onboarding/personality_selection_screen.dart';
import '../../presentation/screens/onboarding/profile_setup_screen.dart';
import '../../presentation/screens/onboarding/notification_permission_screen.dart';
import '../../presentation/screens/onboarding/intro_screen.dart';
import '../../presentation/screens/routine/routine_list_screen.dart';
import '../../presentation/screens/routine/routine_form_screen.dart';
import '../../presentation/screens/routine/routine_detail_screen.dart';
import '../../presentation/screens/home/home_screen.dart';
import '../../presentation/screens/coaching/coaching_home_screen.dart';
import '../../presentation/screens/coaching/chat_screen.dart';
import '../../presentation/screens/coaching/report_screen.dart';
import '../../presentation/screens/settings/settings_screen.dart';
import '../../presentation/screens/settings/profile_edit_screen.dart';
import '../../presentation/screens/settings/notification_settings_screen.dart';
import '../../presentation/screens/main/main_shell_screen.dart';
import '../../core/constants/enums.dart';
import '../../presentation/providers/auth/auth_provider.dart';
import 'refresh_stream.dart';

/// GoRouter configuration for the app
final goRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/',
    debugLogDiagnostics: true,
    refreshListenable: GoRouterRefreshStream(
      ref.watch(authStateChangesProvider.stream),
    ),
    redirect: (context, state) {
      final user = ref.read(authProvider).value;
      final isAuthenticated = user != null;

      final isSplash = state.matchedLocation == '/';
      final isLogin = state.matchedLocation == '/login';
      final isOnboarding = state.matchedLocation.startsWith('/onboarding');
      final isProtected = !['/login', '/'].contains(state.matchedLocation);

      // Allow splash to run its own logic
      if (isSplash) return null;

      // Unauthenticated user trying to access protected route
      if (!isAuthenticated && isProtected) {
        return '/login';
      }

      // Authenticated user
      if (isAuthenticated) {
        // Already on login page → redirect to app
        if (isLogin) {
          final onboardingDone = ref.read(onboardingCompletedProvider).value ?? false;
          return onboardingDone ? '/home' : '/onboarding';
        }

        // Trying to access app but onboarding not done
        if (!isOnboarding && isProtected) {
          final onboardingDone = ref.read(onboardingCompletedProvider).value ?? false;
          if (!onboardingDone) return '/onboarding';
        }
      }

      return null; // Allow navigation
    },
    routes: [
      // Splash screen
      GoRoute(
        path: '/',
        name: 'splash',
        builder: (context, state) => const SplashScreen(),
      ),

      // Login screen
      GoRoute(
        path: '/login',
        name: 'login',
        builder: (context, state) => const LoginScreen(),
      ),

      // Onboarding routes (Week 3-4)
      GoRoute(
        path: '/onboarding',
        name: 'onboarding',
        builder: (context, state) => const ThemeSelectionScreen(),
        routes: [
          GoRoute(
            path: 'personality',
            name: 'onboarding-personality',
            builder: (context, state) {
              final extra = state.extra as Map<String, dynamic>?;
              final theme = extra?['theme'] as AppTheme?;
              if (theme == null) {
                return const ThemeSelectionScreen();
              }
              return PersonalitySelectionScreen(theme: theme);
            },
          ),
          GoRoute(
            path: 'profile',
            name: 'onboarding-profile',
            builder: (context, state) {
              final extra = state.extra as Map<String, dynamic>?;
              final theme = extra?['theme'] as AppTheme?;
              final personality = extra?['personality'] as PersonalityType?;
              if (theme == null || personality == null) {
                return const ThemeSelectionScreen();
              }
              return ProfileSetupScreen(
                theme: theme,
                personality: personality,
              );
            },
          ),
          GoRoute(
            path: 'notification',
            name: 'onboarding-notification',
            builder: (context, state) {
              final extra = state.extra as Map<String, dynamic>?;
              final theme = extra?['theme'] as AppTheme?;
              final personality = extra?['personality'] as PersonalityType?;
              final name = extra?['name'] as String?;
              if (theme == null || personality == null || name == null) {
                return const ThemeSelectionScreen();
              }
              return NotificationPermissionScreen(
                theme: theme,
                personality: personality,
                name: name,
              );
            },
          ),
          GoRoute(
            path: 'intro',
            name: 'onboarding-intro',
            builder: (context, state) {
              final extra = state.extra as Map<String, dynamic>?;
              final theme = extra?['theme'] as AppTheme?;
              final personality = extra?['personality'] as PersonalityType?;
              final name = extra?['name'] as String?;
              final notificationsEnabled = extra?['notificationsEnabled'] as bool? ?? false;
              if (theme == null || personality == null || name == null) {
                return const ThemeSelectionScreen();
              }
              return IntroScreen(
                theme: theme,
                personality: personality,
                name: name,
                notificationsEnabled: notificationsEnabled,
              );
            },
          ),
        ],
      ),

      // Main app shell with bottom navigation
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return MainShellScreen(navigationShell: navigationShell);
        },
        branches: [
          // Home branch
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/home',
                name: 'home',
                builder: (context, state) => const HomeScreen(),
              ),
            ],
          ),
          // Routine branch
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/routine',
                name: 'routine',
                builder: (context, state) => const RoutineListScreen(),
              ),
            ],
          ),
          // Coaching branch
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/coaching',
                name: 'coaching',
                builder: (context, state) => const CoachingHomeScreen(),
              ),
            ],
          ),
          // Settings branch
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/settings',
                name: 'settings',
                builder: (context, state) => const SettingsScreen(),
              ),
            ],
          ),
        ],
      ),

      // Detail routes (outside bottom navigation)
      GoRoute(
        path: '/routine/create',
        name: 'routine-create',
        builder: (context, state) => const RoutineFormScreen(),
      ),
      GoRoute(
        path: '/routine/:id',
        name: 'routine-detail',
        builder: (context, state) {
          final id = state.pathParameters['id'] ?? '';
          return RoutineDetailScreen(routineId: id);
        },
      ),
      GoRoute(
        path: '/coaching/chat/:id',
        name: 'coaching-chat',
        builder: (context, state) {
          final id = state.pathParameters['id'] ?? '';
          return ChatScreen(conversationId: id);
        },
      ),
      GoRoute(
        path: '/coaching/report/:id',
        name: 'coaching-report',
        builder: (context, state) {
          final id = state.pathParameters['id'] ?? '';
          return ReportScreen(reportId: id);
        },
      ),
      GoRoute(
        path: '/settings/profile',
        name: 'settings-profile',
        builder: (context, state) => const ProfileEditScreen(),
      ),
      GoRoute(
        path: '/settings/notifications',
        name: 'settings-notifications',
        builder: (context, state) => const NotificationSettingsScreen(),
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 48, color: Colors.red),
            const SizedBox(height: 16),
            Text(
              'Page not found',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text(state.uri.toString()),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => context.go('/'),
              child: const Text('Go Home'),
            ),
          ],
        ),
      ),
    ),
  );
});
