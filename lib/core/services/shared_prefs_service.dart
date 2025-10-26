// import 'dart:convert';
// import 'package:shared_preferences/shared_preferences.dart';
//
// import '../models/student_model.dart';
//
// class SharedPrefsService {
//   static const String _userKey = "cached_user";
//
//   static Future<void> saveUser(StudentModel user) async {
//     final prefs = await SharedPreferences.getInstance();
//     final userJson = jsonEncode(user.toJson());
//     await prefs.setString(_userKey, userJson);
//   }
//
//   static Future<StudentModel?> getUser() async {
//     final prefs = await SharedPreferences.getInstance();
//     final userJson = prefs.getString(_userKey);
//     if (userJson == null) return null;
//     final Map<String, dynamic> data = jsonDecode(userJson);
//     return StudentModel.fromJson(data);
//   }
//
//   static Future<void> clearUser() async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.remove(_userKey);
//   }
//   static const _lastMarkedKey = "last_marked_time";
//
//   /// Save last attendance mark timestamp
//   static Future<void> saveLastMarked(DateTime time) async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setInt(_lastMarkedKey, time.millisecondsSinceEpoch);
//   }
//
//   /// Load last attendance mark timestamp
//   static Future<DateTime?> getLastMarked() async {
//     final prefs = await SharedPreferences.getInstance();
//     final millis = prefs.getInt(_lastMarkedKey);
//     if (millis == null) return null;
//     return DateTime.fromMillisecondsSinceEpoch(millis);
//   }
// }
