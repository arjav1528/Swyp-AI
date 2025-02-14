import 'package:flutter/material.dart';
import 'package:swyp_ai/constants/constants.dart';
import 'package:swyp_ai/screens/home.dart';


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
      home: HomePage(),
    );
  }
}
