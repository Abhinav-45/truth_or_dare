// api_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../constants/constants.dart';

class ApiService {
  static Future<String> fetchQuestion(String endpoint) async {
    final response = await http.get(Uri.parse('${Constants.apiUrl}$endpoint'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['question'];
    } else {
      throw Exception('Failed to load question');
    }
  }
}
