import 'package:http/http.dart' as http;
import 'dart:convert';

class TruthQuestionFetcher {
  static const String _baseUrl = 'https://api.truthordarebot.xyz/v1/truth';

  static Future<String> fetchQuestion({String rating = 'pg13'}) async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl?rating=$rating'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data['question'];
      } else {
        throw Exception('Failed to load question: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching question: $e');
    }
  }
}