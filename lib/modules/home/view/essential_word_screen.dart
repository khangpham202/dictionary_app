import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:training/util/data_service.dart';
import 'package:training/util/speech.dart';

class EssentialWordScreen extends StatelessWidget {
  const EssentialWordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Essential Word'),
          centerTitle: true,
        ),
        body: FutureBuilder<Map<String, List<Map<String, dynamic>>>>(
          future: getEssentialWord(),
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
                    title: Text("Subject: $topic"),
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
                                  child: const Icon(Icons.volume_up),
                                )
                              ],
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Gap(2),
                                Text(item['phonetic']),
                                const Gap(2),
                                Row(
                                  children: [
                                    const Icon(Icons.arrow_right),
                                    Text(item['vietnamese']),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const Divider(),
                        ],
                      );
                    }).toList(),
                  );
                },
              );
            } else if (snapshot.hasError) {
              return const Text('Error loading vocabulary');
            } else {
              return const CircularProgressIndicator();
            }
          },
        ));
  }
}
