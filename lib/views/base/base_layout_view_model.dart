import 'package:flutter/cupertino.dart';

import '../../main_index.dart';

class BaseLayoutViewModel extends BaseViewModel {
  // variables
  PageController _pageController = PageController();
  int _currentIndex = 0;
  int _lastIndex = 0;
  List<BottomTaps> _bottomTaps = [
    BottomTaps(index: 0, icon: HOME, filledIcon: HOME_FILL, title: "Home"),
    BottomTaps(index: 1, icon: LIKE, filledIcon: LIKE_FILL, title: "Favourite"),
    BottomTaps(index: 2, icon: GEAR, filledIcon: GEAR_FILL, title: "Settings"),
  ];

  //getter
  PageController get pageController => _pageController;
  int get currentIndex => _currentIndex;
  List<BottomTaps> get bottomTaps => _bottomTaps;

  // for select taps in bottom bar
  void selectTaps(int index, {BuildContext context}) {
    if (index != 2) {
      if (_currentIndex != index) {
        _currentIndex = index;
        _lastIndex = index;
        _pageController.animateToPage(
          _currentIndex,
          duration: Duration(milliseconds: 200),
          curve: Curves.ease,
        );
        notifyListeners();
      }
    } else {
      _currentIndex = index;
      notifyListeners();
      showSettings(context);
    }
  }

  // show setting bottom sheet
  void showSettings(BuildContext context) {
    // FireAuthService.checkUser().then((value) {
    //   if (value) {
    //     print("user available");
    //   } else {
    //     FireAuthService.createUser();
    //   }
    // });

    showCupertinoDialog(
      context: context,
      builder: (ctx) => SettingView(),
    ).then((value) {
      _currentIndex = _lastIndex;
      notifyListeners();
    });
  }
}

class BottomTaps {
  final int index;
  final String icon;
  final String filledIcon;
  final String title;

  BottomTaps({this.index, this.filledIcon, this.icon, this.title});
}
