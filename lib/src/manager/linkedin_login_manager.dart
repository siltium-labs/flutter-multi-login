//* Project imports
import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:s_multiloginp/s_multiloginp.dart';

//* Package imports
import 'package:dio/dio.dart' show Dio, Options, Response;
import 'package:oauth2_client/linkedin_oauth2_client.dart';
import 'package:oauth2_client/oauth2_client.dart';
import 'package:oauth2_client/access_token_response.dart';
import 'package:s_multiloginp/src/models/linkedin_login_response_model.dart';

class LinkedinLoginManager {
  linkedinLogin(LinkedinLoginModel? lkLoginData) async {
    if (lkLoginData != null) {
      OAuth2Client lkClient = LinkedInOAuth2Client(
        redirectUri: lkLoginData.redirectUrl,
        customUriScheme: lkLoginData.customUriScheme,
      );
      AccessTokenResponse linkedinToken =
          await lkClient.getTokenWithClientCredentialsFlow(
        clientId: lkLoginData.clientId,
        clientSecret: lkLoginData.clientSecret,
      );

      OAuthCredential lk = OAuthProvider('linkedin').credential(
        accessToken: linkedinToken.accessToken,
        secret: lkLoginData.clientSecret,
      );

      return lk;

      Options options = Options();
      options.headers = {};
      options.headers!["authorization"] = 'Bearer ${linkedinToken.accessToken}';
      Dio dio = Dio();

      Response result = await dio
          .get<String>("https://api.linkedin.com/v2/userinfo", options: options)
          .timeout(const Duration(seconds: 5));

      return LinkedinLoginResponseModel.fromJson(result.data);
    } else {
      return throw Exception(
          "No es posible iniciar sesión con LinkedIn si primero no se define \"linkedinInitData\" en \"SMultiLogin().multiLoginInit()\"");
    }
  }

  // linkedinLogout() async {}
}
