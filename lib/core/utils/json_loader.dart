import 'dart:convert';
import 'package:flutter/services.dart';

class JsonLoader {
  static Future<List<dynamic>> loadJsonList(String path) async {
    String data = await rootBundle.loadString(path);
    return jsonDecode(data) as List<dynamic>;
  }
}
