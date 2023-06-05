//* Flutter imports
import 'package:flutter/material.dart';

//* Packages imports
import 'package:firebase_auth/firebase_auth.dart';

//* Project imports
import 'package:s_multiloginp/src/constants/k_colors.dart';
import 'package:s_multiloginp/src/enums/component_mode_enum.dart';
import 'package:s_multiloginp/src/manager/auth_manager.dart';
import 'package:s_multiloginp/src/models/current_user_model.dart';
import 'package:s_multiloginp/src/utils/loading_popup.dart';
import 'package:s_multiloginp/src/components/button_component.dart';

// ignore: must_be_immutable
class GoogleBtnComponent extends StatefulWidget {
  late ComponentModeEnum componentMode;
  // Custom style parameters
  ButtonStyle? googleButtonStyle;
  String? googleButtonText;
  Widget? googleButtonIcon;
  // Functions
  Function(CurrentUserModel)? onResultGoogleLogin;
  Function? onErrorGoogleLogin;
  // Loading custom color
  final Color? backgroundColor;
  final Color? loadingColor;

  GoogleBtnComponent.simple({
    Key? key,
    required this.googleButtonStyle,
    required this.googleButtonIcon,
    required this.onResultGoogleLogin,
    required this.onErrorGoogleLogin,
    this.backgroundColor,
    this.loadingColor,
  }) : super(key: key) {
    componentMode = ComponentModeEnum.simpleMode;
  }

  GoogleBtnComponent.complex({
    Key? key,
    required this.googleButtonStyle,
    required this.googleButtonText,
    required this.googleButtonIcon,
    required this.onResultGoogleLogin,
    required this.onErrorGoogleLogin,
    this.backgroundColor,
    this.loadingColor,
  }) : super(key: key) {
    componentMode = ComponentModeEnum.complexMode;
  }

  @override
  GoogleBtnComponentState createState() => GoogleBtnComponentState();
}

class GoogleBtnComponentState extends State<GoogleBtnComponent> {
  @override
  Widget build(BuildContext context) {
    return widget.componentMode == ComponentModeEnum.simpleMode
        ? _simpleGoogleLoginButton()
        : _complexGoogleLoginButton();
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
            backgroundColor: const MaterialStatePropertyAll<Color>(kGoogle),
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

  _complexGoogleLoginButton() {
    return ButtonComponent(
      onPressed: () => _onGoogleLogin(),
      text: widget.googleButtonText ?? "Sign In with Google",
      icon: widget.googleButtonIcon ??
          Image.asset(
            "assets/icon_google_default.png",
            package: 's_multiloginp',
            height: 30,
            color: kwhite,
          ),
      buttonStyle: widget.googleButtonStyle ??
          ButtonStyle(
            backgroundColor: const MaterialStatePropertyAll<Color>(kGoogle),
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

  // CONTROLLER----------------------------------------------------
  _onGoogleLogin() async {
    await LoadingPopup(
      context: context,
      onLoading: _onGoogleLoading(),
      onResult: (data) => _onGoogleResult(data),
      onError: (error) => _onGoogleError(error),
      backgroundColor: widget.backgroundColor,
      loadingColor: widget.loadingColor,
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

  _onGoogleError(FirebaseAuthException error) {
    if (widget.onErrorGoogleLogin != null) {
      widget.onErrorGoogleLogin!(error);
    } else {
      debugPrint("El error fue: $error");
    }
  }
}
