import 'package:flutter/material.dart';
import 'package:swyp_ai/constants/constants.dart';
import 'package:swyp_ai/screens/authentication_screen.dart';
import 'package:swyp_ai/screens/genre_selection.dart';
import 'package:swyp_ai/screens/home.dart';
import 'package:swyp_ai/screens/splashScreen.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: CustomTheme.theme,
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
