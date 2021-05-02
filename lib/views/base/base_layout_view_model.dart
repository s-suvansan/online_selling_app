import 'package:flutter/cupertino.dart';

import '../../main_index.dart';

class BaseLayoutViewModel extends BaseViewModel {
  // variables
  int _currentIndex = 0;
  int _lastIndex = 0;
  bool _isHideBottomBar = false;

  List<BottomTaps> _bottomTaps = [
    BottomTaps(index: 0, icon: HOME, filledIcon: HOME_FILL, title: "Home"),
    BottomTaps(index: 1, icon: LIKE, filledIcon: LIKE_FILL, title: "Favourite"),
    BottomTaps(index: 2, icon: GEAR, filledIcon: GEAR_FILL, title: "Settings"),
  ];

  //getter
  int get currentIndex => _currentIndex;
  int get lastIndex => _lastIndex;
  bool get isHideBottomBar => _isHideBottomBar;
  List<BottomTaps> get bottomTaps => _bottomTaps;
  List<String> get bottomTapTexts => [
        getIt<LanguageChange>().lang.home,
        getIt<LanguageChange>().lang.favourites,
        getIt<LanguageChange>().lang.settings,
      ];

  // init function
  onInit() {
    // _hide = AnimationController(duration: kThemeAnimationDuration, vsync: null);
  }

  void chageTaps(int index, {BuildContext context}) {
    if (index != 2) {
      if (_currentIndex != index) {
        _currentIndex = index;
        _lastIndex = index;

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
    showCupertinoDialog(
      context: context,
      builder: (ctx) => SettingView(),
    ).then((value) {
      _currentIndex = _lastIndex;
      notifyListeners();
    });
  }

  bool handleScrollNotification(ScrollNotification notification) {
    if (notification.depth == 0) {
      if (notification is UserScrollNotification) {
        final UserScrollNotification userScroll = notification;
        switch (userScroll.direction) {
          case ScrollDirection.forward:
            print("unhide");
            _isHideBottomBar = false;
            notifyListeners();
            break;
          case ScrollDirection.reverse:
            print("hide");
            _isHideBottomBar = true;
            notifyListeners();
            break;
          case ScrollDirection.idle:
            print("stable");
            _isHideBottomBar = false;
            notifyListeners();
            break;
        }
      }
    }
    return false;
  }
}

class BottomTaps {
  final int index;
  final String icon;
  final String filledIcon;
  final String title;

  BottomTaps({this.index, this.filledIcon, this.icon, this.title});
}
