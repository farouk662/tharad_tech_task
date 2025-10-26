import 'package:dio/dio.dart';

/// Base exception for all app errors
class CustomException implements Exception {
  final String message;
  CustomException(this.message);
}

/// Exception for network / Dio related errors
class NetworkException extends CustomException {
  NetworkException(super.message);
}
/// Exception for server / API errors
class ServerException extends CustomException {
  ServerException(super.message);
}

/// Exception for cache / SharedPrefs errors
class CacheException extends CustomException {
  CacheException(super.message);
}

/// Exception for permission / device errors
class PermissionException extends CustomException {
  PermissionException(super.message);
}
/// Exception for unauthorized access errors
class UnauthorizedException extends CustomException {
  UnauthorizedException(super.message);
}

/// Exception for file size exceeding limits
class FileTooLargeException extends CustomException {
  FileTooLargeException(super.message);
}
// help function to map DioException to user-friendly messages
String mapDioError(DioException e) {
  switch (e.type) {
    case DioExceptionType.connectionTimeout:
    case DioExceptionType.sendTimeout:
    case DioExceptionType.receiveTimeout:
      return "انتهت مهلة الاتصال بالخادم. يرجى المحاولة مرة أخرى.";

    case DioExceptionType.badResponse:
      return "حدث خطأ في الخادم (${e.response?.statusCode}).";

    case DioExceptionType.connectionError:
      return "لا يوجد اتصال بالإنترنت. يرجى التحقق من الشبكة.";

    case DioExceptionType.cancel:
      return "تم إلغاء الطلب.";

    case DioExceptionType.badCertificate:
      return "شهادة الأمان غير صالحة. الاتصال غير آمن.";

    case DioExceptionType.unknown:
      return "حدث خطأ غير متوقع أثناء الاتصال.";
  }
}
