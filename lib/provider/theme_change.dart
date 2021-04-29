import '../main_index.dart';

class ThemeChange extends ChangeNotifier {
  //variable
  bool _isDark = false;

  //getter
  bool get isDark => _isDark;

  //change dark
  void changedark() {
    _isDark = !_isDark;
    notifyListeners();
  }
}
