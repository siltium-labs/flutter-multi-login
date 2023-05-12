//* Dart impors
import 'dart:io';

//* Flutter imports
import 'package:flutter/material.dart';

//* Project imports
import 'package:s_multiloginp/src/constants/k_colors.dart';
import 'package:s_multiloginp/src/enums/component_mode_enum.dart';
import 'package:s_multiloginp/src/manager/auth_manager.dart';
import 'package:s_multiloginp/src/models/current_user_model.dart';
import 'package:s_multiloginp/src/utils/loading_popup.dart';
import 'package:s_multiloginp/src/components/button_component.dart';

// ignore: must_be_immutable
class SocialMediaButtonsComponent extends StatefulWidget {
  ComponentMode componentMode;
  // Styles
  ButtonStyle? googleButtonStyle;
  String? googleButtonText;
  Widget? googleButtonIcon;
  ButtonStyle? facebookButtonStyle;
  String? facebookButtonText;
  Widget? facebookButtonIcon;
  ButtonStyle? appleButtonStyle;
  String? appleButtonText;
  Widget? appleButtonIcon;
  // Functions
  Function(CurrentUserModel)? onResultGoogleLogin;
  Function(CurrentUserModel)? onResultFacebookLogin;
  Function(CurrentUserModel)? onResultAppleLogin;
  Function(String)? onErrorGoogleLogin;
  Function(String)? onErrorFacebookLogin;
  Function(String)? onErrorAppleLogin;

  SocialMediaButtonsComponent({
    Key? key,
    required this.componentMode,
    // Styles
    required this.googleButtonStyle,
    required this.googleButtonText,
    required this.googleButtonIcon,
    required this.facebookButtonStyle,
    required this.facebookButtonText,
    required this.facebookButtonIcon,
    required this.appleButtonStyle,
    required this.appleButtonText,
    required this.appleButtonIcon,
    // Functions
    required this.onResultGoogleLogin,
    required this.onResultFacebookLogin,
    required this.onResultAppleLogin,
    required this.onErrorGoogleLogin,
    required this.onErrorFacebookLogin,
    required this.onErrorAppleLogin,
  }) : super(key: key);

  @override
  SocialMediaButtonsComponentState createState() =>
      SocialMediaButtonsComponentState();
}

class SocialMediaButtonsComponentState
    extends State<SocialMediaButtonsComponent> {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.center,
      spacing: 10,
      runSpacing: 10,
      children: [
        ...(widget.componentMode == ComponentMode.simpleCardMode ||
                widget.componentMode == ComponentMode.simpleMode)
            ? _getSimpleLoginButtonsList()
            : _getComplexLoginButtonsList()
      ],
    );
  }

  _getSimpleLoginButtonsList() {
    List<Widget> buttonsList = [];
    if (widget.onResultGoogleLogin != null) {
      buttonsList.add(_simpleGoogleLoginButton());
    }
    if (widget.onResultFacebookLogin != null) {
      buttonsList.add(_simpleFacebookLoginButton());
    }
    if (widget.onResultAppleLogin != null && Platform.isIOS) {
      buttonsList.add(_simpleAppleLoginButton());
    }
    return buttonsList;
  }

  _simpleGoogleLoginButton() {
    return ButtonComponent(
      onPressed: () => _onGoogleLogin(),
      icon: widget.googleButtonIcon ??
          Image.asset(
            "assets/icon_google_default.png",
            package: 's_multiloginp',
            height: 30,
            color: kwhite,
          ),
      buttonStyle: widget.googleButtonStyle ??
          ButtonStyle(
            backgroundColor: const MaterialStatePropertyAll<Color>(kred),
            fixedSize: const MaterialStatePropertyAll<Size>(
              Size(90, 40),
            ),
            shape: MaterialStatePropertyAll<OutlinedBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
            ),
          ),
    );
  }

  _simpleFacebookLoginButton() {
    return ButtonComponent(
      onPressed: () => _onFacebookLogin(),
      icon: widget.facebookButtonIcon ??
          const Icon(
            Icons.facebook,
            color: kwhite,
            size: 30,
          ),
      buttonStyle: widget.facebookButtonStyle ??
          ButtonStyle(
            backgroundColor: const MaterialStatePropertyAll<Color>(kblue),
            fixedSize: const MaterialStatePropertyAll<Size>(
              Size(90, 40),
            ),
            shape: MaterialStatePropertyAll<OutlinedBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
            ),
          ),
    );
  }

  _simpleAppleLoginButton() {
    return ButtonComponent(
      onPressed: () => _onAppleLogin(),
      icon: widget.appleButtonIcon ??
          const Icon(
            Icons.apple,
            color: kwhite,
            size: 30,
          ),
      buttonStyle: widget.appleButtonStyle ??
          ButtonStyle(
            backgroundColor: const MaterialStatePropertyAll<Color>(kblack),
            fixedSize: const MaterialStatePropertyAll<Size>(
              Size(90, 40),
            ),
            shape: MaterialStatePropertyAll<OutlinedBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
            ),
          ),
    );
  }

  _getComplexLoginButtonsList() {
    List<Widget> buttonsList = [];
    if (widget.onResultGoogleLogin != null) {
      buttonsList.add(_complexGoogleLoginButton());
    }
    if (widget.onResultFacebookLogin != null) {
      buttonsList.add(_complexFacebookLoginButton());
    }
    if (widget.onResultAppleLogin != null && Platform.isIOS) {
      buttonsList.add(_complexAppleLoginButton());
    }
    return buttonsList;
  }

  _complexGoogleLoginButton() {
    return ButtonComponent(
      onPressed: () => _onGoogleLogin(),
      text: widget.googleButtonText ?? "Sing In with Google",
      icon: widget.googleButtonIcon ??
          Image.asset(
            "assets/icon_google_default.png",
            package: 's_multiloginp',
            height: 30,
          ),
      buttonStyle: widget.googleButtonStyle ??
          ButtonStyle(
            backgroundColor: const MaterialStatePropertyAll<Color>(kred),
            minimumSize: const MaterialStatePropertyAll<Size>(
              Size(double.infinity, 40),
            ),
            shape: MaterialStatePropertyAll<OutlinedBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
            ),
          ),
    );
  }

  _complexFacebookLoginButton() {
    return ButtonComponent(
      onPressed: () => _onFacebookLogin(),
      text: widget.facebookButtonText ?? "Sing In with Facebook",
      icon: widget.facebookButtonIcon ??
          const Icon(
            Icons.facebook,
            color: kwhite,
            size: 30,
          ),
      buttonStyle: widget.facebookButtonStyle ??
          ButtonStyle(
            backgroundColor: const MaterialStatePropertyAll<Color>(kblue),
            minimumSize: const MaterialStatePropertyAll<Size>(
              Size(double.infinity, 40),
            ),
            shape: MaterialStatePropertyAll<OutlinedBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
            ),
          ),
    );
  }

  _complexAppleLoginButton() {
    return ButtonComponent(
      onPressed: () => _onAppleLogin(),
      text: widget.appleButtonText ?? "Sing In with Apple",
      icon: widget.appleButtonIcon ??
          const Icon(
            Icons.apple,
            color: kwhite,
            size: 30,
          ),
      buttonStyle: widget.appleButtonStyle ??
          ButtonStyle(
            backgroundColor: const MaterialStatePropertyAll<Color>(kblack),
            minimumSize: const MaterialStatePropertyAll<Size>(
              Size(double.infinity, 40),
            ),
            shape: MaterialStatePropertyAll<OutlinedBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
            ),
          ),
    );
  }

  //CONTROLLER----------------------------------------------------
  //!GOOGLE
  _onGoogleLogin() async {
    await LoadingPopup(
      context: context,
      onLoading: _onGoogleLoading(),
      onResult: (data) => _onGoogleResult(data),
      onError: (error) => _onGoogleError(error),
    ).show();
  }

  _onGoogleLoading() async {
    await AuthManager().signInWithGoogle();
    return AuthManager().getUserCredential();
  }

  _onGoogleResult(CurrentUserModel data) async {
    if (data.token != null) {
      if (widget.onResultGoogleLogin != null) {
        widget.onResultGoogleLogin!(data);
      } else {
        debugPrint("Null result GoogleLogin");
      }
    } else {
      debugPrint("Error on GoogleLogin");
    }
  }

  _onGoogleError(String error) {
    if (widget.onErrorGoogleLogin != null) {
      widget.onErrorGoogleLogin!(error);
    } else {
      debugPrint("El error fue: $error");
    }
  }

  //?FACEBOOK
  _onFacebookLogin() async {
    await LoadingPopup(
      context: context,
      onLoading: _onFacebookLoading(),
      onResult: (data) => _onFacebookResult(data),
      onError: (error) => _onFacebookError(error),
    ).show();
  }

  _onFacebookLoading() async {
    await AuthManager().signInWithFacebook();
    return AuthManager().getUserCredential();
  }

  _onFacebookResult(CurrentUserModel data) async {
    if (data.token != null) {
      if (widget.onResultFacebookLogin != null) {
        widget.onResultFacebookLogin!(data);
      } else {
        debugPrint("Null result FacebookLogin");
      }
    } else {
      debugPrint("Error on FacebookLogin");
    }
  }

  _onFacebookError(String error) {
    if (widget.onErrorFacebookLogin != null) {
      widget.onErrorFacebookLogin!(error);
    } else {
      debugPrint("El error fue: $error");
    }
  }

  //TODO: APPLE. DESCOMENTAR ONAPPLERESULT Y DATA PARA PROBAR!!!
  _onAppleLogin() async {
    await LoadingPopup(
      context: context,
      onLoading: _onAppleLoading(),
      onResult: (data) => _onAppleResult(/*data*/),
      onError: (error) => _onAppleError(error),
    ).show();
  }

  _onAppleLoading() async {
    await AuthManager().signInWithApple();
    return AuthManager().getUserCredential();
  }

  _onAppleResult(/*GetUserCredentialModel data*/) async {
    debugPrint("Apple login");
    // if (data.token != null) {
    //   if (widget.onResultAppleLogin != null) {
    //     widget.onResultAppleLogin!(data);
    //   } else {
    //     debugPrint("Null result AppleLogin");
    //   }
    // } else {
    //   debugPrint("Error on AppleLogin");
    // }
  }

  _onAppleError(String error) {
    if (widget.onErrorAppleLogin != null) {
      widget.onErrorAppleLogin!(error);
    } else {
      debugPrint("El error fue: $error");
    }
  }
}
