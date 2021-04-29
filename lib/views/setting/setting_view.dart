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
                    height: 150.0,
                    width: App.getDeviceWidth(context) - 150.0,
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
                    child: Center(
                      child: Column(
                        children: [
                          BrandTexts.header(text: "Settings"),
                          RaisedButton(
                            child: BrandTexts.header(text: "ok"),
                            onPressed: () => model.onClick(),
                          )
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
