import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:gap/gap.dart';
import 'package:training/core/common/model/translation.dart';
import 'package:training/util/api_service.dart';

class TranslateScreen extends StatefulWidget {
  const TranslateScreen({super.key});

  @override
  State<TranslateScreen> createState() => _TranslateScreenState();
}

class _TranslateScreenState extends State<TranslateScreen> {
  List<Translation> translationHistory = [];
  TextEditingController originalSentenceController = TextEditingController();
  late String sourceLanguage;
  late String targetLanguage;
  bool isLanguageSwapped = false;

  @override
  void initState() {
    sourceLanguage = 'English';
    targetLanguage = 'Vietnamese';
    super.initState();
  }

  void swapLanguage() {
    setState(() {
      isLanguageSwapped = !isLanguageSwapped;
      String temp = sourceLanguage;
      sourceLanguage = targetLanguage;
      targetLanguage = temp;
    });
  }

  void sentenceToSpeech(String sentence) async {
    await FlutterTts().setLanguage("en-US");
    await FlutterTts().setSpeechRate(1);
    await FlutterTts().setVolume(1);
    await FlutterTts().setPitch(1);
    await FlutterTts().speak(sentence);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              color: Color.fromRGBO(18, 55, 149, 0.914),
              height: MediaQuery.of(context).size.height / 12,
              child: Center(
                  child: Stack(
                alignment: Alignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(sourceLanguage,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          )),
                      Text(targetLanguage,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          )),
                    ],
                  ),
                  GestureDetector(
                    onTap: swapLanguage,
                    child: Icon(
                      Icons.swap_horiz,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                ],
              )),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: translationHistory.length,
                itemBuilder: (context, index) {
                  Translation translation = translationHistory[index];
                  return FutureBuilder<String>(
                    future: translation.translatedSentence,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        return Column(children: [
                          Gap(30),
                          // if (translation.isLanguageSwapped)
                          Text(
                            translation.translateFlow,
                            style: TextStyle(
                                color: Colors.grey.shade700, fontSize: 15),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: Row(
                              children: [
                                Image.asset(
                                  translation.sourceCountryLogoSrc,
                                  width: 25,
                                  height: 25,
                                ),
                                Gap(10),
                                Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade200,
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Text(translation.originalSentence,
                                      style: TextStyle(
                                        color:
                                            Color.fromRGBO(18, 55, 149, 0.914),
                                        fontSize: 16,
                                      )),
                                ),
                                Gap(10),
                                GestureDetector(
                                  onTap: () {
                                    sentenceToSpeech(
                                        translation.originalSentence);
                                  },
                                  child: Icon(
                                    Icons.volume_up_outlined,
                                    color: Colors.grey.shade400,
                                    size: 28,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: Row(
                              children: [
                                Image.asset(
                                  translation.targetCountryLogoSrc,
                                  width: 25,
                                  height: 25,
                                ),
                                Gap(10),
                                Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: Color.fromRGBO(18, 55, 149, 0.914),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Text('${snapshot.data}',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                      )),
                                ),
                                Gap(10),
                                GestureDetector(
                                  onTap: null,
                                  child: Icon(
                                    Icons.volume_up_outlined,
                                    color: Colors.grey.shade400,
                                    size: 28,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ]);
                      } else {
                        return CircularProgressIndicator();
                      }
                    },
                  );
                },
              ),
            ),
            TextFormField(
              controller: originalSentenceController,
              decoration: InputDecoration(
                labelText: 'Type text or phase',
                border: OutlineInputBorder(),
                suffixIcon: GestureDetector(
                  onTap: () {
                    String originalSentence = originalSentenceController.text;
                    late Future<String> translatedSentence;

                    late Translation translation;
                    if (sourceLanguage == 'Vietnamese') {
                      translatedSentence = TranslationService()
                          .translate(originalSentence, 'vi', 'en');

                      setState(() {
                        translation = Translation(
                          originalSentence,
                          translatedSentence,
                          'assets/image/logo/vn_logo.png',
                          'assets/image/logo/uk_logo.png',
                          'Vietnamese to English',
                        );
                      });
                    } else {
                      translatedSentence = TranslationService()
                          .translate(originalSentence, 'en', 'vi');
                      setState(() {
                        translation = Translation(
                          originalSentence,
                          translatedSentence,
                          'assets/image/logo/uk_logo.png',
                          'assets/image/logo/vn_logo.png',
                          'English to Vietnamese',
                        );
                      });
                    }
                    translationHistory.add(translation);
                    originalSentenceController.clear();
                  },
                  child: Icon(
                    Icons.send,
                    color: Color.fromARGB(219, 39, 39, 221),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
