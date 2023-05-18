//* Package imports
import 'package:firebase_auth/firebase_auth.dart';
import 'package:s_multiloginp/src/models/twitter_login_model.dart';
import 'package:twitter_login/twitter_login.dart';

class TwitterLoginManager {
  twitterLogin(TwitterLoginModel twLoginData) async {
    // Create a TwitterLogin instance
    final twitterLogin = TwitterLogin(
      apiKey: twLoginData.apiKey,
      apiSecretKey: twLoginData.apiSecretKey, //! CONSULTAR ESTO
      redirectURI: twLoginData.redirectURI,
    );

    // Trigger the sign-in flow
    final authResult = await twitterLogin.login();

    // Create a credential from the access token
    final twitterOAuthCredential = TwitterAuthProvider.credential(
      accessToken: authResult.authToken!,
      secret: authResult.authTokenSecret!,
    );

    // Once signed in, return the UserCredential (inicio de sesion, en AuthManager)
    return twitterOAuthCredential;
  }

  // twitterLogout() async {}
}
