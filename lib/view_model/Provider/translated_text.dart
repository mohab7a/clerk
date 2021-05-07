import 'package:flutter/material.dart';

class TranslatedText extends ChangeNotifier {
  String _translatedText;

  void setText(String translatedTextFromApi) {
    _translatedText = translatedTextFromApi;
    notifyListeners();
  }

  String getTranslatedText() {
    return _translatedText;
  }
}
