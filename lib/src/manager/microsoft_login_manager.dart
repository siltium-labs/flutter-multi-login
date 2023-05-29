//* Package imports
import 'package:firebase_auth/firebase_auth.dart';
import 'package:s_multiloginp/s_multiloginp.dart';

class MicrosoftLoginManager {
  OAuthCredential? microsoftOAuthCredential;

  Future<MicrosoftAuthProvider> microsoftLogin(
      MicrosoftLoginModel? msLoginData) async {
    if (msLoginData != null) {
      // Login with microsoft
      MicrosoftAuthProvider microsoftProvider =
          MicrosoftAuthProvider().setCustomParameters({
        'tenant': msLoginData.tenant,
        // 'client_id': msLoginData.clientId,
        // 'redirect_uri': msLoginData.redirectUri,
        // 'scope ': 'User.Read',
      });
      return microsoftProvider;
    } else {
      return throw Exception(
          "No es posible iniciar sesión con Microsoft si primero no se define \"microsoftInitData\" en \"SMultiLogin().multiLoginInit()\"");
    }
  }

  // microsoftLogout() {}
}
