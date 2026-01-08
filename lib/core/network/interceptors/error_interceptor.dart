import 'package:dio/dio.dart';
import '../../errors/exceptions.dart';

class ErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    Exception exception;

    switch (err.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        exception = NetworkException('연결 시간이 초과되었습니다');
        break;

      case DioExceptionType.badResponse:
        final statusCode = err.response?.statusCode;
        final message = err.response?.data['message'] ?? '서버 오류가 발생했습니다';

        if (statusCode == 401) {
          exception = AuthenticationException(message);
        } else if (statusCode == 404) {
          exception = NotFoundException(message);
        } else if (statusCode == 429) {
          exception = RateLimitException(message);
        } else if (statusCode == 422) {
          final errors = err.response?.data['errors'] as Map<String, dynamic>?;
          exception = ValidationException(
            message,
            errors?.map((key, value) => MapEntry(key, value.toString())),
          );
        } else {
          exception = ServerException(message, statusCode);
        }
        break;

      case DioExceptionType.cancel:
        exception = NetworkException('요청이 취소되었습니다');
        break;

      case DioExceptionType.connectionError:
        exception = NetworkException('네트워크 연결을 확인해주세요');
        break;

      default:
        exception = NetworkException('알 수 없는 네트워크 오류가 발생했습니다');
    }

    handler.reject(
      DioException(
        requestOptions: err.requestOptions,
        error: exception,
        type: err.type,
        response: err.response,
      ),
    );
  }
}
