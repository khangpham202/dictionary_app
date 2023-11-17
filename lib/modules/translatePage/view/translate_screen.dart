import 'package:flutter/material.dart';
import 'package:training/widget/navigation.dart';

class TranslateScreen extends StatelessWidget {
  const TranslateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ElevatedButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const NavigationBottomBar(indexScreen: 0),
              ),
            );
          },
          child: Text('Home')),
    );
  }
}
