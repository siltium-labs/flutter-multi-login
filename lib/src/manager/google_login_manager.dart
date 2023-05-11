//* Package imports
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleLoginManager {
  _getGoogleCredential() async {
    // Trigger the authentication flow (abre sdk login google)
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request (despues de elegir el usuario)
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential (guardar credenciales)
    AuthCredential googleOAuthCredential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    return googleOAuthCredential;
  }

  AuthCredential googleLogin() {
    return _getGoogleCredential();
  }

  googleLogout() async {
    await GoogleSignIn().signOut();
  }
}
