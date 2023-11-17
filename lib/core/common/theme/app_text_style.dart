import 'package:flutter/material.dart';

class AppStyles {
  AppStyles._();

  //Headline
  static TextStyle headline1(BuildContext context) =>
      Theme.of(context).textTheme.headlineLarge!;

  static TextStyle headline2(BuildContext context) =>
      Theme.of(context).textTheme.headlineMedium!;

  static TextStyle headline4(BuildContext context) =>
      Theme.of(context).textTheme.headlineSmall!;

  static TextStyle headline5(BuildContext context) =>
      Theme.of(context).textTheme.headlineSmall!;

  //Body
  static TextStyle bodyTextMedium(BuildContext context) =>
      Theme.of(context).textTheme.bodyMedium!;

  static TextStyle bodyTextSmall(BuildContext context) =>
      Theme.of(context).textTheme.bodySmall!;

//Button
  static TextStyle buttonTextSmall(BuildContext context) =>
      Theme.of(context).textTheme.bodySmall!;
}
