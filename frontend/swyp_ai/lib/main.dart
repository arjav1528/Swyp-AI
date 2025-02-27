import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:swyp_ai/constants/constants.dart';
import 'package:swyp_ai/core/network/api_client.dart';
import 'package:swyp_ai/core/providers/api_providers.dart';
import 'package:swyp_ai/screens/splashScreen.dart';
import 'package:swyp_ai/core/network/auth_api.dart';

void main() async {
  await dotenv.load(fileName: ".env");
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
