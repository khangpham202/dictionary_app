class Translation {
  final String originalSentence;
  final Future<String> translatedSentence;
  final String sourceCountryLogoSrc;
  final String targetCountryLogoSrc;
  final String translateFlow;
  Translation(this.originalSentence, this.translatedSentence,
      this.sourceCountryLogoSrc, this.targetCountryLogoSrc, this.translateFlow);
}
