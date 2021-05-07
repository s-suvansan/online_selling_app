import '../../main_index.dart';

class SettingViewModel extends BaseViewModel {
  onClick() {
    getIt<ThemeChange>().changedark();
    // notifyListeners();
  }

  String get setting => getIt<LanguageChange>().lang.settings;

  onLangClick({@required String languageCode}) {
    FireStoreService.getLanguage(docName: languageCode == Lang.English.code ? Global.ENGLISH : Global.TAMIL).then((value) {
      if (value != null) {
        // print(value.toJson());
        getIt<LanguageChange>().setLanguage(value);
        App.setLang(value: json.encode(value));
        getIt<LanguageChange>().setLanguageCode = languageCode;
        App.setLangCode(value: languageCode);
      }
    });
  }
}
