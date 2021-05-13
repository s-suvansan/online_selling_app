import 'package:flutter/cupertino.dart';

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

  // show phone number list
  void showPhoneNumbers(BuildContext context, {@required List<String> phoneNumber, bool isCall = true}) {
    if (phoneNumber != null && phoneNumber.isNotEmpty) {
      if (phoneNumber.length > 1) {
        showCupertinoDialog(
          context: context,
          builder: (ctx) => PhoneNumberList(
            phnNumbers: phoneNumber,
            isCall: isCall,
          ),
        ).then((val) {
          if (val != null) {
            App.callAndSmsLauncher(context, phoneNumber: val, isCall: isCall);
          }
        });
      } else {
        App.callAndSmsLauncher(context, phoneNumber: phoneNumber[0], isCall: isCall);
      }
    }
  }

  // on language change
  void onLanguageChange(BuildContext context, {@required String languageCode}) {
    App.checkConnection(context).then((value) {
      _isLoading = true;
      notifyListeners();

      if (value && getIt<LanguageChange>().languageCode != languageCode) {
        FireStoreService.getLanguage(
          docName: languageCode == Lang.English.code
              ? Global.ENGLISH
              : languageCode == Lang.Tamil.code
                  ? Global.TAMIL
                  : Global.OUR_TAMIL,
        ).then((lang) {
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
