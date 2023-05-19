//* Dart imports
import 'dart:io';

//* Package imports
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleLoginManager {
  googleLogin(String? iOSClientId) async {
    final GoogleSignInAccount? googleUser;

    // Trigger the authentication flow (abre sdk login google)
    if (Platform.isIOS && (iOSClientId == null || iOSClientId.isEmpty)) {
      return throw Exception(
          "No es posible iniciar sesión con Google en iOS si primero no se define \"googleIOSClientId\" en \"SMultiLogin().multiLoginInit()\"");
    } else if (Platform.isIOS &&
        iOSClientId != null &&
        iOSClientId.isNotEmpty) {
      googleUser = await GoogleSignIn(clientId: iOSClientId).signIn();
    } else {
      googleUser = await GoogleSignIn().signIn();
    }

    // Obtain the auth details from the request (despues de elegir el usuario)
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential (guardar credenciales)
    AuthCredential googleOAuthCredential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential (inicio de sesion, en AuthManager)
    return googleOAuthCredential;
  }

  googleLogout() async {
    await GoogleSignIn().signOut();
  }
}
