import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:gap/gap.dart';
import 'package:training/components/language_selector.dart';
import 'package:training/core/common/model/translation.dart';
import 'package:training/core/enum/country.dart';
import 'package:training/modules/translatePage/bloc/language/language_bloc.dart';
import 'package:training/util/api_service.dart';

class TranslateScreen extends StatefulWidget {
  const TranslateScreen({super.key});

  @override
  State<TranslateScreen> createState() => _TranslateScreenState();
}

class _TranslateScreenState extends State<TranslateScreen> {
  List<Translation> translationHistory = [];
  TextEditingController originalSentenceController = TextEditingController();
  bool isLanguageSwapped = false;

  LanguageBloc languageBloc = LanguageBloc();
  // String selectedSourceLanguage = Country.United_Kingdom.format;
  // String selectedTargetLanguage = Country.Vietnam.format;
  late Country selectedSourceLanguage;
  late Country selectedTargetLanguage;
  bool isLoading = false;

  @override
  void initState() {
    selectedTargetLanguage = Country.Vietnam;
    selectedSourceLanguage = Country.United_Kingdom;
    super.initState();
  }

  void swapLanguage() {
    setState(() {
      isLanguageSwapped = !isLanguageSwapped;
      Country temp = selectedSourceLanguage;
      selectedSourceLanguage = selectedTargetLanguage;
      selectedTargetLanguage = temp;
    });
  }

  void sentenceToSpeech() async {
    await FlutterTts().setLanguage("vi-VN");
    await FlutterTts().setSpeechRate(1);
    await FlutterTts().setVolume(1);
    await FlutterTts().setPitch(1);
    await FlutterTts().speak(
        'Lưu ý rằng nếu nội dung vượt quá chiều rộng của Container, nó có thể ảnh hưởng đến giao diện người dùng của bạn. Hãy đảm bảo kiểm tra và điều chỉnh chiều rộng của Container để đảm bảo trải nghiệm người dùng tốt nhất.');
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
                  LanguageSelector(
                    selectedLanguage: selectedSourceLanguage,
                    isSourceLanguage: true,
                    onLanguageChanged: (newLanguage) {
                      setState(() {
                        selectedSourceLanguage = newLanguage;
                      });
                    },
                  ),
                  LanguageSelector(
                    selectedLanguage: selectedTargetLanguage,
                    isSourceLanguage: false,
                    onLanguageChanged: (newLanguage) {
                      setState(() {
                        selectedTargetLanguage = newLanguage;
                      });
                    },
                  )
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
              return Column(children: [
                Gap(30),
                Text(
                  translation.translateFlow,
                  style: TextStyle(color: Colors.grey.shade700, fontSize: 15),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    children: [
                      translation.sourceCountryLogoSrc,
                      Gap(10),
                      Container(
                        constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width - 100,
                        ),
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Text(
                          translation.originalSentence,
                          style: TextStyle(
                            color: Color.fromRGBO(18, 55, 149, 0.914),
                            fontSize: 16,
                          ),
                          overflow: TextOverflow.visible,
                        ),
                      ),
                      Gap(10),
                      GestureDetector(
                        onTap: () {
                          sentenceToSpeech();
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
                      translation.targetCountryLogoSrc,
                      Gap(10),
                      Container(
                        constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width - 100,
                        ),
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(18, 55, 149, 0.914),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Text(
                          translation.translatedSentence,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                          overflow: TextOverflow.visible,
                        ),
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
            },
          ),
        ),
        TextFormField(
          controller: originalSentenceController,
          decoration: InputDecoration(
            labelText: 'Type text or phase',
            border: OutlineInputBorder(),
            suffixIcon: GestureDetector(
              onTap: () async {
                setState(() {
                  isLoading = true;
                });

                late String isoSourceCountryCode, isoTargetCountryCode;
                late String translatedSentence;
                late Translation translation;
                String originalSentence = originalSentenceController.text;
                String selectedSourceLanguageCode =
                    selectedSourceLanguage.countryCode;
                String selectedTargetLanguageCode =
                    selectedTargetLanguage.countryCode;
                String formatedSourceLanguage = selectedSourceLanguage.format;
                String formatedTargetLanguage = selectedTargetLanguage.format;
                try {
                  isoSourceCountryCode = await TranslationService()
                      .getISOCountryCode(formatedSourceLanguage);
                  isoTargetCountryCode = await TranslationService()
                      .getISOCountryCode(formatedTargetLanguage);
                  translatedSentence = await TranslationService().translate(
                      originalSentence,
                      selectedSourceLanguageCode,
                      selectedTargetLanguageCode);
                } catch (error) {
                  print(error);
                } finally {
                  setState(() {
                    isLoading = false;
                  });
                }
                print(isoTargetCountryCode);
                print(selectedTargetLanguageCode);
                setState(() {
                  translation = Translation(
                    originalSentence,
                    translatedSentence,
                    Image.network(
                        'https://flagcdn.com/24x18/${isoSourceCountryCode.toLowerCase()}.png'),
                    Image.network(
                        'https://flagcdn.com/24x18/${isoTargetCountryCode.toLowerCase()}.png'),
                    '$formatedSourceLanguage to $formatedTargetLanguage',
                  );
                });

                translationHistory.add(translation);
                originalSentenceController.clear();
              },
              child: isLoading
                  ? CircularProgressIndicator()
                  : Icon(
                      Icons.send,
                      color: Color.fromARGB(219, 39, 39, 221),
                    ),
            ),
          ),
        ),
      ],
    )));
  }
}
