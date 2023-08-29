//* Flutter imports
import 'package:flutter/material.dart';

//* Packages imports
import 'package:firebase_auth/firebase_auth.dart';
import 'package:linkedin_login/linkedin_login.dart';

//* Project imports
import 'package:s_multiloginp/src/manager/auth_manager.dart';
import 'package:s_multiloginp/src/models/current_user_model.dart';
import 'package:s_multiloginp/src/utils/loading_popup.dart';
import 'package:s_multiloginp/src/models/linkedin_init_login_model.dart';

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
          debugPrint("Error onEmailLogin: Data token is null.");
        }
      },
      onError: (FirebaseAuthException error) async {
        if (onErrorEmailLogin != null) {
          onErrorEmailLogin(error);
        } else {
          debugPrint("The error was: $error");
        }
      },
    ).show();
  }

  onFacebookLogin({
    required BuildContext context,
    Function(CurrentUserModel)? onResultFacebookLogin,
    Function? onErrorFacebookLogin,
    final Color? backgroundColor,
    final Color? loadingColor,
  }) async {
    await LoadingPopup(
      context: context,
      backgroundColor: backgroundColor,
      loadingColor: loadingColor,
      onLoading: _onFacebookLoading(),
      onResult: (CurrentUserModel data) {
        if (data.token != null) {
          if (onResultFacebookLogin != null) {
            onResultFacebookLogin(data);
          } else {
            debugPrint("onResultFacebookLogin was not given or is empty.");
          }
        } else {
          debugPrint("Error onFacebookLogin: Data token is null.");
        }
      },
      onError: (FirebaseAuthException error) {
        if (onErrorFacebookLogin != null) {
          onErrorFacebookLogin(error);
        } else {
          debugPrint("The error was: $error");
        }
      },
    ).show();
  }

  onGoogleLogin({
    required BuildContext context,
    Function(CurrentUserModel)? onResultGoogleLogin,
    Function? onErrorGoogleLogin,
    final Color? backgroundColor,
    final Color? loadingColor,
  }) async {
    await LoadingPopup(
      context: context,
      backgroundColor: backgroundColor,
      loadingColor: loadingColor,
      onLoading: _onGoogleLoading(),
      onResult: (CurrentUserModel data) {
        if (data.token != null) {
          if (onResultGoogleLogin != null) {
            onResultGoogleLogin(data);
          } else {
            debugPrint("onResultGoogleLogin was not given or is empty.");
          }
        } else {
          debugPrint("Error onGoogleLogin: Data token is null.");
        }
      },
      onError: (FirebaseAuthException error) {
        if (onErrorGoogleLogin != null) {
          onErrorGoogleLogin(error);
        } else {
          debugPrint("The error was: $error");
        }
      },
    ).show();
  }

  onAppleLogin({
    required BuildContext context,
    Function(CurrentUserModel)? onResultAppleLogin,
    Function? onErrorAppleLogin,
    final Color? backgroundColor,
    final Color? loadingColor,
  }) async {
    await LoadingPopup(
      context: context,
      backgroundColor: backgroundColor,
      loadingColor: loadingColor,
      onLoading: _onAppleLoading(),
      onResult: (CurrentUserModel data) {
        if (data.token != null) {
          if (onResultAppleLogin != null) {
            onResultAppleLogin(data);
          } else {
            debugPrint("onResultAppleLogin was not given or is empty.");
          }
        } else {
          debugPrint("Error onAppleLogin: Data token is null.");
        }
      },
      onError: (FirebaseAuthException error) {
        if (onErrorAppleLogin != null) {
          onErrorAppleLogin(error);
        } else {
          debugPrint("The error was: $error");
        }
      },
    ).show();
  }

  onTwitterLogin({
    required BuildContext context,
    Function(CurrentUserModel)? onResultTwitterLogin,
    Function? onErrorTwitterLogin,
    final Color? backgroundColor,
    final Color? loadingColor,
  }) async {
    await LoadingPopup(
      context: context,
      backgroundColor: backgroundColor,
      loadingColor: loadingColor,
      onLoading: _onTwitterLoading(),
      onResult: (CurrentUserModel data) {
        if (data.token != null) {
          if (onResultTwitterLogin != null) {
            onResultTwitterLogin(data);
          } else {
            debugPrint("onResultTwitterLogin was not given or is empty.");
          }
        } else {
          debugPrint("Error onTwitterLogin: Data token is null.");
        }
      },
      onError: (FirebaseAuthException error) {
        if (onErrorTwitterLogin != null) {
          onErrorTwitterLogin(error);
        } else {
          debugPrint("The error was: $error");
        }
      },
    ).show();
  }

  onMicrosoftLogin({
    required BuildContext context,
    Function(CurrentUserModel)? onResultMicrosoftLogin,
    Function? onErrorMicrosoftLogin,
    final Color? backgroundColor,
    final Color? loadingColor,
  }) async {
    await LoadingPopup(
      context: context,
      backgroundColor: backgroundColor,
      loadingColor: loadingColor,
      onLoading: _onMicrosoftLoading(),
      onResult: (CurrentUserModel data) {
        if (data.token != null) {
          if (onResultMicrosoftLogin != null) {
            onResultMicrosoftLogin(data);
          } else {
            debugPrint("onResultMicrosoftLogin was not given or is empty.");
          }
        } else {
          debugPrint("Error onMicrosoftLogin: Data token is null.");
        }
      },
      onError: (FirebaseAuthException error) {
        if (onErrorMicrosoftLogin != null) {
          onErrorMicrosoftLogin(error);
        } else {
          debugPrint("The error was: $error");
        }
      },
    ).show();
  }

  onLinkedinLogin({
    required BuildContext context,
    Function(CurrentUserModel)? onResultLinkedinLogin,
    Function? onErrorLinkedinLogin,
    final Color? backgroundColor,
    final Color? loadingColor,
  }) async {
    LinkedinInitLoginModel? lkLoginData = AuthManager().linkedinLoginData;
    if (lkLoginData != null) {
      Navigator.push(
        context,
        MaterialPageRoute<void>(
          builder: (final BuildContext context) => LinkedInUserWidget(
            destroySession: true,
            redirectUrl: lkLoginData.redirectUrl,
            clientId: lkLoginData.clientId,
            clientSecret: lkLoginData.clientSecret,
            onError: (final UserFailedAction error) {
              if (onErrorLinkedinLogin != null) {
                onErrorLinkedinLogin(error);
              } else {
                debugPrint("El error fue: ${error.toString()}");
              }
            },
            onGetUserProfile: (final UserSucceededAction linkedInUser) {
              CurrentUserModel currentLkUser = CurrentUserModel(
                displayName:
                    "${linkedInUser.user.firstName?.localized?.label} ${linkedInUser.user.lastName?.localized?.label}",
                email: linkedInUser
                    .user.email?.elements?[0].handleDeep?.emailAddress,
                photoURL: linkedInUser.user.profilePicture?.displayImageContent
                    ?.elements?[0].identifiers?[0].identifier,
                token: linkedInUser.user.token.accessToken,
              );
              AuthManager().getUserCredential(currentUser: currentLkUser);
              Navigator.pop(context);
              if (currentLkUser.token != null) {
                if (onResultLinkedinLogin != null) {
                  onResultLinkedinLogin(currentLkUser);
                } else {
                  debugPrint(
                      "onResultLinkedinLogin was not given or is empty.");
                }
              } else {
                debugPrint("Error onLinkedinLogin: Data token is null.");
              }
            },
          ),
          fullscreenDialog: true,
        ),
      );
    } else {
      return throw Exception(
          "No es posible iniciar sesión con LinkedIn si primero no se definen los parámetros \"linkedinClientId\", \"linkedinClientSecret\" y \"linkedinRedirectUrl\" en \"SMultiLogin().multiLoginInit()\"");
    }
  }

  // Loadings AuthManager (private for now)
  _onEmailLoading(String email, String password) async {
    await AuthManager().signInEmailAndPassword(
      email: email,
      password: password,
    );
    return AuthManager().getUserCredential();
  }

  _onFacebookLoading() async {
    await AuthManager().signInWithFacebook();
    return AuthManager().getUserCredential();
  }

  _onGoogleLoading() async {
    await AuthManager().signInWithGoogle();
    return AuthManager().getUserCredential();
  }

  _onAppleLoading() async {
    await AuthManager().signInWithApple();
    return AuthManager().getUserCredential();
  }

  _onTwitterLoading() async {
    await AuthManager().signInWithTwitter();
    return AuthManager().getUserCredential();
  }

  _onMicrosoftLoading() async {
    await AuthManager().signInWithMicrosoft();
    return AuthManager().getUserCredential();
  }
}
