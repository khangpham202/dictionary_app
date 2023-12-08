import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:training/util/api_service.dart';
import 'package:training/util/speech.dart';

class WordMeaningWidget extends StatefulWidget {
  final String word;
  const WordMeaningWidget({super.key, required this.word});

  @override
  State<WordMeaningWidget> createState() => _WordMeaningWidgetState();
}

class _WordMeaningWidgetState extends State<WordMeaningWidget> {
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
              future: WordDetail().fetchPronunciation(widget.word),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.data != null) {
                    return Row(
                      children: [
                        Text(
                          snapshot.data!,
                          style: TextStyle(
                              color: Color.fromARGB(255, 111, 104, 104),
                              fontWeight: FontWeight.w700,
                              fontSize: 20),
                        ),
                        GestureDetector(
                          onTap: () {
                            TextToSpeechService().playTts('en', widget.word);
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
        : Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
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
                    future: WordDetail().fetchPronunciation(widget.word),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        if (snapshot.data != null) {
                          return Row(
                            children: [
                              Text(
                                snapshot.data!,
                                style: TextStyle(
                                    color: Color.fromARGB(255, 111, 104, 104),
                                    fontWeight: FontWeight.w700,
                                    fontSize: 20),
                              ),
                              GestureDetector(
                                onTap: () {
                                  TextToSpeechService()
                                      .playTts('en', widget.word);
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
                Expanded(
                  child: meanings != null
                      ? ListView.builder(
                          itemCount: meanings!.length,
                          itemBuilder: (context, index) {
                            final meaning = meanings![index];
                            return ListTile(
                              title: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    meaning['partOfSpeech']
                                        .toString()
                                        .toUpperCase(),
                                    style: TextStyle(
                                        color:
                                            Color.fromRGBO(18, 55, 149, 0.914),
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Gap(3),
                                ],
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ...meaning['definitions'].map<Widget>((def) {
                                    return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.circle,
                                              size: 10,
                                            ),
                                            Gap(5),
                                            Container(
                                              constraints: BoxConstraints(
                                                maxWidth: MediaQuery.of(context)
                                                        .size
                                                        .width -
                                                    100,
                                              ),
                                              child: Column(
                                                children: [
                                                  Text(
                                                    "${def['definition']}",
                                                    style: TextStyle(
                                                        color: Color.fromARGB(
                                                            255, 61, 61, 61),
                                                        fontSize: 18),
                                                    overflow:
                                                        TextOverflow.visible,
                                                  ),
                                                  Gap(3),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        if ((def['synonyms'] as List)
                                            .isNotEmpty)
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 20),
                                            child: Text(
                                              "synonyms: ${(def['synonyms'] as List).join(', ')}",
                                              style: TextStyle(
                                                color: Color.fromRGBO(
                                                    25, 66, 172, 0.914),
                                                fontSize: 17,
                                              ),
                                            ),
                                          ),
                                        if ((def['antonyms'] as List)
                                            .isNotEmpty)
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 20),
                                            child: Text(
                                              "antonyms: ${(def['antonyms'] as List).join(', ')}",
                                              style: TextStyle(
                                                color: Color.fromRGBO(
                                                    25, 66, 172, 0.914),
                                                fontSize: 17,
                                              ),
                                            ),
                                          ),
                                      ],
                                    );
                                  }).toList(),
                                  if ((meaning['synonyms'] as List).isNotEmpty)
                                    Padding(
                                      padding: const EdgeInsets.only(left: 20),
                                      child: Text(
                                        "synonyms: ${(meaning['synonyms'] as List).join(', ')}",
                                        style: TextStyle(
                                          color: Color.fromRGBO(
                                              25, 66, 172, 0.914),
                                          fontSize: 17,
                                        ),
                                      ),
                                    ),
                                  if ((meaning['antonyms'] as List).isNotEmpty)
                                    Padding(
                                      padding: const EdgeInsets.only(left: 20),
                                      child: Text(
                                        "antonyms: ${(meaning['antonyms'] as List).join(', ')}",
                                        style: TextStyle(
                                          color: Color.fromRGBO(
                                              25, 66, 172, 0.914),
                                          fontSize: 17,
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            );
                          },
                        )
                      : Text("Loading..."),
                ),
              ],
            ),
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
