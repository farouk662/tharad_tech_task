import 'package:hive_flutter/hive_flutter.dart';
import '../utils/hive_keys.dart';

class HiveService {
  /// Initialize Hive boxes
  static Future<void> init() async {
    await Hive.initFlutter();
    await Hive.openBox(HiveKeys.authBox);
    await Hive.openBox(HiveKeys.profileBox);
  }

  // TOKEN
  static Future<void> saveToken(String token) async {
    final box = Hive.box(HiveKeys.authBox);
    await box.put(HiveKeys.token, token);
  }

  static String? getToken() {
    final box = Hive.box(HiveKeys.authBox);
    return box.get(HiveKeys.token);
  }

  static Future<void> clearToken() async {
    final box = Hive.box(HiveKeys.authBox);
    await box.delete(HiveKeys.token);
  }

  // PROFILE
  static Future<void> saveProfile(Map<String, dynamic> profile) async {
    final box = Hive.box(HiveKeys.profileBox);
    await box.put(HiveKeys.userProfile, profile);
  }

  static Map<String, dynamic>? getProfile() {
    final box = Hive.box(HiveKeys.profileBox);
    final data = box.get(HiveKeys.userProfile);
    return data != null ? Map<String, dynamic>.from(data) : null;
  }

  static Future<void> clearProfile() async {
    final box = Hive.box(HiveKeys.profileBox);
    await box.delete(HiveKeys.userProfile);
  }

  static Future<void> updateProfile(Map<String, dynamic> updatedFields) async {
    final current = getProfile() ?? {};
    final updated = {...current, ...updatedFields};
    final box = Hive.box(HiveKeys.profileBox);
    await box.put(HiveKeys.userProfile, updated);
  }

  /// Clear both token and profile data
  static Future<void> clearAuthData() async {
    await Future.wait([
      clearToken(),
      clearProfile(),
    ]);
  }
}
