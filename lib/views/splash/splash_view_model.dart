import 'package:connectivity/connectivity.dart';

import '../../main_index.dart';

class SplashViewModel extends BaseViewModel {
  // variables
  bool _isNoConnection = false;

  //getter
  bool get isNoInternet => _isNoConnection;

  // on init function
  void onInit(BuildContext context) {
    print("check");
    checkConnection(context);
  }

  // check internet available
  void checkConnection(BuildContext context) {
    Connectivity().checkConnectivity().then((result) {
      if (result != ConnectivityResult.none) {
        checkUserLogin(context);
      } else {
        print("no internet connection here");
        _isNoConnection = true;
        notifyListeners();
      }
    });
  }

  // check user login or  not
  void checkUserLogin(BuildContext context) {
    FireAuthService.checkUser().then((value) {
      if (value.isLogin) {
        print("user available");
        Global.userInfo = value.user;
        navigateToBaseLayoutView(context);
      } else {
        FireAuthService.createUser().then((user) {
          Global.userInfo = user;
          navigateToBaseLayoutView(context);
        });
      }
    });
  }

  // navigate to base layout view
  void navigateToBaseLayoutView(BuildContext context) {
    Navigator.popAndPushNamed(context, BaseLayoutView.routeName);
  }
}