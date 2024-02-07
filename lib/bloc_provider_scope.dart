import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:training/modules/auth/bloc/authentication_bloc.dart';
import 'package:training/modules/setting/bloc/theme/theme_bloc.dart';
import 'package:training/modules/translatePage/bloc/country/country_bloc.dart';

class BlocProviderScope extends StatelessWidget {
  final Widget child;
  const BlocProviderScope({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider<CountryBloc>(create: (context) => CountryBloc()),
      BlocProvider<ThemeBloc>(create: (context) => ThemeBloc()),
      BlocProvider<AuthenticationBloc>(
          create: (context) => AuthenticationBloc()),
    ], child: child);
  }
}
