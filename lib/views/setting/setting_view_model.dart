import '../../main_index.dart';

class SettingViewModel extends BaseViewModel {
  onClick() {
    getIt<ThemeChange>().changedark();
    // notifyListeners();
  }
}
