import 'dart:io';
import 'package:dio/dio.dart';
import 'package:go_router/go_router.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:tharad_flutter_task/core/routing/app_router.dart';
import '../error/exception.dart';
import '../network/endpoints.dart';
import '../services/hive_service.dart';

class DioService {
  // ===========================================================
  // =============== SINGLETON SETUP ============================
  // ===========================================================
  static final DioService _instance = DioService._internal();

  factory DioService() => _instance;

  late final Dio _dio;
  String? _authToken;

  DioService._internal() {
    _dio = Dio(
      BaseOptions(
        baseUrl: EndPoints.baseUrl,
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 15),
        sendTimeout: const Duration(seconds: 15),
        headers: {'Accept': 'application/json'},
      ),
    );

    _addInterceptors();
    _loadToken();
  }

  // ===========================================================
  // ================= AUTH TOKEN HANDLING =====================
  // ===========================================================

  void setAuthToken(String token) {
    _authToken = token;
    _dio.options.headers['Authorization'] = 'Bearer $token';
  }

  void clearAuthToken() {
    _authToken = null;
    _dio.options.headers.remove('Authorization');
  }

  Future<void> _loadToken() async {
    _authToken = HiveService.getToken();
    if (_authToken != null) {
      _dio.options.headers['Authorization'] = 'Bearer $_authToken';
    }
  }

  // ===========================================================
  // ================== INTERCEPTORS ===========================
  // ===========================================================

  void _addInterceptors() {
    _dio.interceptors.add(PrettyDioLogger(requestHeader: true, requestBody: true));

    _dio.interceptors.add(
      InterceptorsWrapper(
        onError: (DioException e, handler) {
          if (e.response?.statusCode == 401) {
            // handle unauthorized globally (e.g., logout)
            _handleUnauthorized();
          }
          return handler.next(e);
        },
      ),
    );
  }

  Future<void> _handleUnauthorized() async {
    await HiveService.clearAuthData();
    clearAuthToken();

    // ✅ Use your AppRouter
    AppRouter.rootNavigatorKey.currentContext?.go(AppRouter.loginRoute);
  }

  // ===========================================================
  // ================= UNIVERSAL GET ===========================
  // ===========================================================

  Future<Map<String, dynamic>> get(String path, {Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await _dio.get(path, queryParameters: queryParameters);
      return _handleResponse(response);
    } on DioException catch (e) {
      throw NetworkException(_mapDioError(e));
    }
  }

  // ===========================================================
  // ================= UNIVERSAL POST ==========================
  // ===========================================================

  Future<Map<String, dynamic>> post(String path, {dynamic data, bool isFormData = true}) async {
    try {
      final requestData = await _prepareData(data, isFormData);
      final response = await _dio.post(path, data: requestData);
      return _handleResponse(response);
    } on DioException catch (e) {
      throw NetworkException(_mapDioError(e));
    }
  }

  // ===========================================================
  // ================= UNIVERSAL PUT ===========================
  // ===========================================================

  Future<Map<String, dynamic>> put(String path, {dynamic data, bool isFormData = false}) async {
    try {
      final requestData = await _prepareData(data, isFormData);
      final response = await _dio.put(path, data: requestData);
      return _handleResponse(response);
    } on DioException catch (e) {
      throw NetworkException(_mapDioError(e));
    }
  }

  // ===========================================================
  // ================= UNIVERSAL DELETE ========================
  // ===========================================================

  Future<Map<String, dynamic>> delete(String path, {dynamic data}) async {
    try {
      final response = await _dio.delete(path, data: data);
      return _handleResponse(response);
    } on DioException catch (e) {
      throw NetworkException(_mapDioError(e));
    }
  }

  // ===========================================================
  // =========== FORM DATA AUTO CONVERSION HANDLER =============
  // ===========================================================

  Future<dynamic> _prepareData(dynamic data, bool isFormData) async {
    if (!isFormData) return data;

    // If user already passed a FormData → use it directly
    if (data is FormData) return data;

    // If user passed a Map → check for files and convert
    if (data is Map<String, dynamic>) {
      final convertedMap = <String, dynamic>{};

      for (final entry in data.entries) {
        final value = entry.value;

        if (value is File) {
          convertedMap[entry.key] = await MultipartFile.fromFile(
            value.path,
            filename: value.path.split('/').last,
          );
        } else {
          convertedMap[entry.key] = value;
        }
      }

      return FormData.fromMap(convertedMap);
    }

    // otherwise, just return data as-is
    return data;
  }

  // ===========================================================
  // ================= RESPONSE HANDLER ========================
  // ===========================================================

  Map<String, dynamic> _handleResponse(Response response) {
    final statusCode = response.statusCode ?? 0;

    if (statusCode >= 200 && statusCode < 300) {
      if (response.data is Map<String, dynamic>) return response.data;
      if (response.data is List) return {'data': response.data};
      return {'data': response.data.toString()};
    }

    throw NetworkException("Server error: ${response.statusCode ?? 'Unknown'}");
  }

  // ===========================================================
  // ================= ERROR MAPPING ===========================
  // ===========================================================

  String _mapDioError(DioException e) {
    final data = e.response?.data;

    if (data is Map<String, dynamic>) {
      final message = data['message']?.toString() ?? '';
      final errors = data['errors'];

      // 🔐 حالة بيانات خاطئة (مثل إيميل أو كلمة مرور)
      if (message.contains("Invalid credentials") ||
          message.contains("Login failed") ||
          message.contains("Wrong password")) {
        return "البريد الإلكتروني أو كلمة المرور غير صحيحة";
      }
      if (message.contains("Invalid OTP")) {
        return 'رمز التحقق غير صحيح أو منتهي الصلاحية، يرجى المحاولة مرة أخرى.';
      }

      // استخراج أول خطأ من errors إذا موجود
      if (errors is Map && errors.isNotEmpty) {
        final firstError = errors.values.first;
        if (firstError is List && firstError.isNotEmpty) {
          return _translateError(firstError.first.toString());
        }
      }

      // رسالة مباشرة من السيرفر
      if (message.isNotEmpty) {
        return _translateError(message);
      }
    }

    // 🌐 fallback للأخطاء العامة
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return "انتهت مهلة الاتصال، يرجى المحاولة مرة أخرى.";
      case DioExceptionType.badResponse:
        return "حدث خطأ في الخادم (${e.response?.statusCode ?? ''}).";
      case DioExceptionType.connectionError:
        return "لا يوجد اتصال بالإنترنت. تحقق من الشبكة.";
      case DioExceptionType.cancel:
        return "تم إلغاء العملية.";
      case DioExceptionType.badCertificate:
        return "الشهادة الأمنية غير صحيحة، الاتصال غير آمن.";
      case DioExceptionType.unknown:
        return "حدث خطأ غير متوقع، يرجى المحاولة لاحقًا.";
    }
  }

  String _translateError(String message) {
    // 🎯 ترجمة سريعة لرسائل محددة من السيرفر إنجليزي ➝ عربي
    if (message.contains("email") && message.contains("required")) {
      return "البريد الإلكتروني مطلوب";
    }
    if (message.contains("password") && message.contains("required")) {
      return "كلمة المرور مطلوبة";
    }
    if (message.contains("password") && message.contains("at least")) {
      return "كلمة المرور يجب أن تكون أقوى";
    }
    if (message.contains("not found")) {
      return "لم يتم العثور على البيانات المطلوبة";
    }

    // 🎗️ إذا لم نجد ترجمة محددة نعيد الرسالة الأصلية
    return message;
  }
}
