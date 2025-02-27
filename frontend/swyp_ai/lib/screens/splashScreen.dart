import 'package:flutter/material.dart';
import 'package:swyp_ai/screens/authentication_screen.dart';
import '../widgets/gradient_text.dart';
import '../utils/logger.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    AppLogger.debug('SplashScreen initialized');
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    try {
      AppLogger.info('Starting app initialization');
      // Your initialization logic here
      await Future.delayed(const Duration(seconds: 2));

      AppLogger.logNavigation('SplashScreen', 'AuthScreen');
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const AuthScreen()),
      );
    } catch (e, stackTrace) {
      AppLogger.error('Failed to initialize app', e, stackTrace);
    }
  }

  @override
  void dispose() {
    AppLogger.debug('SplashScreen disposed');
    super.dispose();
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
            Text(
              "👋 ♾️",
              style: TextStyle(fontSize: 32, decoration: TextDecoration.none),
            ),
            SizedBox(height: 40),
            Text(
              'Create what you consume',
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
                decoration: TextDecoration.none,
              ),
            ),
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
