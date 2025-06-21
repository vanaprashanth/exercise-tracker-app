import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/log.dart';

class LogStorage {
  static const String _key = 'workout_logs';

  static Future<void> saveWorkoutLog(WorkoutLog log) async {
    final prefs = await SharedPreferences.getInstance();
    final existing = prefs.getStringList(_key) ?? [];
    existing.add(jsonEncode(log.toJson()));
    await prefs.setStringList(_key, existing);
  }

  static Future<List<WorkoutLog>> fetchLogs() async {
    final prefs = await SharedPreferences.getInstance();
    final stored = prefs.getStringList(_key) ?? [];
    return stored.map((e) => WorkoutLog.fromJson(jsonDecode(e))).toList();
  }

  static Future<List<WorkoutLog>> fetchLogsForDate(DateTime date) async {
    final logs = await fetchLogs();
    return logs.where((log) {
      return log.date.year == date.year &&
          log.date.month == date.month &&
          log.date.day == date.day;
    }).toList();
  }

  static Future<void> clearLogs() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_key);
  }
}
