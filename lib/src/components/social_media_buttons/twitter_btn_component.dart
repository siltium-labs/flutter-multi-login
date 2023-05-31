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
class TwitterBtnComponent extends StatefulWidget {
  ButtonStyle? twitterButtonStyle;
  String? twitterButtonText;
  Widget? twitterButtonIcon;
  Function(CurrentUserModel)? onResultTwitterLogin;
  Function(String)? onErrorTwitterLogin;
  late ComponentMode componentMode;

  TwitterBtnComponent.simple({
    Key? key,
    required this.twitterButtonStyle,
    required this.twitterButtonIcon,
    required this.onResultTwitterLogin,
    required this.onErrorTwitterLogin,
  }) : super(key: key) {
    componentMode = ComponentMode.simpleMode;
  }

  TwitterBtnComponent.complex({
    Key? key,
    required this.twitterButtonStyle,
    required this.twitterButtonText,
    required this.twitterButtonIcon,
    required this.onResultTwitterLogin,
    required this.onErrorTwitterLogin,
  }) : super(key: key) {
    componentMode = ComponentMode.complexMode;
  }

  @override
  TwitterBtnComponentState createState() => TwitterBtnComponentState();
}

class TwitterBtnComponentState extends State<TwitterBtnComponent> {
  @override
  Widget build(BuildContext context) {
    return widget.componentMode == ComponentMode.simpleMode
        ? _simpleTwitterLoginButton()
        : _complexTwitterLoginButton();
  }

  _simpleTwitterLoginButton() {
    return ButtonComponent(
      onPressed: () => _onTwitterLogin(),
      icon: widget.twitterButtonIcon ??
          Image.asset(
            "assets/icon_twitter_default.png",
            package: 's_multiloginp',
            height: 30,
            color: kwhite,
          ),
      buttonStyle: widget.twitterButtonStyle ??
          ButtonStyle(
            backgroundColor: const MaterialStatePropertyAll<Color>(kTwitter),
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

  _complexTwitterLoginButton() {
    return ButtonComponent(
      onPressed: () => _onTwitterLogin(),
      text: widget.twitterButtonText ?? "Sign In with Twitter",
      icon: widget.twitterButtonIcon ??
          Image.asset(
            "assets/icon_twitter_default.png",
            package: 's_multiloginp',
            height: 30,
            color: kwhite,
          ),
      buttonStyle: widget.twitterButtonStyle ??
          ButtonStyle(
            backgroundColor: const MaterialStatePropertyAll<Color>(kTwitter),
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
  _onTwitterLogin() async {
    await LoadingPopup(
      context: context,
      onLoading: _onTwitterLoading(),
      onResult: (data) => _onTwitterResult(data),
      onError: (error) => _onTwitterError(error),
    ).show();
  }

  _onTwitterLoading() async {
    await AuthManager().signInWithTwitter();
    return AuthManager().getUserCredential();
  }

  _onTwitterResult(CurrentUserModel data) async {
    if (data.token != null) {
      if (widget.onResultTwitterLogin != null) {
        widget.onResultTwitterLogin!(data);
      } else {
        debugPrint("Null result TwitterLogin");
      }
    } else {
      debugPrint("Error on TwitterLogin");
    }
  }

  _onTwitterError(FirebaseAuthException error) {
    if (widget.onErrorTwitterLogin != null) {
      widget.onErrorTwitterLogin!(
          error.message ?? "Unknown login error with twitter");
    } else {
      debugPrint("El error fue: $error");
    }
  }
}
