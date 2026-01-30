//* Dart imports
import 'dart:io';

//* Package imports
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleLoginManager {
  googleLogin(String? iOSClientId) async {
    GoogleSignIn googleSignIn = GoogleSignIn.instance;

    final GoogleSignInAccount? googleUser;

    // Trigger the authentication flow
    if (Platform.isIOS && (iOSClientId == null || iOSClientId.isEmpty)) {
      return throw Exception(
          "No es posible iniciar sesión con Google en iOS si primero no se define \"googleIOSClientId\" en \"SMultiLogin().multiLoginInit()\"");
    }

    await googleSignIn.initialize(
      clientId: Platform.isIOS ? iOSClientId : null,
    );

    googleUser = await googleSignIn.authenticate();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser.authentication;

    // Create a new credential
    AuthCredential googleOAuthCredential = GoogleAuthProvider.credential(
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential (inicio de sesion, en AuthManager)
    return googleOAuthCredential;
  }

  googleLogout() async {
    await GoogleSignIn.instance.signOut();
  }
}
