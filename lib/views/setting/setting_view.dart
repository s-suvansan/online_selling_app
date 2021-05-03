import '../../main_index.dart';

class SettingView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SettingViewModel>.nonReactive(
        builder: (context, model, child) => Container(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: App.getDeviceWidth(context) - 100.0,
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    decoration: BoxDecoration(
                        color: getIt<ThemeChange>().isDark ? BrandColors.dark : BrandColors.light,
                        borderRadius: BorderRadius.circular(16.0),
                        boxShadow: [
                          BoxShadow(
                            color: BrandColors.dark.withOpacity(0.5),
                            spreadRadius: 1.0,
                            offset: Offset.zero,
                            blurRadius: 3.0,
                          ),
                        ]),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              BrandTexts.titleBold(
                                text: model.setting,
                                fontSize: 18.0,
                                color: getIt<ThemeChange>().isDark ? BrandColors.light : BrandColors.dark,
                              ),
                              GestureDetector(
                                onTap: () => App.popOnce(context),
                                child: Icon(
                                  Icons.cancel_sharp,
                                  size: 20.0,
                                  color: BrandColors.shadowDark,
                                ),
                              )
                            ],
                          ),
                        ),
                        Divider(
                          height: 0.0,
                          color: getIt<ThemeChange>().isDark ? BrandColors.light : BrandColors.dark,
                        ),
                        SizedBox(height: 16.0),
                        BrandTexts.titleBold(
                          text: "Change Theme",
                          color: getIt<ThemeChange>().isDark ? BrandColors.light : BrandColors.dark,
                        ),
                        SizedBox(height: 16.0),
                        _ThemeBox(),
                        SizedBox(height: 16.0),
                        Row(
                          children: [
                            RaisedButton(
                              child: BrandTexts.header(text: "en"),
                              onPressed: () => model.onLangClick(languageCode: Lang.English.code),
                            ),
                            RaisedButton(
                              child: BrandTexts.header(text: "ta"),
                              onPressed: () => model.onLangClick(languageCode: Lang.Tamil.code),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
        viewModelBuilder: () => SettingViewModel());
  }
}

class _ThemeBox extends ViewModelWidget<SettingViewModel> {
  @override
  Widget build(BuildContext context, SettingViewModel model) {
    return Consumer<ThemeChange>(builder: (context, value, child) {
      return Container(
        height: 120.0,
        decoration: BoxDecoration(
          border: Border.all(color: BrandColors.shadowDark),
          borderRadius: BorderRadius.circular(16.0),
          color: getIt<ThemeChange>().isDark ? BrandColors.dark1 : BrandColors.candleLight.withOpacity(0.2),
        ),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Positioned(
              bottom: -App.getDeviceHight(context) * 0.1,
              right: 0,
              left: 0,
              // height: 250,
              height: App.getDeviceHight(context) * 0.32,
              // width: 200,
              child: Container(
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(colors: [
                      getIt<ThemeChange>().isDark ? BrandColors.glass : BrandColors.candleLight.withOpacity(0.5),
                      getIt<ThemeChange>().isDark ? BrandColors.glass : BrandColors.candleLight.withOpacity(0.2),
                    ])),
              ),
            ),
            Positioned(
              height: 50.0,
              bottom: 0,
              right: 0,
              left: 0,
              child: Container(
                height: 50.0,
                width: 50.0,
                child: GestureDetector(
                  onTap: () => model.onClick(),
                  child: App.svgImage(
                    svg: getIt<ThemeChange>().isDark ? OFF : ON,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
