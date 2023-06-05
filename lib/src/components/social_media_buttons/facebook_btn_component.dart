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
class FacebookBtnComponent extends StatefulWidget {
  late ComponentModeEnum componentMode;
  // Custom style parameters
  ButtonStyle? facebookButtonStyle;
  String? facebookButtonText;
  Widget? facebookButtonIcon;
  // Functions
  Function(CurrentUserModel)? onResultFacebookLogin;
  Function? onErrorFacebookLogin;
  // Loading custom color
  final Color? backgroundColor;
  final Color? loadingColor;

  FacebookBtnComponent.simple({
    Key? key,
    required this.facebookButtonStyle,
    required this.facebookButtonIcon,
    required this.onResultFacebookLogin,
    required this.onErrorFacebookLogin,
    this.backgroundColor,
    this.loadingColor,
  }) : super(key: key) {
    componentMode = ComponentModeEnum.simpleMode;
  }

  FacebookBtnComponent.complex({
    Key? key,
    required this.facebookButtonStyle,
    required this.facebookButtonText,
    required this.facebookButtonIcon,
    required this.onResultFacebookLogin,
    required this.onErrorFacebookLogin,
    this.backgroundColor,
    this.loadingColor,
  }) : super(key: key) {
    componentMode = ComponentModeEnum.complexMode;
  }

  @override
  FacebookBtnComponentState createState() => FacebookBtnComponentState();
}

class FacebookBtnComponentState extends State<FacebookBtnComponent> {
  @override
  Widget build(BuildContext context) {
    return widget.componentMode == ComponentModeEnum.simpleMode
        ? _simpleFacebookLoginButton()
        : _complexFacebookLoginButton();
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
            backgroundColor: const MaterialStatePropertyAll<Color>(kFacebook),
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

  _complexFacebookLoginButton() {
    return ButtonComponent(
      onPressed: () => _onFacebookLogin(),
      text: widget.facebookButtonText ?? "Sign In with Facebook",
      icon: widget.facebookButtonIcon ??
          const Icon(
            Icons.facebook,
            color: kwhite,
            size: 30,
          ),
      buttonStyle: widget.facebookButtonStyle ??
          ButtonStyle(
            backgroundColor: const MaterialStatePropertyAll<Color>(kFacebook),
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
  _onFacebookLogin() async {
    await LoadingPopup(
      context: context,
      onLoading: _onFacebookLoading(),
      onResult: (data) => _onFacebookResult(data),
      onError: (error) => _onFacebookError(error),
      backgroundColor: widget.backgroundColor,
      loadingColor: widget.loadingColor,
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

  _onFacebookError(FirebaseAuthException error) {
    if (widget.onErrorFacebookLogin != null) {
      widget.onErrorFacebookLogin!(error);
    } else {
      debugPrint("El error fue: $error");
    }
  }
}
