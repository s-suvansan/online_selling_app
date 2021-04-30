import '../main_index.dart';

class LanguageChange with ChangeNotifier {
  //variable
  LanguageModel _lang = LanguageModel();

  //getter
  LanguageModel get lang => _lang;

  // setter
  set setLanguage(LanguageModel val) => _lang = val;
}
