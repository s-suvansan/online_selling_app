import 'package:flutter/cupertino.dart';

import '../../main_index.dart';

class BaseLayoutViewModel extends BaseViewModel {
  // variables
  int _currentIndex = 0;
  int _lastIndex = 0;
  bool _isHideBottomBar = false;
  AnimationController _hide;

  List<BottomTaps> _bottomTaps = [
    BottomTaps(index: 0, icon: HOME, filledIcon: HOME_FILL, title: "Home"),
    BottomTaps(index: 1, icon: LIKE, filledIcon: LIKE_FILL, title: "Favourite"),
    BottomTaps(index: 2, icon: GEAR, filledIcon: GEAR_FILL, title: "Settings"),
  ];

  //getter
  AnimationController get hide => _hide;
  int get currentIndex => _currentIndex;
  int get lastIndex => _lastIndex;
  bool get isHideBottomBar => _isHideBottomBar;
  List<BottomTaps> get bottomTaps => _bottomTaps;
  List<String> get bottomTapTexts => [
        getIt<LanguageChange>().lang.home,
        getIt<LanguageChange>().lang.favorites,
        getIt<LanguageChange>().lang.settings,
      ];

  // setter
  set setContoller(AnimationController val) => _hide = val;

  // init function
  // onInit() {
  // _hide = AnimationController(duration: kThemeAnimationDuration, vsync: null);
  // }

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
            // print("unhide");
            _hide.forward();
            break;
          case ScrollDirection.reverse:
            // print("hide");
            _hide.reverse();
            break;
          case ScrollDirection.idle:
            // print("stable");
            if (userScroll.metrics.atEdge &&
                userScroll.metrics.pixels == userScroll.metrics.maxScrollExtent &&
                getIt<ScrollChange>().isNotify) {
              print("at the bottom");
              getIt<ScrollChange>().increseCount();
            }
            _hide.forward();
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
