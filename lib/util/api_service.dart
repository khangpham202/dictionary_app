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
  Future<String?> getSpelling(String word) async {
    final apiUrl = "https://api.dictionaryapi.dev/api/v2/entries/en/$word";

    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final phonetics = data[0]['phonetics'];
        String pronunciation;
        if (phonetics != null && phonetics.isNotEmpty) {
          if (phonetics[0]['text'] != null && phonetics.isNotEmpty) {
            pronunciation = phonetics[0]['text'];
            return pronunciation;
          } else {
            pronunciation = phonetics[1]['text'];
            return pronunciation;
          }
        }
      } else {
        return 'cannot get data';
      }
    } catch (e) {
      return e.toString();
    }
    return null;
  }

  Future<List<Map<String, dynamic>>?> fetchMeanings(String word) async {
    final apiUrl = "https://api.dictionaryapi.dev/api/v2/entries/en/$word";

    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        if (data is List && data.isNotEmpty) {
          final firstEntry = data[0];

          if (firstEntry.containsKey('meanings')) {
            return List<Map<String, dynamic>>.from(
                firstEntry['meanings'].map((meaning) => {
                      'partOfSpeech': meaning['partOfSpeech'],
                      'definitions': List<Map<String, dynamic>>.from(
                          meaning['definitions'].map((def) => {
                                'definition': def['definition'],
                                'synonyms':
                                    List<String>.from(def['synonyms'] ?? []),
                                'antonyms':
                                    List<String>.from(def['antonyms'] ?? []),
                              })),
                      'synonyms': List<String>.from(meaning['synonyms'] ?? []),
                      'antonyms': List<String>.from(meaning['antonyms'] ?? []),
                    }));
          } else {
            print("No meanings available");
          }
        } else {
          print("Invalid response format");
        }
      } else {
        print("Error: ${response.reasonPhrase}");
      }
    } catch (e) {
      print("Error: $e");
    }

    return null;
  }
}
