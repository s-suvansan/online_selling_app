import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:stacked_hooks/stacked_hooks.dart';

import '../../main_index.dart';

class BaseLayoutView extends StatelessWidget {
  static const routeName = "baseLayoutView";
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<BaseLayoutViewModel>.nonReactive(
        builder: (context, model, child) => SafeArea(
              child: Scaffold(
                backgroundColor: getIt<ThemeChange>().isDark ? BrandColors.dark2 : BrandColors.light,
                resizeToAvoidBottomInset: false,
                appBar: _AppBar(),
                body: _BodyPart(),
                // bottomNavigationBar: _BottomBar(),
                floatingActionButton: _BottomBar(),
                floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
              ),
            ),
        onModelReady: (model) => model.onInit(),
        viewModelBuilder: () => BaseLayoutViewModel());
  }
}

//app bar
class _AppBar extends ViewModelWidget<BaseLayoutViewModel> implements PreferredSizeWidget {
  _AppBar() : super(reactive: false);

  @override
  Widget build(BuildContext context, BaseLayoutViewModel model) {
    return Consumer<ThemeChange>(builder: (_, __, ___) {
      return AppBar(
        centerTitle: true,
        backgroundColor: getIt<ThemeChange>().isDark ? BrandColors.dark2 : BrandColors.light,
        elevation: 0.0,
        title: ShaderMask(
          blendMode: BlendMode.srcIn,
          shaderCallback: (Rect bounds) => LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            tileMode: TileMode.repeated,
            colors: [BrandColors.brandColorDark, getIt<ThemeChange>().isDark ? BrandColors.light : BrandColors.dark],
          ).createShader(bounds),
          child: BrandTexts.header(
            text: Global.APP_NAME,
            fontSize: 24.0,
            fontWeight: BrandTexts.black,
          ),
        ),
      );
    });
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

// body part
class _BodyPart extends ViewModelWidget<BaseLayoutViewModel> {
  _BodyPart({Key key}) : super(key: key, reactive: false);
  @override
  Widget build(BuildContext context, BaseLayoutViewModel model) {
    return Consumer<ThemeChange>(builder: (context, value, child) {
      return Container(
        decoration: BoxDecoration(
          color: getIt<ThemeChange>().isDark ? BrandColors.dark4 : BrandColors.shadowLight.withOpacity(0.9),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24.0),
            topRight: Radius.circular(24.0),
          ),
          image: DecorationImage(
            image: AssetImage(getIt<ThemeChange>().isDark ? DARK_BG : LIGHT_BG),
            fit: BoxFit.cover,
          ),
        ),
        child: _PageViewPart(),
      );
    });
  }
}

//pages view part
class _PageViewPart extends ViewModelWidget<BaseLayoutViewModel> {
  const _PageViewPart({Key key}) : super(key: key, reactive: false);

  @override
  Widget build(BuildContext context, BaseLayoutViewModel model) {
    return NotificationListener<ScrollNotification>(
      onNotification: model.handleScrollNotification,
      child: Stack(
        fit: StackFit.expand,
        children: [
          _ShowHidePart(
            pageIndex: 1,
            page: BookmarkView(),
          ),
          _ShowHidePart(
            pageIndex: 0,
            page: HomeView(),
          ),
        ],
      ),
    );
  }
}

class _ShowHidePart extends ViewModelWidget<BaseLayoutViewModel> {
  final int pageIndex;
  final Widget page;
  const _ShowHidePart({Key key, this.pageIndex, this.page}) : super(key: key, reactive: true);
  @override
  Widget build(BuildContext context, BaseLayoutViewModel model) {
    return AnimatedOpacity(
      opacity: model.lastIndex == pageIndex ? 1.0 : 0.0,
      duration: Duration(milliseconds: 300),
      child: Offstage(
        offstage: model.lastIndex != pageIndex,
        child: page,
      ),
    );
  }
}

// bottom navigation bar
class _BottomBar extends HookViewModelWidget<BaseLayoutViewModel> {
  const _BottomBar({Key key}) : super(key: key, reactive: true);
  @override
  Widget buildViewModelWidget(BuildContext context, BaseLayoutViewModel model) {
    var _hide = useAnimationController(duration: Duration(milliseconds: 300), initialValue: 1);
    model.setContoller = _hide;
    return Consumer<LanguageChange>(builder: (context, value, child) {
      return SizeTransition(
        sizeFactor: model.hide,
        axisAlignment: -1.0,
        child: BottomNavigationBar(
          currentIndex: model.currentIndex,
          onTap: (int index) => model.chageTaps(index, context: context),
          backgroundColor: getIt<ThemeChange>().isDark ? BrandColors.dark2 : BrandColors.light,
          selectedFontSize: 12.0,
          unselectedFontSize: 12.0,
          selectedItemColor: BrandColors.brandColorDark,
          elevation: 10.0,
          unselectedItemColor: getIt<ThemeChange>().isDark ? BrandColors.light : BrandColors.shadow,
          unselectedLabelStyle: TextStyle(color: getIt<ThemeChange>().isDark ? BrandColors.light : BrandColors.shadow),
          items: model.bottomTaps.map((taps) {
            return BottomNavigationBarItem(
              icon: App.svgImage(
                  svg: taps.index == model.currentIndex ? taps.filledIcon : taps.icon,
                  color: taps.index == model.currentIndex
                      ? BrandColors.brandColorDark
                      : getIt<ThemeChange>().isDark
                          ? BrandColors.light
                          : BrandColors.shadow,
                  // width: 24.0,
                  height: 24.0),
              backgroundColor: BrandColors.brandColor,
              label: model.bottomTapTexts[taps.index],
            );
          }).toList(),
        ),
      );
    });
  }
}
