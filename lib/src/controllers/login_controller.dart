//* Flutter imports
import 'package:flutter/material.dart';

//* Packages imports
import 'package:firebase_auth/firebase_auth.dart';

//* Project imports
import 'package:s_multiloginp/src/manager/auth_manager.dart';
import 'package:s_multiloginp/src/models/current_user_model.dart';
import 'package:s_multiloginp/src/utils/loading_popup.dart';

class LoginController {
  onEmailLogin({
    required BuildContext context,
    required TextEditingController email,
    required TextEditingController password,
    Function(CurrentUserModel)? onResultEmailLogin,
    Function? onErrorEmailLogin,
    final Color? backgroundColor,
    final Color? loadingColor,
  }) async {
    await LoadingPopup(
      context: context,
      backgroundColor: backgroundColor,
      loadingColor: loadingColor,
      onLoading: _onEmailLoading(email.text, password.text),
      onResult: (CurrentUserModel data) async {
        if (data.token != null) {
          if (onResultEmailLogin != null) {
            email.clear();
            password.clear();
            onResultEmailLogin(data);
          } else {
            debugPrint("onResultEmailLogin was not given or is empty.");
          }
        } else {
          debugPrint("Error on EmailLogin: Data token is null.");
        }
      },
      onError: (FirebaseAuthException error) async {
        if (onErrorEmailLogin != null) {
          onErrorEmailLogin(error);
        } else {
          debugPrint("El error fue: $error");
        }
      },
    ).show();
  }

  // Loadings AuthManager (private for now)
  _onEmailLoading(String email, String password) async {
    await AuthManager().signInEmailAndPassword(
      email: email,
      password: password,
    );
    return AuthManager().getUserCredential();
  }
}
