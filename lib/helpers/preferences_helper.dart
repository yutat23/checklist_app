import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:checklist_app/models/checklist_item.dart';

class PreferencesHelper {
  static const String checklistKey = 'checklist';
  static const String imageKey = 'image';

  static Future<List<ChecklistItem>> getChecklist() async {
    final prefs = await SharedPreferences.getInstance();
    final String? checklistJson = prefs.getString(checklistKey);
    if (checklistJson != null) {
      final List<dynamic> decodedJson = jsonDecode(checklistJson);
      return decodedJson.map((item) => ChecklistItem.fromJson(item)).toList();
    }
    return [];
  }

  static Future<void> saveChecklist(List<ChecklistItem> checklist) async {
    final prefs = await SharedPreferences.getInstance();
    final String encodedJson =
        jsonEncode(checklist.map((item) => item.toJson()).toList());
    await prefs.setString(checklistKey, encodedJson);
  }

  static Future<String?> getImagePath() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(imageKey);
  }

  static Future<void> saveImagePath(String path) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(imageKey, path);
  }
}
