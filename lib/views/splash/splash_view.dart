import '../../main_index.dart';

class SplashView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SplashViewModel>.nonReactive(
      builder: (context, model, _) => Container(
        color: BrandColors.light,
        child: Image.asset(
          APP_LOGO,
          height: 100,
          width: 100,
        ),
      ),
      onModelReady: (model) => model.onInit(context),
      viewModelBuilder: () => SplashViewModel(),
    );
  }
}
