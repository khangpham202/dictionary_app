import 'package:flutter/material.dart';
import 'package:training/modules/translatePage/view/translate_screen.dart';
import 'package:training/widget/navigation.dart';

import 'modules/intro/welcome_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: NavigationBottomBar(
        indexScreen: 1,
      ),
    );
  }
}
