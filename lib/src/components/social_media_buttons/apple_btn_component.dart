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
class AppleBtnComponent extends StatefulWidget {
  ButtonStyle? appleButtonStyle;
  String? appleButtonText;
  Widget? appleButtonIcon;
  Function(CurrentUserModel)? onResultAppleLogin;
  Function? onErrorAppleLogin;
  late ComponentModeEnum componentMode;

  AppleBtnComponent.simple({
    Key? key,
    required this.appleButtonStyle,
    required this.appleButtonIcon,
    required this.onResultAppleLogin,
    required this.onErrorAppleLogin,
  }) : super(key: key) {
    componentMode = ComponentModeEnum.simpleMode;
  }

  AppleBtnComponent.complex({
    Key? key,
    required this.appleButtonStyle,
    required this.appleButtonText,
    required this.appleButtonIcon,
    required this.onResultAppleLogin,
    required this.onErrorAppleLogin,
  }) : super(key: key) {
    componentMode = ComponentModeEnum.complexMode;
  }

  @override
  AppleBtnComponentState createState() => AppleBtnComponentState();
}

class AppleBtnComponentState extends State<AppleBtnComponent> {
  @override
  Widget build(BuildContext context) {
    return widget.componentMode == ComponentModeEnum.simpleMode
        ? _simpleAppleLoginButton()
        : _complexAppleLoginButton();
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
            backgroundColor: const MaterialStatePropertyAll<Color>(kApple),
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

  _complexAppleLoginButton() {
    return ButtonComponent(
      onPressed: () => _onAppleLogin(),
      text: widget.appleButtonText ?? "Sign In with Apple",
      icon: widget.appleButtonIcon ??
          const Icon(
            Icons.apple,
            color: kwhite,
            size: 30,
          ),
      buttonStyle: widget.appleButtonStyle ??
          ButtonStyle(
            backgroundColor: const MaterialStatePropertyAll<Color>(kApple),
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

  _onAppleError(FirebaseAuthException error) {
    if (widget.onErrorAppleLogin != null) {
      widget.onErrorAppleLogin!(error);
    } else {
      debugPrint("El error fue: $error");
    }
  }
}
