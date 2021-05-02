import '../../main_index.dart';

class SplashViewModel extends BaseViewModel {
  // on init function
  void onInit(BuildContext context) {
    print("check");
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

  navigateToBaseLayoutView(BuildContext context) {
    Navigator.popAndPushNamed(context, BaseLayoutView.routeName);
  }
}
