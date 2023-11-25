import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

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
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'idget.word',
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
          Row(
            children: [
              Text(
                '/adsd/',
                style: TextStyle(
                    color: Color.fromARGB(255, 185, 178, 178),
                    fontWeight: FontWeight.w700,
                    fontSize: 18),
              ),
              GestureDetector(
                onTap: null,
                child: Icon(
                  Icons.volume_up_outlined,
                  color: Color.fromRGBO(99, 115, 156, 0.914),
                  size: 25,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class WordNetWidget extends StatelessWidget {
  const WordNetWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("It's rainy here"),
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
