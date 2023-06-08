//* Flutter imports
import 'package:flutter/material.dart';

//* Project imports
import 'package:s_multiloginp/src/constants/k_colors.dart';
import 'package:s_multiloginp/src/enums/component_mode_enum.dart';
import 'package:s_multiloginp/src/models/current_user_model.dart';
import 'package:s_multiloginp/src/components/button_component.dart';
import 'package:s_multiloginp/src/controllers/login_controller.dart';

// ignore: must_be_immutable
class MicrosoftBtnComponent extends StatefulWidget {
  late ComponentModeEnum componentMode;
  // Custom style parameters
  ButtonStyle? microsoftButtonStyle;
  String? microsoftButtonText;
  Widget? microsoftButtonIcon;
  // Functions
  Function(CurrentUserModel)? onResultMicrosoftLogin;
  Function? onErrorMicrosoftLogin;
  // Loading custom color
  final Color? backgroundColor;
  final Color? loadingColor;

  MicrosoftBtnComponent.simple({
    Key? key,
    required this.microsoftButtonStyle,
    required this.microsoftButtonIcon,
    required this.onResultMicrosoftLogin,
    required this.onErrorMicrosoftLogin,
    this.backgroundColor,
    this.loadingColor,
  }) : super(key: key) {
    componentMode = ComponentModeEnum.simpleMode;
  }

  MicrosoftBtnComponent.complex({
    Key? key,
    required this.microsoftButtonStyle,
    required this.microsoftButtonText,
    required this.microsoftButtonIcon,
    required this.onResultMicrosoftLogin,
    required this.onErrorMicrosoftLogin,
    this.backgroundColor,
    this.loadingColor,
  }) : super(key: key) {
    componentMode = ComponentModeEnum.complexMode;
  }

  @override
  MicrosoftBtnComponentState createState() => MicrosoftBtnComponentState();
}

class MicrosoftBtnComponentState extends State<MicrosoftBtnComponent> {
  @override
  Widget build(BuildContext context) {
    return widget.componentMode == ComponentModeEnum.simpleMode
        ? _simpleMicrosoftLoginButton()
        : _complexMicrosoftLoginButton();
  }

  _simpleMicrosoftLoginButton() {
    return ButtonComponent(
      onPressed: () => LoginController().onMicrosoftLogin(
        context: context,
        onResultMicrosoftLogin: widget.onResultMicrosoftLogin,
        onErrorMicrosoftLogin: widget.onErrorMicrosoftLogin,
        backgroundColor: widget.backgroundColor,
        loadingColor: widget.loadingColor,
      ),
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
      onPressed: () => LoginController().onMicrosoftLogin(
        context: context,
        onResultMicrosoftLogin: widget.onResultMicrosoftLogin,
        onErrorMicrosoftLogin: widget.onErrorMicrosoftLogin,
        backgroundColor: widget.backgroundColor,
        loadingColor: widget.loadingColor,
      ),
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
}
