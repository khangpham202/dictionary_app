import 'dart:convert';
import 'package:http/http.dart' as http;

class TranslationService {
  Future<String> translate(
      String text, String sourceLanguage, String targetLanguage) async {
    final response = await http.get(
      Uri.parse(
          'https://api.mymemory.translated.net/get?q=$text&langpair=$sourceLanguage|$targetLanguage'),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      return data['responseData']['translatedText'];
    } else {
      throw Exception('Failed to translate text');
    }
  }
}

class WordSuggestion {
  Future<List<String>> getSuggestions(String query) async {
    final response =
        await http.get(Uri.parse('https://api.datamuse.com/sug?s=$query'));

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = json.decode(response.body);
      List<String> suggestionsList =
          jsonResponse.map((dynamic item) => item['word'].toString()).toList();
      return suggestionsList;
    } else {
      throw Exception('Failed to load suggestions');
    }
  }
}
