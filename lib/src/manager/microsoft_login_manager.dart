//* Package imports
import 'package:firebase_auth/firebase_auth.dart';

class MicrosoftLoginManager {
  OAuthCredential? microsoftOAuthCredential;

  Future<MicrosoftAuthProvider> microsoftLogin() async {
    // Login with microsoft provider, sign-in flow
    MicrosoftAuthProvider microsoftProvider =
        MicrosoftAuthProvider().setCustomParameters({
      'tenant': 'common',
    });
    // Once signed in, return the Provider (inicio de sesion con provider, en AuthManager)
    return microsoftProvider;
  }

  // microsoftLogout() {}
}
