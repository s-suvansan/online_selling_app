import '../../main_index.dart';

class SettingViewModel extends BaseViewModel {
  //getter
  String get setting => getIt<LanguageChange>().lang.settings;

  // on theme change
  void onThemeChange() {
    getIt<ThemeChange>().changedark();
  }

  // on language change
  void onLanguageChange(BuildContext context, {@required String languageCode}) {
    App.checkConnection(context).then((value) {
      if (value && getIt<LanguageChange>().languageCode != languageCode) {
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
    });
  }
}
