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
          title: Text('Conversation'),
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
                      title: Text("Conversation Phrase"),
                      children: conversationPhrases.map((item) {
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
                                crossAxisAlignment: CrossAxisAlignment.start,
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
                  } else if (snapshot.hasError) {
                    return Text('Error loading vocabulary');
                  } else {
                    return CircularProgressIndicator();
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
                      title: Text("Conversation Question"),
                      children: conversationPhrases.map((item) {
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Gap(4),
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
                  } else if (snapshot.hasError) {
                    return Text('Error loading vocabulary');
                  } else {
                    return CircularProgressIndicator();
                  }
                },
              ),
            ],
          ),
        ));
  }
}
