import 'package:flutter/foundation.dart'; // for kReleaseMode
import 'package:logger/logger.dart';


final logger =LoggerService();
class LoggerService {
  static final LoggerService _instance = LoggerService._internal();

  late final Logger _logger;
  final bool _isLoggingEnabled = !kReleaseMode; // Only log in debug/profile mode

  factory LoggerService() => _instance;

  LoggerService._internal() {
    _logger = Logger(
      printer: PrettyPrinter(
        
      ),
    );
  }

  void debug(String message) {
    if (_isLoggingEnabled) _logger.d(message);
  }

  void info(String message) {
    if (_isLoggingEnabled) _logger.i(message);
  }

  void warning(String message) {
    if (_isLoggingEnabled) _logger.w(message);
  }

  void error(String message, [dynamic error, StackTrace? stackTrace]) {
    if (_isLoggingEnabled) _logger.e(message, error: error, stackTrace: stackTrace);
  }


}
