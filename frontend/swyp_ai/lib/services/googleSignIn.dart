import 'dart:developer';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:swyp_ai/utils/logger.dart';

class GoogleSignInService {
  static final _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'profile',
      'openid',
    ],
    clientId: "563501183367-dljrvdgf9hqrgo1vgbt03akv01smrhai.apps.googleusercontent.com"
  );

  static Future<GoogleSignInAccount?> loginWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        AppLogger.error("Google Sign-In cancelled by user");
        return null;
      }
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      AppLogger.info(_googleSignIn);
      // AppLogger.info("Google ID Token: ${googleAuth.idToken}");
      log("Google ID Token: ${googleAuth.idToken}");
      AppLogger.info("Google Sign-In successful");
      return googleUser;
    } catch (error) {
      AppLogger.error("Google Sign-In failed: $error");
      return null;
    }

  }

  static Future<void> logout() async {
    await _googleSignIn.signOut();
    AppLogger.info("User Logged Out");
  }
}