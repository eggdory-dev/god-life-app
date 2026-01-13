import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/notifications/notification_service.dart';
import 'core/providers/core_providers.dart';
import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize SharedPreferences
  final sharedPreferences = await SharedPreferences.getInstance();

  // Initialize NotificationService
  final notificationService = NotificationService();
  await notificationService.initialize();

  runApp(
    ProviderScope(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(sharedPreferences),
      ],
      child: const GodLifeApp(),
    ),
  );
}

class GodLifeApp extends ConsumerWidget {
  const GodLifeApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(goRouterProvider);
    final appTheme = ref.watch(themeModeProvider);

    return MaterialApp.router(
      title: 'God Life',
      debugShowCheckedModeBanner: false,

      // Theme configuration
      theme: AppThemeData.lightTheme(appTheme),
      darkTheme: AppThemeData.darkTheme(appTheme),
      themeMode: ThemeMode.system,

      // Router configuration
      routerConfig: router,

      // Localization will be added in future phases
    );
  }
}
