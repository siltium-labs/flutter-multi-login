//* Package imports
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class FacebookLoginManager {
  String sha256ofString(String input) {
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  String generateNonce([int length = 32]) {
    const String charset =
        '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-.';
    final random = Random.secure();
    return List.generate(
        length, (value) => charset[random.nextInt(charset.length)]).join();
  }

  facebookLogin() async {
    //* FOR iOS
    if (Platform.isIOS) {
      final rawNonce = generateNonce();
      final nonce = sha256ofString(rawNonce);
      // Trigger the sign-in flow
      final LoginResult loginResult = await FacebookAuth.instance.login(
        loginBehavior: LoginBehavior.webOnly,
        loginTracking: LoginTracking.limited,
        nonce: nonce,
      );

      // Create a credential from the access token (depends of accessToken type)
      final OAuthCredential facebookOAuthCredential;

      switch (loginResult.accessToken!.type) {
        case AccessTokenType.classic:
          final classicToken = loginResult.accessToken as ClassicToken;
          facebookOAuthCredential = FacebookAuthProvider.credential(
            classicToken.authenticationToken!,
          );
          break;
        case AccessTokenType.limited:
          final limitedToken = loginResult.accessToken as LimitedToken;
          facebookOAuthCredential = OAuthCredential(
            providerId: 'facebook.com',
            signInMethod: 'oauth',
            idToken: limitedToken.tokenString,
            rawNonce: rawNonce,
          );
          break;
      }

      // Once signed in, return the UserCredential (inicio de sesion, en AuthManager)
      return facebookOAuthCredential;

      //* FOR Android
    } else {
      // Trigger the sign-in flow
      final LoginResult loginResult = await FacebookAuth.instance.login(
        loginBehavior: LoginBehavior.webOnly,
      );

      // Create a credential from the access toke
      final OAuthCredential facebookOAuthCredential =
          FacebookAuthProvider.credential(loginResult.accessToken!.tokenString);

      // Once signed in, return the UserCredential (inicio de sesion, en AuthManager)
      return facebookOAuthCredential;
    }
  }

  facebookLogout() async {
    await FacebookAuth.instance.logOut();
  }
}
