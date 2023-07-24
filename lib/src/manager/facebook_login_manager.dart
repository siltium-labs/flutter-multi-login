//* Package imports
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class FacebookLoginManager {
  String? _fbUserId;

  facebookLogin() async {
    // Trigger the sign-in flow
    final LoginResult loginResult = await FacebookAuth.instance.login(
      loginBehavior: LoginBehavior.webOnly,
    );

    // Obtener fbUserId, para conexión con API Gas del norte Pedidos
    _fbUserId = loginResult.accessToken!.userId;

    // Create a credential from the access toke
    final OAuthCredential facebookOAuthCredential =
        FacebookAuthProvider.credential(loginResult.accessToken!.token);

    // Once signed in, return the UserCredential (inicio de sesion, en AuthManager)
    return facebookOAuthCredential;
  }

  String? getFbUserId() {
    return _fbUserId;
  }

  facebookLogout() async {
    _fbUserId = null;
    await FacebookAuth.instance.logOut();
  }
}
