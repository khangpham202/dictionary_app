import 'dart:convert';
import 'package:http/http.dart' as http;

// API này chỉ có thể dịch sang tiếng việt
class TranslationService {
  Future<String> translate(String text, String targetLanguage) async {
    final response = await http.get(
      Uri.parse(
          'https://api.mymemory.translated.net/get?q=$text&langpair=en|$targetLanguage'),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      return data['responseData']['translatedText'];
    } else {
      throw Exception('Failed to translate text');
    }
  }
}
