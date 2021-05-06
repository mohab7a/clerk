import 'package:flutter/cupertino.dart';

class TranslatedText extends ChangeNotifier {
  String _translatedText;

  void setText(String translatedTextFromApi) {
    _translatedText = translatedTextFromApi;
    notifyListeners();
  }

  String get translatedText => _translatedText;
}
