import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:training/components/toast.dart';
import 'package:training/core/common/model/word.dart';
import 'package:training/util/api_service.dart';
import 'package:training/util/data_service.dart';
import 'package:training/util/speech.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class WordMeaningWidget extends StatefulWidget {
  final String word, dictionaryType;
  const WordMeaningWidget(
      {super.key, required this.word, required this.dictionaryType});

  @override
  State<WordMeaningWidget> createState() => _WordMeaningWidgetState();
}

class _WordMeaningWidgetState extends State<WordMeaningWidget> {
  bool isFavorite = false;
  String uid = FirebaseAuth.instance.currentUser!.uid;
  late FToast fToast;
  @override
  void initState() {
    super.initState();
    checkIsFavorite();
  }

  Future<void> checkIsFavorite() async {
    DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(
            '${FirebaseAuth.instance.currentUser!.uid}/favorite/${widget.word}')
        .get();

    setState(() {
      isFavorite = snapshot.exists;
    });
  }

  Future<void> toggleFavorite() async {
    if (FirebaseAuth.instance.currentUser == null) {
      Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'This feature requires login',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          ),
        ),
      );
    } else {
      String uid = FirebaseAuth.instance.currentUser!.uid;
      DocumentReference favoriteRef = FirebaseFirestore.instance
          .collection('users')
          .doc('$uid/favorite/${widget.word}');

      if (isFavorite) {
        await favoriteRef.delete();
        fToast.showToast(
          child: const CustomToast(
            msg: 'Removed from favorites',
            icon: Icon(FontAwesomeIcons.check), 
            bgColor: Color.fromARGB(255, 97, 93, 93),
          ),
          toastDuration: const Duration(seconds: 3),
        );
      } else {
        await favoriteRef.set({'word': widget.word});
        fToast.showToast(
          child: const CustomToast(
            msg: 'Added word to favorites',
            icon: Icon(FontAwesomeIcons.check),
            bgColor: Colors.green,
          ),
          toastDuration: const Duration(seconds: 3),
        );
      }

      setState(() {
        isFavorite = !isFavorite;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Word?>(
      future: widget.dictionaryType == "EV"
          ? DatabaseHelper().getEVWordData(widget.word)
          : DatabaseHelper().getVEWordData(widget.word),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SizedBox(
            height: 200,
            width: 200,
            child: Center(child: CircularProgressIndicator()),
          );
        } else if (snapshot.hasError) {
          return const Center(child: Text(''));
        } else {
          Word data = snapshot.data!;

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
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 22,
                          fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: null,
                            child: const Icon(FontAwesomeIcons.filePen),
                          ),
                          const Gap(5),
                          GestureDetector(
                            onTap: toggleFavorite,
                            child: Icon(
                              isFavorite
                                  ? FontAwesomeIcons.solidBookmark
                                  : FontAwesomeIcons.bookmark,
                              color: isFavorite
                                  ? const Color.fromARGB(233, 236, 32, 32)
                                  : null,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                const Gap(10),
                Row(
                  children: [
                    Text(
                      data.pronounce,
                      style: const TextStyle(
                          color: Color.fromARGB(255, 111, 104, 104),
                          fontWeight: FontWeight.w700,
                          fontSize: 20),
                    ),
                    GestureDetector(
                      onTap: () {
                        TextToSpeechService().playTts('en', widget.word);
                      },
                      child: const Icon(
                        Icons.volume_up_outlined,
                        color: Color.fromRGBO(99, 115, 156, 0.914),
                        size: 25,
                      ),
                    ),
                  ],
                ),
                const Gap(10),
                Row(
                  children: [
                    const Icon(
                      Icons.arrow_right_outlined,
                      size: 30,
                    ),
                    SizedBox(
                      width: 300,
                      child: Text(
                        data.description,
                        style: const TextStyle(
                            color: Color.fromARGB(255, 71, 67, 67),
                            fontWeight: FontWeight.w700,
                            fontSize: 20),
                        overflow: TextOverflow.visible,
                      ),
                    ),
                  ],
                )
              ],
            ),
          );
        }
      },
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
  Future<bool> checkInternet() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    return connectivityResult != ConnectivityResult.none;
  }

  Future<void> getWordNet() async {
    final result = await WordDetail().getWordNet(widget.word);
    setState(() {
      meanings = result;
    });
  }

  @override
  void initState() {
    super.initState();
    getWordNet();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: checkInternet(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const SizedBox(
              height: 200,
              width: 200,
              child: Center(child: CircularProgressIndicator()),
            );
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          } else {
            bool isConnected = snapshot.data ?? false;
            if (isConnected) {
              return meanings == null
                  ? const SizedBox(
                      height: 200.0,
                      width: 200.0,
                      child: Center(child: CircularProgressIndicator()),
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
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 22,
                                    fontWeight: FontWeight.w600),
                              ),
                              SizedBox(
                                child: Row(
                                  children: [
                                    GestureDetector(
                                      onTap: null,
                                      child: const Icon(Icons.note_alt_sharp),
                                    ),
                                    GestureDetector(
                                      onTap: null,
                                      child: const Icon(Icons.save),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                          const Gap(10),
                          FutureBuilder(
                              future:
                                  DatabaseHelper().getEVWordData(widget.word),
                              builder: (context, snapshot) {
                                Word? data = snapshot.data;
                                return data != null
                                    ? Row(
                                        children: [
                                          Text(
                                            data.pronounce,
                                            style: const TextStyle(
                                                color: Color.fromARGB(
                                                    255, 111, 104, 104),
                                                fontWeight: FontWeight.w700,
                                                fontSize: 20),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              TextToSpeechService()
                                                  .playTts('en', widget.word);
                                            },
                                            child: const Icon(
                                              Icons.volume_up_outlined,
                                              color: Color.fromRGBO(
                                                  99, 115, 156, 0.914),
                                              size: 25,
                                            ),
                                          ),
                                        ],
                                      )
                                    : const Gap(0);
                              }),
                          const Gap(10),
                          Expanded(
                            child: meanings != null
                                ? ListView.builder(
                                    itemCount: meanings!.length,
                                    itemBuilder: (context, index) {
                                      final meaning = meanings![index];
                                      return ListTile(
                                        title: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              meaning['partOfSpeech']
                                                  .toString()
                                                  .toUpperCase(),
                                              style: const TextStyle(
                                                  color: Color.fromRGBO(
                                                      18, 55, 149, 0.914),
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            const Gap(3),
                                          ],
                                        ),
                                        subtitle: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            ...meaning['definitions']
                                                .map<Widget>((def) {
                                              return Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    children: [
                                                      const Icon(
                                                        Icons.circle,
                                                        size: 10,
                                                      ),
                                                      const Gap(5),
                                                      Container(
                                                        constraints:
                                                            BoxConstraints(
                                                          maxWidth: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width -
                                                              100,
                                                        ),
                                                        child: Column(
                                                          children: [
                                                            Text(
                                                              "${def['definition']}",
                                                              style: const TextStyle(
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          61,
                                                                          61,
                                                                          61),
                                                                  fontSize: 18),
                                                              overflow:
                                                                  TextOverflow
                                                                      .visible,
                                                            ),
                                                            const Gap(3),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  if ((def['synonyms'] as List)
                                                      .isNotEmpty)
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 20),
                                                      child: Text(
                                                        "synonyms: ${(def['synonyms'] as List).join(', ')}",
                                                        style: const TextStyle(
                                                          color: Color.fromRGBO(
                                                              25,
                                                              66,
                                                              172,
                                                              0.914),
                                                          fontSize: 17,
                                                        ),
                                                      ),
                                                    ),
                                                  if ((def['antonyms'] as List)
                                                      .isNotEmpty)
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 20),
                                                      child: Text(
                                                        "antonyms: ${(def['antonyms'] as List).join(', ')}",
                                                        style: const TextStyle(
                                                          color: Color.fromRGBO(
                                                              25,
                                                              66,
                                                              172,
                                                              0.914),
                                                          fontSize: 17,
                                                        ),
                                                      ),
                                                    ),
                                                ],
                                              );
                                            }).toList(),
                                            if ((meaning['synonyms'] as List)
                                                .isNotEmpty)
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 20),
                                                child: Text(
                                                  "synonyms: ${(meaning['synonyms'] as List).join(', ')}",
                                                  style: const TextStyle(
                                                    color: Color.fromRGBO(
                                                        25, 66, 172, 0.914),
                                                    fontSize: 17,
                                                  ),
                                                ),
                                              ),
                                            if ((meaning['antonyms'] as List)
                                                .isNotEmpty)
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 20),
                                                child: Text(
                                                  "antonyms: ${(meaning['antonyms'] as List).join(', ')}",
                                                  style: const TextStyle(
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
                                : const Text("aa"),
                          ),
                        ],
                      ),
                    );
            } else {
              return const Center(child: Text('No internet connection'));
            }
          }
        });
  }
}

class NoteWidget extends StatelessWidget {
  const NoteWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("It's sunny here"),
    );
  }
}
