import 'package:flutter/widgets.dart';

class Translation {
  final String originalSentence;
  final String translatedSentence;
  final Image sourceCountryLogoSrc;
  final Image targetCountryLogoSrc;
  final String translateFlow;
  Translation(
    this.originalSentence,
    this.translatedSentence,
    this.sourceCountryLogoSrc,
    this.targetCountryLogoSrc,
    this.translateFlow,
  );
}
