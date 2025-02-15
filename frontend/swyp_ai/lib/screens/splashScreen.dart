
import 'package:flutter/material.dart';
import 'package:swyp_ai/screens/authentication_screen.dart';
import 'package:swyp_ai/screens/genre_selection.dart';
import '../widgets/gradient_text.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Delay for 2 seconds, then navigate to the next page
    Future.delayed(Duration(seconds: 2), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => AuthScreen()), // Replace NextPage() with your desired page
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GradientText(
              text: "Swyp",
              gradient: LinearGradient(
                colors: [Color(0xFF1f3d91), Color(0xFF4385f3)],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              fontSize: 55,
            ),
            SizedBox(height: 40),
            Text("👋 ♾️", style: TextStyle(fontSize: 32, decoration: TextDecoration.none)),
            SizedBox(height: 40),
            Text('Create what you consume',
                style: TextStyle(fontSize: 20, color: Colors.white, decoration: TextDecoration.none)),
            SizedBox(height: 20),
            // CircularProgressIndicator(
            //   valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF4385f3)),
            // ),
          ],
        ),
      ),
    );
  }
}

