import '../main_index.dart';

GetIt getIt = GetIt.instance;

void setup() {
  getIt.registerSingleton<ThemeChange>(ThemeChange());
}
