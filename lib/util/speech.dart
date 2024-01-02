import 'package:flutter_tts/flutter_tts.dart';

class TextToSpeechService {
  void playTts(String language, String sentence) async {
    FlutterTts tts = FlutterTts();
    await tts.setLanguage(language);
    (language == 'en')
        ? await tts.setSpeechRate(0.5)
        : await tts.setSpeechRate(0.8);
    await tts.setPitch(1);
    await tts.speak(sentence);
  }
}
