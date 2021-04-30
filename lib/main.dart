import 'main_index.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  setup();
  getIt<ThemeChange>().setIsDark = await App.getIsDark();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => getIt<ThemeChange>(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => getIt<LanguageChange>(),
        ),
      ],
      child: Consumer<ThemeChange>(builder: (_, __, ___) {
        return Consumer<LanguageChange>(builder: (_, __, ___) {
          return MyApp();
        });
      }),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // title: Global.APP_NAME,
      debugShowCheckedModeBanner: false,
      home: BaseLayoutView(),
      theme: ThemeData(primarySwatch: BrandColors.brandColor),
    );
  }
}
