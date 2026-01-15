import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../constants/app_constants.dart';

class AuthInterceptor extends Interceptor {
  final Ref ref;

  AuthInterceptor(this.ref);

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(StorageKeys.accessToken);

    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    handler.next(options);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    if (err.response?.statusCode == 401) {
      final refreshed = await _refreshToken();
      
      if (refreshed) {
        final response = await _retry(err.requestOptions);
        handler.resolve(response);
        return;
      }
    }

    handler.next(err);
  }

  Future<bool> _refreshToken() async {
    try {
      final supabase = Supabase.instance.client;
      final response = await supabase.auth.refreshSession();

      if (response.session != null) {
        // Save new tokens
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString(
          StorageKeys.accessToken,
          response.session!.accessToken,
        );
        await prefs.setString(
          StorageKeys.refreshToken,
          response.session!.refreshToken ?? '',
        );
        debugPrint('✅ Token refreshed successfully');
        return true;
      }

      return false;
    } on AuthException catch (e) {
      debugPrint('🔴 Token refresh failed: ${e.message}');
      // Refresh failed → logout
      await Supabase.instance.client.auth.signOut();
      return false;
    } catch (e) {
      debugPrint('🔴 Token refresh error: $e');
      return false;
    }
  }

  Future<Response<dynamic>> _retry(RequestOptions requestOptions) async {
    final options = Options(
      method: requestOptions.method,
      headers: requestOptions.headers,
    );

    final dio = Dio();
    return dio.request<dynamic>(
      requestOptions.path,
      data: requestOptions.data,
      queryParameters: requestOptions.queryParameters,
      options: options,
    );
  }
}
