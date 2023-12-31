import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:training/modules/translatePage/bloc/language/language_bloc.dart';

class BlocProviderScope extends StatelessWidget {
  final Widget child;
  const BlocProviderScope({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider<LanguageBloc>(create: (context) => LanguageBloc()),
    ], child: child);
  }
}
