import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'core/config/supabase_config.dart';
import 'core/notifications/notification_service.dart';
import 'core/providers/core_providers.dart';
import 'core/router/app_router.dart';
import 'core/router/filtered_route_information_provider.dart';
import 'core/theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp();
  debugPrint('🔥 Firebase 초기화 완료');

  // Initialize Supabase
  await Supabase.initialize(
    url: SupabaseConfig.supabaseUrl,
    anonKey: SupabaseConfig.supabaseAnonKey,
  );
  debugPrint('✅ Supabase 초기화 완료');

  // Auth state change listener for debugging
  Supabase.instance.client.auth.onAuthStateChange.listen((data) {
    final event = data.event;
    final session = data.session;
    debugPrint('🔔 Supabase Auth State Changed: $event');
    if (session != null) {
      debugPrint('✅ User: ${session.user.email}');
    } else {
      debugPrint('❌ No session');
    }
  });

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

class GodLifeApp extends ConsumerStatefulWidget {
  const GodLifeApp({super.key});

  @override
  ConsumerState<GodLifeApp> createState() => _GodLifeAppState();
}

class _GodLifeAppState extends ConsumerState<GodLifeApp> {
  late final FilteredRouteInformationProvider _routeInformationProvider;

  @override
  void initState() {
    super.initState();
    _routeInformationProvider = FilteredRouteInformationProvider(
      initialRouteInformation: RouteInformation(uri: Uri.parse('/')),
    );
  }

  @override
  void dispose() {
    _routeInformationProvider.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final router = ref.watch(goRouterProvider);
    final appTheme = ref.watch(themeModeProvider);

    return MaterialApp.router(
      title: 'God Life',
      debugShowCheckedModeBanner: false,

      // Theme configuration
      theme: AppThemeData.lightTheme(appTheme),
      darkTheme: AppThemeData.darkTheme(appTheme),
      themeMode: ThemeMode.system,

      // Router configuration with custom route information provider
      routerDelegate: router.routerDelegate,
      routeInformationParser: router.routeInformationParser,
      routeInformationProvider: _routeInformationProvider,
      backButtonDispatcher: router.backButtonDispatcher,

      // Localization will be added in future phases
    );
  }
}
