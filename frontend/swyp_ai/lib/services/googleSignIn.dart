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
    serverClientId: "563501183367-kk67nq9d4ev4e3376n1bh321o23gge10.apps.googleusercontent.com"
  );

  static Future<GoogleSignInAccount?> loginWithGoogle() async {
    try {
      final account = await _googleSignIn.signIn();
      if (account == null) {
        AppLogger.warning("User canceled sign in or the sign in result is null");
        return null;
      }
      final _googleAuth = await account.authentication;
      log("Google Auth: ${_googleAuth.idToken}");

      return account;
    } catch (error) {
      AppLogger.error("Error Logging In: $error");
      return null;
    }
  }

  static Future<void> logout() async {
    await _googleSignIn.signOut();
    AppLogger.info("User Logged Out");
  }
}