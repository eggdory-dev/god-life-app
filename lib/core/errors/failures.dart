import 'package:freezed_annotation/freezed_annotation.dart';

part 'failures.freezed.dart';

@freezed
class Failure with _$Failure {
  const factory Failure.server({
    required String message,
    int? statusCode,
  }) = ServerFailure;

  const factory Failure.network({
    required String message,
  }) = NetworkFailure;

  const factory Failure.cache({
    required String message,
  }) = CacheFailure;

  const factory Failure.authentication({
    required String message,
  }) = AuthenticationFailure;

  const factory Failure.validation({
    required String message,
    Map<String, String>? errors,
  }) = ValidationFailure;

  const factory Failure.notFound({
    required String message,
  }) = NotFoundFailure;

  const factory Failure.business({
    required String message,
  }) = BusinessFailure;

  const factory Failure.rateLimitExceeded({
    required String message,
    DateTime? retryAfter,
  }) = RateLimitFailure;

  const factory Failure.unknown({
    required String message,
  }) = UnknownFailure;
}

extension FailureX on Failure {
  String get userMessage {
    return when(
      server: (message, _) => '서버 오류가 발생했습니다: $message',
      network: (message) => '네트워크 연결을 확인해주세요',
      cache: (message) => '로컬 데이터 오류가 발생했습니다',
      authentication: (message) => '인증이 필요합니다. 다시 로그인해주세요',
      validation: (message, _) => message,
      notFound: (message) => '요청하신 데이터를 찾을 수 없습니다',
      business: (message) => message,
      rateLimitExceeded: (message, _) => '요청 한도를 초과했습니다. 잠시 후 다시 시도해주세요',
      unknown: (message) => '알 수 없는 오류가 발생했습니다',
    );
  }
}
