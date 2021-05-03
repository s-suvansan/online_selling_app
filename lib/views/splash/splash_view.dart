import '../../main_index.dart';

class SplashView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SplashViewModel>.nonReactive(
      builder: (context, model, _) => Container(
        color: BrandColors.light,
        child: _Body(),
      ),
      onModelReady: (model) => model.onInit(context),
      viewModelBuilder: () => SplashViewModel(),
    );
  }
}

// body
class _Body extends ViewModelWidget<SplashViewModel> {
  @override
  Widget build(BuildContext context, SplashViewModel model) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        !model.isNoInternet
            ? Image.asset(
                APP_LOGO,
                height: 150,
                width: 150,
              )
            : _NoInternet(),
      ],
    );
  }
}

//no internet widget
class _NoInternet extends ViewModelWidget<SplashViewModel> {
  const _NoInternet({Key key}) : super(key: key, reactive: false);

  @override
  Widget build(BuildContext context, SplashViewModel model) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          NO_NET,
          height: 200.0,
          width: 200.0,
        ),
        BrandTexts.titleBold(text: "No Internet Connection.", color: BrandColors.shadowDark),
        SizedBox(height: 20.0),
        OutlineButton(
          onPressed: () => model.checkConnection(context),
          color: BrandColors.brandColorDark,
          hoverColor: BrandColors.brandColorLight,
          borderSide: BorderSide(color: BrandColors.brandColorDark, style: BorderStyle.solid, width: 2),
          child: BrandTexts.titleBold(text: "Retry"),
        )
      ],
    );
  }
}
