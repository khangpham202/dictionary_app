import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:training/components/language_selector.dart';
import 'package:training/core/common/model/translation.dart';
import 'package:training/core/enum/country.dart';
import 'package:training/modules/translatePage/bloc/language/language_bloc.dart';
import 'package:training/util/api_service.dart';
import 'package:training/util/speech.dart';

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
  late Country selectedSourceLanguage;
  late Country selectedTargetLanguage;

  bool isLoading = false;

  @override
  void initState() {
    selectedTargetLanguage = Country.Vietnam;
    selectedSourceLanguage = Country.United_Kingdom;
    super.initState();
  }

  // Future<bool> checkInternet() async {
  //   var connectivityResult = await Connectivity().checkConnectivity();
  //   return connectivityResult != ConnectivityResult.none;
  // }

  void swapLanguage() {
    setState(() {
      isLanguageSwapped = !isLanguageSwapped;
      Country temp = selectedSourceLanguage;
      selectedSourceLanguage = selectedTargetLanguage;
      selectedTargetLanguage = temp;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => languageBloc,
      child: Scaffold(
          body: SafeArea(
              child: Column(
        children: [
          Container(
            color: const Color.fromRGBO(18, 55, 149, 0.914),
            height: MediaQuery.of(context).size.height / 12,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                ),
                GestureDetector(
                  onTap: swapLanguage,
                  child: const Icon(
                    Icons.swap_horiz,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: translationHistory.length,
              itemBuilder: (context, index) {
                Translation translation = translationHistory[index];
                return Column(children: [
                  const Gap(30),
                  Text(
                    translation.translateFlow,
                    style: TextStyle(color: Colors.grey.shade700, fontSize: 15),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      children: [
                        translation.sourceCountryLogoSrc,
                        const Gap(10),
                        Container(
                          constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width - 100,
                          ),
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Text(
                            translation.originalSentence,
                            style: const TextStyle(
                              color: Color.fromRGBO(18, 55, 149, 0.914),
                              fontSize: 16,
                            ),
                            overflow: TextOverflow.visible,
                          ),
                        ),
                        const Gap(10),
                        GestureDetector(
                          onTap: () {
                            TextToSpeechService().playTts(
                                selectedSourceLanguage.countryCode,
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
                        translation.targetCountryLogoSrc,
                        const Gap(10),
                        Container(
                          constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width - 100,
                          ),
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: const Color.fromRGBO(18, 55, 149, 0.914),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Text(
                            translation.translatedSentence,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                            overflow: TextOverflow.visible,
                          ),
                        ),
                        const Gap(10),
                        GestureDetector(
                          onTap: () {
                            TextToSpeechService().playTts(
                                selectedTargetLanguage.countryCode,
                                translation.translatedSentence);
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
                ]);
              },
            ),
          ),
          TextFormField(
            controller: originalSentenceController,
            decoration: InputDecoration(
              labelText: 'Type text or phase',
              border: const OutlineInputBorder(),
              suffixIcon: GestureDetector(
                onTap: () async {
                  var connectivityResult =
                      await Connectivity().checkConnectivity();
                  if (connectivityResult == ConnectivityResult.mobile ||
                      connectivityResult == ConnectivityResult.wifi) {
                    setState(() {
                      isLoading = true;
                    });
                    late String isoSourceCountryCode,
                        isoTargetCountryCode,
                        translatedSentence;
                    late Translation translation;
                    String originalSentence = originalSentenceController.text;
                    String selectedSourceLanguageCode =
                        selectedSourceLanguage.countryCode;
                    String selectedTargetLanguageCode =
                        selectedTargetLanguage.countryCode;
                    String formatedSourceLanguage =
                        selectedSourceLanguage.format;
                    String formatedTargetLanguage =
                        selectedTargetLanguage.format;

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
                  } else {
                    if (!context.mounted) return;
                    showDialog(
                        context: context,
                        builder: (BuildContext context) => Dialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Container(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Text(
                                      'No internet connection!!',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 20,
                                      ),
                                    ),
                                    const Gap(5),
                                    ElevatedButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text('OK'),
                                    ),
                                  ],
                                ),
                              ),
                            ));
                  }
                },
                child: isLoading
                    ? const CircularProgressIndicator()
                    : const Icon(
                        Icons.send,
                        color: Color.fromARGB(219, 39, 39, 221),
                      ),
              ),
            ),
          ),
        ],
      ))),
    );
  }
}
