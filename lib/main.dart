import 'package:final_project/const/themes/app_theme.dart';
import 'package:final_project/controllers/movie_controller.dart';
import 'package:final_project/views/home_screen.dart';
import 'package:final_project/views/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: ".env");
  Get.put(MovieController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: AppThemeData.lightTheme,
      darkTheme: AppThemeData.darkTheme,
      themeMode: ThemeMode.system,
      home: MainScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
