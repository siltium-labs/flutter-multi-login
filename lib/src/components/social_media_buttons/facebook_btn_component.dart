//* Flutter imports
import 'package:flutter/material.dart';

//* Project imports
import 'package:s_multiloginp/src/constants/k_colors.dart';
import 'package:s_multiloginp/src/models/current_user_model.dart';
import 'package:s_multiloginp/src/enums/component_mode_enum.dart';
import 'package:s_multiloginp/src/components/button_component.dart';
import 'package:s_multiloginp/src/controllers/login_controller.dart';

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
      onPressed: () => LoginController().onFacebookLogin(
        context: context,
        onResultFacebookLogin: widget.onResultFacebookLogin,
        onErrorFacebookLogin: widget.onErrorFacebookLogin,
        backgroundColor: widget.backgroundColor,
        loadingColor: widget.loadingColor,
      ),
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
      onPressed: () => LoginController().onFacebookLogin(
        context: context,
        onResultFacebookLogin: widget.onResultFacebookLogin,
        onErrorFacebookLogin: widget.onErrorFacebookLogin,
        backgroundColor: widget.backgroundColor,
        loadingColor: widget.loadingColor,
      ),
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
}
