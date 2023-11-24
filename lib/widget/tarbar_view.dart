import 'package:flutter/material.dart';

class WordMeaningWidget extends StatelessWidget {
  const WordMeaningWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("It's cloudy here"),
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
