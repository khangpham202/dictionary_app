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

  Future<String> getISOCountryCode(String countryName) async {
    final response = await http.get(Uri.parse(
        'https://restcountries.com/v3.1/name/$countryName?fullText=true'));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);

      if (data.isNotEmpty) {
        String isoCode = data[0]['cca2'] ?? '';
        return isoCode;
      } else {
        throw Exception('Country not found for the given language');
      }
    } else {
      throw Exception('Failed to load country information');
    }
  }
}

class WordSuggestion {
  Future<List<String>> getSuggestions(String word) async {
    final response =
        await http.get(Uri.parse('https://api.datamuse.com/sug?s=$word'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      List<String> suggestionsList =
          data.map((dynamic item) => item['word'].toString()).toList();
      return suggestionsList;
    } else {
      throw Exception('Failed to load suggestions');
    }
  }
}

class WordDetail {
  Future<Map<String, List<String>>> getSynonyms(String word) async {
    const apiKey = '0a948b2cd94a9bbd4647a02eb555165f';
    final response = await http.get(
      Uri.parse('http://words.bighugelabs.com/api/2/$apiKey/$word/json'),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);

      Map<String, List<String>> synonymsMap = {};
      void extractWords(String type) {
        if (data.containsKey(type) &&
            data[type].containsKey('syn') &&
            data[type]['syn'] is List) {
          synonymsMap[type] = List<String>.from(data[type]['syn']);
        }
      }

      extractWords('noun');
      extractWords('verb');
      extractWords('adjective');

      return synonymsMap;
    } else {
      throw Exception('Failed to load synonyms');
    }
  }

  Future<Map<String, List<String>>> getAntonyms(String word) async {
    const apiKey = '0a948b2cd94a9bbd4647a02eb555165f';
    final response = await http.get(
      Uri.parse('http://words.bighugelabs.com/api/2/$apiKey/$word/json'),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);

      Map<String, List<String>> antonymsMap = {};
      void extractWords(String type) {
        if (data.containsKey(type) &&
            data[type].containsKey('ant') &&
            data[type]['ant'] is List) {
          antonymsMap[type] = List<String>.from(data[type]['ant']);
        }
      }

      extractWords('noun');
      extractWords('verb');
      extractWords('adjective');

      return antonymsMap;
    } else {
      throw Exception('Failed to load synonyms');
    }
  }
}
