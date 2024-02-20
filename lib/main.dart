import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:training/bloc_provider_scope.dart';
import 'package:training/core/common/theme/theme_config.dart';
import 'package:training/core/router/route_configurations.dart';
import 'package:training/firebase_options.dart';
import 'package:training/modules/setting/bloc/theme/theme_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseAuth.instance.authStateChanges().listen((User? user) {
    routerConfig.refresh();
  });
  runApp(
    const BlocProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        return MaterialApp.router(
          theme: ThemeData(
            colorScheme: ThemeDataStyle.lightColorScheme,
          ),
          darkTheme: ThemeData(
            brightness: Brightness.dark,
            colorScheme: ThemeDataStyle.darkColorScheme,
          ),
          themeMode: state.themeMode,
          debugShowCheckedModeBanner: false,
          routerConfig: routerConfig,
        );
      },
    );
  }
}
