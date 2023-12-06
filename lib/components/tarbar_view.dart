import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:gap/gap.dart';
import 'package:training/util/api_service.dart';

class WordMeaningWidget extends StatefulWidget {
  final String word;
  const WordMeaningWidget({super.key, required this.word});

  @override
  State<WordMeaningWidget> createState() => _WordMeaningWidgetState();
}

class _WordMeaningWidgetState extends State<WordMeaningWidget> {
  void _playTts(String text) async {
    FlutterTts tts = FlutterTts();
    await tts.setLanguage('en');
    await tts.setSpeechRate(0.5);
    await tts.setPitch(1);
    await tts.speak(text);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.word,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 22,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: null,
                      child: Icon(Icons.note_alt_sharp),
                    ),
                    GestureDetector(
                      onTap: null,
                      child: Icon(Icons.save),
                    ),
                  ],
                ),
              )
            ],
          ),
          Gap(10),
          FutureBuilder(
              future: WordDetail().getSpelling(widget.word),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.data != null) {
                    return Row(
                      children: [
                        Text(
                          snapshot.data!,
                          style: TextStyle(
                              color: Color.fromARGB(255, 185, 178, 178),
                              fontWeight: FontWeight.w700,
                              fontSize: 20),
                        ),
                        GestureDetector(
                          onTap: () {
                            _playTts(widget.word);
                          },
                          child: Icon(
                            Icons.volume_up_outlined,
                            color: Color.fromRGBO(99, 115, 156, 0.914),
                            size: 25,
                          ),
                        ),
                      ],
                    );
                  } else {
                    return Gap(5);
                  }
                } else {
                  return CircularProgressIndicator();
                }
              }),
          Gap(10),
          FutureBuilder(
              future: TranslationService().translate(widget.word, 'en', 'vi'),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return Row(
                    children: [
                      Icon(
                        Icons.arrow_right_outlined,
                        size: 30,
                      ),
                      Text(
                        snapshot.data!,
                        style: TextStyle(
                            color: Color.fromARGB(255, 71, 67, 67),
                            fontWeight: FontWeight.w700,
                            fontSize: 20),
                      ),
                    ],
                  );
                } else {
                  return CircularProgressIndicator();
                }
              }),
        ],
      ),
    );
  }
}

class WordNetWidget extends StatefulWidget {
  final String word;
  const WordNetWidget({super.key, required this.word});

  @override
  State<WordNetWidget> createState() => _WordNetWidgetState();
}

class _WordNetWidgetState extends State<WordNetWidget> {
  List<Map<String, dynamic>>? meanings;

  @override
  void initState() {
    super.initState();
    fetchMeanings();
  }

  Future<void> fetchMeanings() async {
    final result = await WordDetail().fetchMeanings(widget.word);
    setState(() {
      meanings = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return meanings == null
        ? SizedBox(
            height: 10,
            width: 20,
            child: CircularProgressIndicator(),
          )
        : ListView.builder(
            itemCount: meanings!.length,
            itemBuilder: (context, index) {
              final meaning = meanings![index];
              return ListTile(
                title: Text("Part of Speech: ${meaning['partOfSpeech']}"),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ...meaning['definitions'].map<Widget>((def) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Definition: ${def['definition']}"),
                          if ((def['synonyms'] as List).isNotEmpty)
                            Text(
                                "Synonyms: ${(def['synonyms'] as List).join(', ')}"),
                          if ((def['antonyms'] as List).isNotEmpty)
                            Text(
                                "Antonyms: ${(def['antonyms'] as List).join(', ')}"),
                        ],
                      );
                    }).toList(),
                    if ((meaning['synonyms'] as List).isNotEmpty)
                      Text(
                          "Synonyms: ${(meaning['synonyms'] as List).join(', ')}"),
                    if ((meaning['antonyms'] as List).isNotEmpty)
                      Text(
                          "Antonyms: ${(meaning['antonyms'] as List).join(', ')}"),
                  ],
                ),
              );
            },
          );
  }
}

class NoteWidget extends StatelessWidget {
  const NoteWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("It's sunny here"),
    );
  }
}
