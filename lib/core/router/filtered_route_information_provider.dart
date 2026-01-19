import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Custom RouteInformationProvider that filters out OAuth callback deep links
/// This prevents GoRouter from trying to parse custom scheme URIs
class FilteredRouteInformationProvider extends RouteInformationProvider
    with WidgetsBindingObserver, ChangeNotifier {
  FilteredRouteInformationProvider({
    required RouteInformation initialRouteInformation,
  }) : _value = initialRouteInformation {
    WidgetsBinding.instance.addObserver(this);
  }

  static const _kIgnoredSchemes = ['com.eggdory.godlifeapp'];

  RouteInformation _value;

  @override
  RouteInformation get value => _value;

  void _setValue(RouteInformation value) {
    if (_value == value) return;
    _value = value;
    notifyListeners();
  }

  @override
  Future<bool> didPushRouteInformation(RouteInformation routeInformation) {
    final uri = routeInformation.uri;

    // Filter out OAuth callback deep links
    if (_kIgnoredSchemes.contains(uri.scheme)) {
      debugPrint('🔗 Filtering OAuth callback from GoRouter: $uri');
      return Future.value(true); // Handled (by Supabase)
    }

    _setValue(routeInformation);
    return Future.value(true);
  }

  @override
  Future<bool> didPushRoute(String route) {
    // Check if this is an OAuth callback
    final uri = Uri.tryParse(route);
    if (uri != null && _kIgnoredSchemes.contains(uri.scheme)) {
      debugPrint('🔗 Filtering OAuth callback route from GoRouter: $route');
      return Future.value(true); // Handled (by Supabase)
    }

    _setValue(RouteInformation(uri: Uri.parse(route)));
    return Future.value(true);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
}
