import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:training/util/data_service.dart';
import 'package:training/util/speech.dart';

class ConversationScreen extends StatelessWidget {
  const ConversationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Conversation'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              FutureBuilder<List<Map<String, dynamic>>>(
                future: getConversationPhrase(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<Map<String, dynamic>> conversationPhrases =
                        snapshot.data!;
                    return ExpansionTile(
                      title: const Text("Conversation Phrase"),
                      children: conversationPhrases.map((item) {
                        return Column(
                          children: [
                            ListTile(
                              title: Row(
                                children: [
                                  Expanded(child: Text(item['english'])),
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
                                      Expanded(child: Text(item['vietnamese'])),
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
                  } else if (snapshot.hasError) {
                    return const Text('Error loading vocabulary');
                  } else {
                    return const CircularProgressIndicator();
                  }
                },
              ),
              FutureBuilder<List<Map<String, dynamic>>>(
                future: getConversationPhrase(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<Map<String, dynamic>> conversationPhrases =
                        snapshot.data!;
                    return ExpansionTile(
                      title: const Text("Conversation Question"),
                      children: conversationPhrases.map((item) {
                        return Column(
                          children: [
                            ListTile(
                              title: Row(
                                children: [
                                  Expanded(child: Text(item['english'])),
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
                                  const Gap(4),
                                  Row(
                                    children: [
                                      const Icon(Icons.arrow_right),
                                      Expanded(child: Text(item['vietnamese'])),
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
                  } else if (snapshot.hasError) {
                    return const Text('Error loading vocabulary');
                  } else {
                    return const CircularProgressIndicator();
                  }
                },
              ),
            ],
          ),
        ));
  }
}
