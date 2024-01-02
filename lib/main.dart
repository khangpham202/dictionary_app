import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:training/modules/home/view/essential_word_screen.dart';
// import 'package:training/components/tarbar_view.dart';
import 'package:training/modules/intro/note.dart';
import 'package:training/modules/intro/welcome_screen.dart';
import 'package:training/modules/translatePage/bloc/language/language_bloc.dart';
import 'package:training/components/navigation.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      // home: BlocProvider(
      //   create: (context) => LanguageBloc(),
      //   child: NavigationBottomBar(
      //     indexScreen: 0,
      //   ),
      // ),
      home: WelcomeScreen(),

      // home: WelcomeScreen(),
    );
  }
}
