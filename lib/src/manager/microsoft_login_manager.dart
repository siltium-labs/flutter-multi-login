//* Package imports
import 'package:firebase_auth/firebase_auth.dart';
import 'package:aad_oauth/aad_oauth.dart';
import 'package:aad_oauth/model/config.dart';
import 'package:s_multiloginp/s_multiloginp.dart';

class MicrosoftLoginManager {
  AadOAuth? oauth;

  microsoftLogin(MicrosoftLoginModel? msLoginData) async {
    if (msLoginData != null) {
      // Login with microsoft
      final Config config = Config(
        tenant: msLoginData.tenant,
        clientId: msLoginData.clientId,
        scope: "email openid profile User.Read", // "openid profile offline_access",
        redirectUri: msLoginData.redirectUri,
        navigatorKey: msLoginData.navigatorKey,
      );

      AadOAuth oauth = AadOAuth(config);
      final result = await oauth.login();
      result.fold(
        (failure) {
          throw Exception(failure.toString());
        },
        (token) {
          String accessToken =
              token.accessToken!; //await oauth.getAccessToken(),

          // Create a credential from the access token
          final microsoftOAuthCredential =
              MicrosoftAuthProvider.credential(accessToken);

          // Once signed in, return the UserCredential (inicio de sesion, en AuthManager)
          return microsoftOAuthCredential;
        },
      );
    } else {
      return throw Exception(
          "No es posible iniciar sesión con Microsoft si primero no se define \"microsoftInitData\" en \"SMultiLogin().multiLoginInit()\"");
    }
  }

  microsoftLogout() async {
    await oauth?.logout();
  }
}
