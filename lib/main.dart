import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:training/components/tarbar_view.dart';
import 'package:training/modules/intro/note.dart';
import 'package:training/modules/translatePage/bloc/language/language_bloc.dart';
import 'package:training/components/navigation.dart';

void mainExampleApp() {
  WidgetsFlutterBinding.ensureInitialized();
  // debugAutoStartRouteName = testOpenRoute;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // home: BlocProvider(
      //   create: (context) => LanguageBloc(),
      //   child: NavigationBottomBar(
      //     indexScreen: 0,
      //   ),
      // ),
      // home: WordDetailScreen(
      //   word: '',
      // ),
      // home: BlocProvider(
      //   create: (context) => LanguageBloc(),
      //   child: DropdownMenuApp(),
      // ),
      home: DropdownMenuApp(),
      // home: Scaffold(body: WordNetWidget(word: 'orange')),
    );
  }
}
