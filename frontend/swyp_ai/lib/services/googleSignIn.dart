
import 'dart:developer';


import 'package:google_sign_in/google_sign_in.dart';
import 'package:swyp_ai/utils/logger.dart';

class GoogleSignInService{
  static final _googleSignIn = GoogleSignIn(scopes: ['email' ]);


  static Future<GoogleSignInAccount?> loginWithGoogle() async {
    GoogleSignInAccount? _googleSignInAccount = await _googleSignIn.signIn();
    GoogleSignInAuthentication googleSignInAuthentication = await _googleSignInAccount!.authentication;
    AppLogger.info(googleSignInAuthentication.accessToken);
    return _googleSignInAccount;
  }

  static Future<void> logout() async {
    await _googleSignIn.signOut();
  }
}