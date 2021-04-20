import 'main_index.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Global.APP_NAME,
      debugShowCheckedModeBanner: false,
      home: BaseLayoutView(),
    );
  }
}
