//* Flutter imports
import 'package:flutter/material.dart';

//* Packages imports
import 'package:firebase_auth/firebase_auth.dart';

//* Project imports
import 'package:s_multiloginp/src/manager/auth_manager.dart';
import 'package:s_multiloginp/src/models/current_user_model.dart';
import 'package:s_multiloginp/src/utils/loading_popup.dart';

class EmailLoginController {
  onEmailLogin({
    required BuildContext context,
    required String email,
    required String password,
    Function(CurrentUserModel)? onResultEmailLogin,
    Function? onErrorEmailLogin,
    final Color? backgroundColor,
    final Color? loadingColor,
  }) async {
    await LoadingPopup(
      context: context,
      onLoading: _onEmailLoading(email, password),
      onResult: (CurrentUserModel data) async {
        if (data.token != null) {
          if (onResultEmailLogin != null) {
            onResultEmailLogin(data);
          } else {
            debugPrint("Null result EmailLogin");
          }
        } else {
          debugPrint("Error on EmailLogin");
        }
      },
      onError: (FirebaseAuthException error) async {
        if (onErrorEmailLogin != null) {
          onErrorEmailLogin(error);
        } else {
          debugPrint("El error fue: $error");
        }
      },
      backgroundColor: backgroundColor,
      loadingColor: loadingColor,
    ).show();
  }

  _onEmailLoading(String email, String password) async {
    await AuthManager().signInEmailAndPassword(
      email: email,
      password: password,
    );
    return AuthManager().getUserCredential();
  }
}
