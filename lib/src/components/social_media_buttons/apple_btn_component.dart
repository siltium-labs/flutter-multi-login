//* Flutter imports
import 'package:flutter/material.dart';

//* Project imports
import 'package:s_multiloginp/src/constants/k_colors.dart';
import 'package:s_multiloginp/src/enums/component_mode_enum.dart';
import 'package:s_multiloginp/src/models/current_user_model.dart';
import 'package:s_multiloginp/src/components/button_component.dart';
import 'package:s_multiloginp/src/controllers/login_controller.dart';

// ignore: must_be_immutable
class AppleBtnComponent extends StatefulWidget {
  late ComponentModeEnum componentMode;
  // Custom style parameters
  ButtonStyle? appleButtonStyle;
  String? appleButtonText;
  Widget? appleButtonIcon;
  // Functions
  Function(CurrentUserModel)? onResultAppleLogin;
  Function? onErrorAppleLogin;
  // Loading custom color
  final Color? backgroundColor;
  final Color? loadingColor;

  AppleBtnComponent.simple({
    Key? key,
    required this.appleButtonStyle,
    required this.appleButtonIcon,
    required this.onResultAppleLogin,
    required this.onErrorAppleLogin,
    this.backgroundColor,
    this.loadingColor,
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
    this.backgroundColor,
    this.loadingColor,
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
      onPressed: () => LoginController().onAppleLogin(
        context: context,
        onResultAppleLogin: widget.onResultAppleLogin,
        onErrorAppleLogin: widget.onErrorAppleLogin,
        backgroundColor: widget.backgroundColor,
        loadingColor: widget.loadingColor,
      ),
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
      onPressed: () => LoginController().onAppleLogin(
        context: context,
        onResultAppleLogin: widget.onResultAppleLogin,
        onErrorAppleLogin: widget.onErrorAppleLogin,
        backgroundColor: widget.backgroundColor,
        loadingColor: widget.loadingColor,
      ),
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
}
