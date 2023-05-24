//* Package imports
import 'package:firebase_auth/firebase_auth.dart';
import 'package:aad_oauth/aad_oauth.dart';
import 'package:aad_oauth/model/config.dart';
import 'package:s_multiloginp/s_multiloginp.dart';

class MicrosoftLoginManager {
  AadOAuth? oauth;
  OAuthCredential? microsoftOAuthCredential;

  Future<MicrosoftAuthProvider> microsoftLogin(
      MicrosoftLoginModel? msLoginData) async {
    if (msLoginData != null) {
      // // Login with microsoft
      // final Config config = Config(
      //   tenant: msLoginData.tenant,
      //   clientId: msLoginData.clientId,
      //   // clientSecret: msLoginData.clientSecret,
      //   scope:
      //       "email openid profile User.Read", // "openid profile offline_access",
      //   redirectUri: msLoginData.redirectUri,
      //   navigatorKey: msLoginData.navigatorKey,
      // );

      // AadOAuth oauth = AadOAuth(config);
      // final result = await oauth.login();
      // result.fold(
      //   (failure) {
      //     throw Exception(failure.toString());
      //   },
      //   (token) {
      //     // Create a credential from the access token
      //     microsoftOAuthCredential =
      //         MicrosoftAuthProvider.credential(token.accessToken!);
      //   },
      // );
      // return microsoftOAuthCredential;

      MicrosoftAuthProvider microsoftProvider =
          MicrosoftAuthProvider().setCustomParameters({
        'tenant': msLoginData.tenant,
        // 'client_id': msLoginData.clientId,
        'redirect_uri': msLoginData.redirectUri,
        'scope ': 'User.Read',
      });
      return microsoftProvider;
    } else {
      return throw Exception(
          "No es posible iniciar sesión con Microsoft si primero no se define \"microsoftInitData\" en \"SMultiLogin().multiLoginInit()\"");
    }
  }

  microsoftLogout() async {
    await oauth?.logout();
  }
}
