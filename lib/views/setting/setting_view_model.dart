import '../../main_index.dart';

class SettingViewModel extends BaseViewModel {
  onClick() {
    getIt<ThemeChange>().changedark();
    // notifyListeners();
  }

  String get setting => getIt<LanguageChange>().lang.settings;

  onLangClick({bool isEn = true}) {
    FireStoreService.getLanguage(docName: isEn ? Global.ENGLISH : Global.TAMIL).then((value) {
      if (value != null) {
        getIt<LanguageChange>().setLanguage(value);
        getIt<LanguageChange>().setLanguageCode = isEn ? Lang.English.code : Lang.Tamil.code;
      }
    });
  }
}
