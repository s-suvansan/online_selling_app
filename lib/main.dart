import 'main_index.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  Firebase.initializeApp();
  setup();
  getIt<ThemeChange>().setIsDark = await App.getIsDark();
  getIt<LanguageChange>().setLanguageCode = await App.getLangCode();
  getIt<LanguageChange>().setLanguageInMain(await App.getLang());
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => getIt<ThemeChange>(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => getIt<LanguageChange>(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => getIt<ScrollChange>(),
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
      routes: {
        BaseLayoutView.routeName: (context) => BaseLayoutView(),
        ChatView.routeName: (context) => ChatView(),
      },
      home: SplashView(),
      theme: ThemeData(primarySwatch: BrandColors.brandColor),
    );
  }
}
