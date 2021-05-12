import '../../main_index.dart';

class SettingViewModel extends BaseViewModel {
  //variables
  bool _isLoading = false;

  //getter
  String get setting => getIt<LanguageChange>().lang.settings;
  bool get isLoading => _isLoading;
  // on theme change
  void onThemeChange() {
    getIt<ThemeChange>().changedark();
  }

  // on language change
  void onLanguageChange(BuildContext context, {@required String languageCode}) {
    App.checkConnection(context).then((value) {
      _isLoading = true;
      notifyListeners();

      if (value && getIt<LanguageChange>().languageCode != languageCode) {
        FireStoreService.getLanguage(docName: languageCode == Lang.English.code ? Global.ENGLISH : Global.TAMIL).then((lang) {
          if (lang != null) {
            // print(value.toJson());
            Future.delayed(Duration(milliseconds: 500)).then((_) {
              getIt<LanguageChange>().setLanguage(lang);
              App.setLang(value: json.encode(lang));
              getIt<LanguageChange>().setLanguageCode = languageCode;
              App.setLangCode(value: languageCode);
              _isLoading = false;
              notifyListeners();
            });
          } else {
            _isLoading = false;
            notifyListeners();
          }
        });
      } else {
        _isLoading = false;
        notifyListeners();
      }
    });
  }
}
