import 'dart:convert';

class EssentialWord {
  final String english;
  final String phonetic;
  final String vietnamese;

  EssentialWord({
    required this.english,
    required this.phonetic,
    required this.vietnamese,
  });
}

List<EssentialWord> parseData(String json) {
  final parsed = jsonDecode(json).cast<Map<String, dynamic>>();
  return parsed
      .map<EssentialWord>((json) => EssentialWord(
            english: json['english'],
            phonetic: json['phonetic'],
            vietnamese: json['vietnamese'],
          ))
      .toList();
}
