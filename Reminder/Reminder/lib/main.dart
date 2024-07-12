import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:reminder/pages/HomePage.dart';
import 'database/reminder_db.dart';
import 'model/reminder.dart';




void main() async  {
  WidgetsFlutterBinding.ensureInitialized();
  final document = await getApplicationDocumentsDirectory();
  await Hive.initFlutter(document.path);
  Hive.registerAdapter(ReminderAdapter());
  rembox = await Hive.openBox<Reminder>('Reminder');
  runApp(const Main());

}

class Main extends StatelessWidget {
  const Main({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Reminder+',
      debugShowCheckedModeBanner: false,
      theme: FlexThemeData.light(scheme: FlexScheme.sanJuanBlue,  appBarOpacity: 1.0, appBarStyle: FlexAppBarStyle.primary, transparentStatusBar: true, useMaterial3: true),
      darkTheme: FlexThemeData.dark(scheme: FlexScheme.sanJuanBlue, appBarOpacity: 1.0, appBarStyle: FlexAppBarStyle.primary, transparentStatusBar: true, useMaterial3: true),
      home: const HomePage(),
    );
  }
}