//* Package imports
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class FacebookLoginManager {
  facebookLogin() async {
    // Trigger the sign-in flow (abre sdk login facebook)
    final LoginResult loginResult = await FacebookAuth.instance.login(
      loginBehavior: LoginBehavior.webOnly,
    );

    // Create a credential from the access token (guardar credenciales)
    final OAuthCredential facebookOAuthCredential =
        FacebookAuthProvider.credential(loginResult.accessToken!.token);

    // Once signed in, return the UserCredential (inicio de sesion, en AuthManager)
    return facebookOAuthCredential;
  }

  facebookLogout() async {
    await FacebookAuth.instance.logOut();
  }
}
