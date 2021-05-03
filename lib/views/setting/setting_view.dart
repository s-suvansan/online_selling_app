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
                        Container(
                          child: App.svgImage(
                            svg: getIt<ThemeChange>().isDark ? OFF : ON,
                          ),
                        ),
                        RaisedButton(
                          child: BrandTexts.header(text: "ok"),
                          onPressed: () => model.onClick(),
                        ),
                        Row(
                          children: [
                            RaisedButton(
                              child: BrandTexts.header(text: "en"),
                              onPressed: () => model.onLangClick(),
                            ),
                            RaisedButton(
                              child: BrandTexts.header(text: "ta"),
                              onPressed: () => model.onLangClick(isEn: false),
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
