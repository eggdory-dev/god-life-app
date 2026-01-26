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

  // Handle GoRouter deep link errors (Supabase OAuth callbacks)
  final originalOnError = FlutterError.onError;
  FlutterError.onError = (FlutterErrorDetails details) {
    // Ignore GoRouter origin errors for custom schemes (Supabase deep links)
    if (details.exception is StateError &&
        details.exception.toString().contains('Origin is only applicable to schemes http and https')) {
      // Supabase handles these deep links, so we can safely ignore this error
      debugPrint('🔇 Ignoring GoRouter deep link error (handled by Supabase)');
      return;
    }
    // Call original error handler for other errors
    if (originalOnError != null) {
      originalOnError(details);
    }
  };

  // Initialize Firebase
  await Firebase.initializeApp();
  debugPrint('🔥 Firebase 초기화 완료');

  // Initialize Supabase with persistent session
  await Supabase.initialize(
    url: SupabaseConfig.supabaseUrl,
    anonKey: SupabaseConfig.supabaseAnonKey,
    authOptions: const FlutterAuthClientOptions(
      authFlowType: AuthFlowType.pkce,
      // Automatically persist session to local storage (SharedPreferences)
      // Automatically refresh token when expired
    ),
    // Default localStorage uses SharedPreferences
  );
  debugPrint('✅ Supabase 초기화 완료');

  // Check if session exists on startup
  final session = Supabase.instance.client.auth.currentSession;
  if (session != null) {
    debugPrint('✅ 저장된 세션 복원됨: ${session.user.email}');
  } else {
    debugPrint('ℹ️ 저장된 세션 없음');
  }

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
