import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:training/util/data_service.dart';
import 'package:training/util/speech.dart';

class EssentialWordScreen extends StatelessWidget {
  const EssentialWordScreen({super.key});

  Color getRandomColor() {
    Random random = Random();
    final baseColor = Color.fromARGB(
      255,
      random.nextInt(256),
      random.nextInt(256),
      random.nextInt(256),
    );
    final color = Color.fromARGB(
      255,
      (baseColor.red * 0.8).toInt(),
      (baseColor.green * 0.8).toInt(),
      (baseColor.blue * 0.8).toInt(),
    );
    return color;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Essential Word'),
          centerTitle: true,
        ),
        body: FutureBuilder<Map<String, List<Map<String, dynamic>>>>(
          future: loadVocabulary(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return FutureBuilder<Map<String, List<Map<String, dynamic>>>>(
                future: loadVocabulary(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    Map<String, List<Map<String, dynamic>>> vocabulary =
                        snapshot.data!;
                    return ListView.builder(
                      itemCount: vocabulary.length,
                      itemBuilder: (context, index) {
                        final topic = vocabulary.keys.elementAt(index);
                        final items = vocabulary[topic]!;

                        return ExpansionTile(
                          title: Text(topic),
                          children: items.map((item) {
                            return Column(
                              children: [
                                ListTile(
                                  title: Row(
                                    children: [
                                      Text(item['english']),
                                      GestureDetector(
                                        onTap: () {
                                          TextToSpeechService()
                                              .playTts('en', item['english']);
                                        },
                                        child: Icon(Icons.volume_up),
                                      )
                                    ],
                                  ),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Gap(2),
                                      Text(item['phonetic']),
                                      Gap(2),
                                      Row(
                                        children: [
                                          Icon(Icons.arrow_right),
                                          Text(item['vietnamese']),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Divider(),
                              ],
                            );
                          }).toList(),
                        );
                      },
                    );
                  } else if (snapshot.hasError) {
                    return Text('Error loading vocabulary');
                  } else {
                    return CircularProgressIndicator();
                  }
                },
              );
            } else {
              return CircularProgressIndicator();
            }
          },
        ));
  }
}
