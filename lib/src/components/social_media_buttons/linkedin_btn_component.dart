//* Flutter imports
import 'package:flutter/material.dart';

//* Project imports
import 'package:s_multiloginp/src/constants/k_colors.dart';
import 'package:s_multiloginp/src/enums/component_mode_enum.dart';
import 'package:s_multiloginp/src/models/current_user_model.dart';
import 'package:s_multiloginp/src/components/button_component.dart';
import 'package:s_multiloginp/src/controllers/login_controller.dart';

// ignore: must_be_immutable
class LinkedinBtnComponent extends StatefulWidget {
  late ComponentModeEnum componentMode;
  // Custom style parameters
  ButtonStyle? linkedinButtonStyle;
  String? linkedinButtonText;
  Widget? linkedinButtonIcon;
  // Functions
  Function(CurrentUserModel)? onResultLinkedinLogin;
  Function? onErrorLinkedinLogin;
  // Loading custom color
  final Color? backgroundColor;
  final Color? loadingColor;

  LinkedinBtnComponent.simple({
    Key? key,
    required this.linkedinButtonStyle,
    required this.linkedinButtonIcon,
    required this.onResultLinkedinLogin,
    required this.onErrorLinkedinLogin,
    this.backgroundColor,
    this.loadingColor,
  }) : super(key: key) {
    componentMode = ComponentModeEnum.simpleMode;
  }

  LinkedinBtnComponent.complex({
    Key? key,
    required this.linkedinButtonStyle,
    required this.linkedinButtonText,
    required this.linkedinButtonIcon,
    required this.onResultLinkedinLogin,
    required this.onErrorLinkedinLogin,
    this.backgroundColor,
    this.loadingColor,
  }) : super(key: key) {
    componentMode = ComponentModeEnum.complexMode;
  }

  @override
  LinkedinBtnComponentState createState() => LinkedinBtnComponentState();
}

class LinkedinBtnComponentState extends State<LinkedinBtnComponent> {
  @override
  Widget build(BuildContext context) {
    return widget.componentMode == ComponentModeEnum.simpleMode
        ? _simpleLinkedinLoginButton()
        : _complexLinkedinLoginButton();
  }

  _simpleLinkedinLoginButton() {
    return ButtonComponent(
      onPressed: () => LoginController().onLinkedinLogin(
        context: context,
        onResultLinkedinLogin: widget.onResultLinkedinLogin,
        onErrorLinkedinLogin: widget.onErrorLinkedinLogin,
        backgroundColor: widget.backgroundColor,
        loadingColor: widget.loadingColor,
      ),
      icon: widget.linkedinButtonIcon ??
          Image.asset(
            "assets/icon_linkedin_default.png",
            package: 's_multiloginp',
            height: 30,
            color: kwhite,
          ),
      buttonStyle: widget.linkedinButtonStyle ??
          ButtonStyle(
            backgroundColor: const MaterialStatePropertyAll<Color>(kLinkedin),
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

  _complexLinkedinLoginButton() {
    return ButtonComponent(
      onPressed: () => LoginController().onLinkedinLogin(
        context: context,
        onResultLinkedinLogin: widget.onResultLinkedinLogin,
        onErrorLinkedinLogin: widget.onErrorLinkedinLogin,
        backgroundColor: widget.backgroundColor,
        loadingColor: widget.loadingColor,
      ),
      text: widget.linkedinButtonText ?? "Sign In with LinkedIn",
      icon: widget.linkedinButtonIcon ??
          Image.asset(
            "assets/icon_linkedin_default.png",
            package: 's_multiloginp',
            height: 30,
            color: kwhite,
          ),
      buttonStyle: widget.linkedinButtonStyle ??
          ButtonStyle(
            backgroundColor: const MaterialStatePropertyAll<Color>(kLinkedin),
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
