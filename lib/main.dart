import 'main_index.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setup();
  getIt<ThemeChange>().setIsDark = await App.getIsDark();
  runApp(ChangeNotifierProvider(
    create: (_) => getIt<ThemeChange>(),
    child: Consumer<ThemeChange>(
      builder: (_, __, ___) {
        return MyApp();
      },
    ),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Global.APP_NAME,
      debugShowCheckedModeBanner: false,
      home: BaseLayoutView(),
      theme: ThemeData(primarySwatch: BrandColors.brandColor),
    );
  }
}
