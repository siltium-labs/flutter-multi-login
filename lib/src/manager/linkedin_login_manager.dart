//* Package imports
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:linkedin_login/linkedin_login.dart';
import 'package:s_multiloginp/s_multiloginp.dart';

class LinkedinLoginManager {
  linkedinLogin(LinkedinLoginModel? lkLoginData) async {
    OAuthCredential? linkedinOAuthCredential;
    String? linkedinToken;
    if (lkLoginData != null) {
      LinkedInUserWidget(
        redirectUrl: lkLoginData.redirectUrl,
        clientId: lkLoginData.clientId,
        clientSecret: lkLoginData.clientSecret,
        onGetUserProfile: (UserSucceededAction linkedInUser) {
          // // print('Access token ${linkedInUser.user.token.accessToken}');
          // // print('First name: ${linkedInUser.user.firstName.localized.label}');
          // // print('Last name: ${linkedInUser.user.lastName.localized.label}');
          //!OAuthCredential = null;
          // linkedinOAuthCredential = OAuthProvider('linkedin.com').credential(
          //   accessToken: linkedInUser.user.token.accessToken,
          // );
          linkedinToken = linkedInUser.user.token.accessToken;
        },
        onError: (UserFailedAction e) {
          debugPrint('Error: ${e.toString()}');
        },
      );
      // return linkedinOAuthCredential;
      return linkedinToken;
    } else {
      return throw Exception(
          "No es posible iniciar sesión con LinkedIn si primero no se define \"linkedinInitData\" en \"SMultiLogin().multiLoginInit()\"");
    }
  }

  // linkedinLogout() async {}
}
