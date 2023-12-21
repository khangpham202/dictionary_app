import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:training/util/data_service.dart';
import 'package:training/util/speech.dart';

class TipLeaningScreen extends StatefulWidget {
  const TipLeaningScreen({super.key});

  @override
  State<TipLeaningScreen> createState() => _TipLeaningScreenState();
}

class _TipLeaningScreenState extends State<TipLeaningScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Leanrning Tips and Motivation'),
          centerTitle: true,
        ),
        body: FutureBuilder<List<Map<String, dynamic>>>(
          future: getTipLeanrning(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<Map<String, dynamic>> tips = snapshot.data!;
              return ListView.builder(
                itemCount: tips.length,
                itemBuilder: (context, index) {
                  final item = tips[index];

                  return ListTile(
                    title: Row(
                      children: [
                        Expanded(
                          child: Text(
                            "${index + 1}. ${item['english']}",
                          ),
                        ),
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
                            Expanded(child: Text(item['vietnamese'])),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Text('Error loading vocabulary');
            } else {
              return CircularProgressIndicator();
            }
          },
        ));
  }
}
