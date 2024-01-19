import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:omega/View/Screens/home_screen.dart';
import 'package:omega/View/Screens/splash_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,// Replace with your desired status bar color
    ),
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

        //SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: splashscreen(),

    );
  }
}


