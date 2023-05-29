//* Package imports
import 'package:firebase_auth/firebase_auth.dart';
import 'package:s_multiloginp/s_multiloginp.dart';

class MicrosoftLoginManager {
  OAuthCredential? microsoftOAuthCredential;

  Future<MicrosoftAuthProvider> microsoftLogin(
      MicrosoftLoginModel? msLoginData) async {
    if (msLoginData != null) {
      // Login with microsoft, using auth provider
      MicrosoftAuthProvider microsoftProvider =
          MicrosoftAuthProvider().setCustomParameters({
        'tenant': msLoginData.tenant,
        'redirect_uri': msLoginData.redirectUri,
        'scope ': 'User.Read',
        // Tambien el scope puede ser: "email openid profile User.Read",
        // ó "email openid profile offline_access",
      });
      return microsoftProvider;
    } else {
      return throw Exception(
          "No es posible iniciar sesión con Microsoft si primero no se define \"microsoftInitData\" en \"SMultiLogin().multiLoginInit()\"");
    }
  }

  // microsoftLogout() {}
}
