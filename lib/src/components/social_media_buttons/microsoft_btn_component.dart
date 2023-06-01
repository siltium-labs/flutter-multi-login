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
class MicrosoftBtnComponent extends StatefulWidget {
  ButtonStyle? microsoftButtonStyle;
  String? microsoftButtonText;
  Widget? microsoftButtonIcon;
  Function(CurrentUserModel)? onResultMicrosoftLogin;
  Function? onErrorMicrosoftLogin;
  late ComponentMode componentMode;

  MicrosoftBtnComponent.simple({
    Key? key,
    required this.microsoftButtonStyle,
    required this.microsoftButtonIcon,
    required this.onResultMicrosoftLogin,
    required this.onErrorMicrosoftLogin,
  }) : super(key: key) {
    componentMode = ComponentMode.simpleMode;
  }

  MicrosoftBtnComponent.complex({
    Key? key,
    required this.microsoftButtonStyle,
    required this.microsoftButtonText,
    required this.microsoftButtonIcon,
    required this.onResultMicrosoftLogin,
    required this.onErrorMicrosoftLogin,
  }) : super(key: key) {
    componentMode = ComponentMode.complexMode;
  }

  @override
  MicrosoftBtnComponentState createState() => MicrosoftBtnComponentState();
}

class MicrosoftBtnComponentState extends State<MicrosoftBtnComponent> {
  @override
  Widget build(BuildContext context) {
    return widget.componentMode == ComponentMode.simpleMode
        ? _simpleMicrosoftLoginButton()
        : _complexMicrosoftLoginButton();
  }

  _simpleMicrosoftLoginButton() {
    return ButtonComponent(
      onPressed: () => _onMicrosoftLogin(),
      icon: widget.microsoftButtonIcon ??
          Image.asset(
            "assets/icon_microsoft_default.png",
            package: 's_multiloginp',
            height: 30,
            color: kwhite,
          ),
      buttonStyle: widget.microsoftButtonStyle ??
          ButtonStyle(
            backgroundColor: const MaterialStatePropertyAll<Color>(kMicrosoft),
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

  _complexMicrosoftLoginButton() {
    return ButtonComponent(
      onPressed: () => _onMicrosoftLogin(),
      text: widget.microsoftButtonText ?? "Sign In with Microsoft",
      icon: widget.microsoftButtonIcon ??
          Image.asset(
            "assets/icon_microsoft_default.png",
            package: 's_multiloginp',
            height: 30,
            color: kwhite,
          ),
      buttonStyle: widget.microsoftButtonStyle ??
          ButtonStyle(
            backgroundColor: const MaterialStatePropertyAll<Color>(kMicrosoft),
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
  _onMicrosoftLogin() async {
    await LoadingPopup(
      context: context,
      onLoading: _onMicrosoftLoading(),
      onResult: (data) => _onMicrosoftResult(data),
      onError: (error) => _onMicrosoftError(error),
    ).show();
  }

  _onMicrosoftLoading() async {
    await AuthManager().signInWithMicrosoft();
    return AuthManager().getUserCredential();
  }

  _onMicrosoftResult(CurrentUserModel data) async {
    if (data.token != null) {
      if (widget.onResultMicrosoftLogin != null) {
        widget.onResultMicrosoftLogin!(data);
      } else {
        debugPrint("Null result MicrosoftLogin");
      }
    } else {
      debugPrint("Error on MicrosoftLogin");
    }
  }

  _onMicrosoftError(FirebaseAuthException error) {
    if (widget.onErrorMicrosoftLogin != null) {
      widget.onErrorMicrosoftLogin!(error);
    } else {
      debugPrint("El error fue: $error");
    }
  }
}
