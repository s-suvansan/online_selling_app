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
                  SingleChildScrollView(
                    child: Container(
                      width: App.getDeviceWidth(context) - 100.0,
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      decoration: BoxDecoration(
                          color: getIt<ThemeChange>().isDark
                              ? BrandColors.dark3
                              : BrandColors.light,
                          borderRadius: BorderRadius.circular(16.0),
                          boxShadow: [
                            BoxShadow(
                              color: getIt<ThemeChange>().isDark
                                  ? BrandColors.light.withOpacity(0.2)
                                  : BrandColors.dark.withOpacity(0.2),
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
                                  color: getIt<ThemeChange>().isDark
                                      ? BrandColors.light
                                      : BrandColors.dark,
                                ),
                                GestureDetector(
                                  onTap: () => App.popOnce(context),
                                  child: Icon(
                                    Icons.cancel_sharp,
                                    size: 20.0,
                                    color: getIt<ThemeChange>().isDark
                                        ? BrandColors.light
                                        : BrandColors.dark,
                                  ),
                                )
                              ],
                            ),
                          ),
                          _Loader(),
                          SizedBox(height: 16.0),
                          BrandTexts.titleBold(
                            text: "${getIt<LanguageChange>().lang.changeTheme}",
                            fontSize: getIt<LanguageChange>().languageCode ==
                                    Lang.English.code
                                ? 16.0
                                : 14.0,
                            color: getIt<ThemeChange>().isDark
                                ? BrandColors.light
                                : BrandColors.dark,
                          ),
                          SizedBox(height: 16.0),
                          _ThemeBox(),
                          SizedBox(height: 16.0),
                          BrandTexts.titleBold(
                            text: "${getIt<LanguageChange>().lang.selectLang}",
                            maxLines: 2,
                            fontSize: getIt<LanguageChange>().languageCode ==
                                    Lang.English.code
                                ? 16.0
                                : 14.0,
                            color: getIt<ThemeChange>().isDark
                                ? BrandColors.light
                                : BrandColors.dark,
                          ),
                          SizedBox(height: 16.0),
                          _LanguageBox(),
                          SizedBox(height: 16.0),
                          BrandTexts.titleBold(
                            text: "${getIt<LanguageChange>().lang.contactUs}",
                            maxLines: 2,
                            fontSize: getIt<LanguageChange>().languageCode ==
                                    Lang.English.code
                                ? 16.0
                                : 14.0,
                            color: getIt<ThemeChange>().isDark
                                ? BrandColors.light
                                : BrandColors.dark,
                          ),
                          SizedBox(height: 4.0),
                          BrandTexts.caption(
                            text:
                                "${getIt<LanguageChange>().lang.contactUsDesc}",
                            maxLines: 4,
                            textAlign: TextAlign.justify,
                            fontSize: getIt<LanguageChange>().languageCode ==
                                    Lang.English.code
                                ? 12.0
                                : 10.0,
                            color: getIt<ThemeChange>().isDark
                                ? BrandColors.light
                                : BrandColors.dark,
                          ),
                          SizedBox(height: 16.0),
                          Wrap(
                            spacing: 8.0,
                            runSpacing: 8.0,
                            children: [
                              _ContactUs(
                                svg: CALL,
                                onTap: () => model.showPhoneNumbers(
                                  context,
                                  phoneNumber: Global.phoneNumberModel.normal,
                                ),
                              ),
                              _ContactUs(
                                svg: WHATSAPP,
                                isWhatsapp: true,
                                onTap: () => model.showPhoneNumbers(
                                  context,
                                  isCall: false,
                                  phoneNumber: Global.phoneNumberModel.whatsApp,
                                ),
                              )
                            ],
                          ),
                          SizedBox(height: 16.0),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
        viewModelBuilder: () => SettingViewModel());
  }
}

class _Loader extends ViewModelWidget<SettingViewModel> {
  const _Loader() : super(reactive: true);
  @override
  Widget build(BuildContext context, SettingViewModel model) {
    return Consumer<ThemeChange>(builder: (context, value, child) {
      return model.isLoading
          ? SizedBox(
              height: 1.5,
              child: LinearProgressIndicator(
                backgroundColor: getIt<ThemeChange>().isDark
                    ? BrandColors.light
                    : BrandColors.dark,
                valueColor:
                    AlwaysStoppedAnimation<Color>(BrandColors.brandColorDark),
              ),
            )
          : Divider(
              height: 0.0,
              thickness: 1.5,
              color: getIt<ThemeChange>().isDark
                  ? BrandColors.light
                  : BrandColors.dark,
            );
    });
  }
}

class _ThemeBox extends ViewModelWidget<SettingViewModel> {
  const _ThemeBox() : super(reactive: false);
  @override
  Widget build(BuildContext context, SettingViewModel model) {
    return Consumer<ThemeChange>(builder: (context, value, child) {
      return Container(
        height: 120.0,
        decoration: BoxDecoration(
          border: Border.all(color: BrandColors.shadowDark),
          borderRadius: BorderRadius.circular(16.0),
          color: getIt<ThemeChange>().isDark
              ? BrandColors.dark1
              : BrandColors.candleLight.withOpacity(0.2),
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
                      getIt<ThemeChange>().isDark
                          ? BrandColors.glass
                          : BrandColors.brandColorDark.withOpacity(0.8),
                      getIt<ThemeChange>().isDark
                          ? BrandColors.glass
                          : BrandColors.brandColor.withOpacity(0.6),
                      getIt<ThemeChange>().isDark
                          ? BrandColors.glass
                          : BrandColors.candleLight.withOpacity(0.4),
                      getIt<ThemeChange>().isDark
                          ? BrandColors.glass
                          : BrandColors.brandColorLight.withOpacity(0.1),
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
                  onTap: () => model.onThemeChange(),
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

class _LanguageBox extends ViewModelWidget<SettingViewModel> {
  const _LanguageBox() : super(reactive: false);
  @override
  Widget build(BuildContext context, SettingViewModel model) {
    return Consumer<ThemeChange>(builder: (context, value, child) {
      return Container(
        child: Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: [
            _chip(
              lang: "???????????????",
              onTap: () => model.onLanguageChange(context,
                  languageCode: Lang.Tamil.code),
              languageCode: Lang.Tamil.code,
            ),
            _chip(
              lang: "??????????????? ???????????????",
              onTap: () => model.onLanguageChange(context,
                  languageCode: Lang.OurTamil.code),
              languageCode: Lang.OurTamil.code,
            ),
            _chip(
              onTap: () => model.onLanguageChange(context,
                  languageCode: Lang.English.code),
              languageCode: Lang.English.code,
            ),
          ],
        ),
      );
    });
  }

  Widget _chip(
      {String lang = "English", String languageCode = "", Function onTap}) {
    return Consumer<LanguageChange>(builder: (context, value, child) {
      return GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            border: Border.all(
              width: 2.0,
              color: getIt<LanguageChange>().languageCode == languageCode
                  ? BrandColors.brandColor
                  : BrandColors.shadow,
            ),
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: BrandTexts.titleBold(
            text: lang,
            color: getIt<ThemeChange>().isDark
                ? BrandColors.light
                : BrandColors.shadowDark,
          ),
        ),
      );
    });
  }
}

class _ContactUs extends ViewModelWidget<SettingViewModel> {
  final Function onTap;
  final String svg;
  final bool isWhatsapp;
  const _ContactUs({this.svg = "", this.onTap, this.isWhatsapp = false})
      : super(reactive: false);
  @override
  Widget build(BuildContext context, SettingViewModel model) {
    return Consumer<LanguageChange>(builder: (context, value, child) {
      return GestureDetector(
        onTap: onTap,
        child: Container(
          height: 40.0,
          width: 40.0,
          // padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color:
                isWhatsapp ? BrandColors.whatsappColor : BrandColors.callColor,
            // borderRadius: BorderRadius.circular(16.0),
          ),
          child: App.svgImage(
              svg: svg,
              height: isWhatsapp ? 18.0 : 16.0,
              color: BrandColors.light),
        ),
      );
    });
  }
}
