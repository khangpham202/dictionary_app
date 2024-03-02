import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/locales.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:training/bloc_provider_scope.dart';
import 'package:training/core/common/theme/theme_config.dart';
import 'package:training/core/enum/locales.dart';
import 'package:training/core/router/route_configurations.dart';
import 'package:training/firebase_options.dart';
import 'modules/setting/bloc/theme/theme_bloc.dart';
part 'initializer.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _Initializer.start();

  runApp(
    EasyLocalization(
      supportedLocales: [AppLocales.en.locale, AppLocales.vi.locale],
      path: AppLocales.path,
      fallbackLocale: AppLocales.en.locale,
      child: const BlocProviderScope(
        child: MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      // theme
      theme: ThemeData(
        colorScheme: ThemeDataStyle.lightColorScheme,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        colorScheme: ThemeDataStyle.darkColorScheme,
      ),
      themeMode: context.watch<ThemeBloc>().state.themeMode,
      debugShowCheckedModeBanner: false,

      // localization
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,

      // router
      routerConfig: routerConfig,
    );
  }
}
