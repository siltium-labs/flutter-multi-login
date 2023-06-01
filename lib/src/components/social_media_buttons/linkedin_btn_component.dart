//* Flutter imports
import 'package:flutter/material.dart';

//* Packages imports
import 'package:linkedin_login/linkedin_login.dart';

//* Project imports
import 'package:s_multiloginp/src/constants/k_colors.dart';
import 'package:s_multiloginp/src/enums/component_mode_enum.dart';
import 'package:s_multiloginp/src/manager/auth_manager.dart';
import 'package:s_multiloginp/src/models/current_user_model.dart';
import 'package:s_multiloginp/src/models/linkedin_init_login_model.dart';
import 'package:s_multiloginp/src/components/button_component.dart';

// ignore: must_be_immutable
class LinkedinBtnComponent extends StatefulWidget {
  ButtonStyle? linkedinButtonStyle;
  String? linkedinButtonText;
  Widget? linkedinButtonIcon;
  Function(CurrentUserModel)? onResultLinkedinLogin;
  Function? onErrorLinkedinLogin;
  late ComponentMode componentMode;

  LinkedinBtnComponent.simple({
    Key? key,
    required this.linkedinButtonStyle,
    required this.linkedinButtonIcon,
    required this.onResultLinkedinLogin,
    required this.onErrorLinkedinLogin,
  }) : super(key: key) {
    componentMode = ComponentMode.simpleMode;
  }

  LinkedinBtnComponent.complex({
    Key? key,
    required this.linkedinButtonStyle,
    required this.linkedinButtonText,
    required this.linkedinButtonIcon,
    required this.onResultLinkedinLogin,
    required this.onErrorLinkedinLogin,
  }) : super(key: key) {
    componentMode = ComponentMode.complexMode;
  }

  @override
  LinkedinBtnComponentState createState() => LinkedinBtnComponentState();
}

class LinkedinBtnComponentState extends State<LinkedinBtnComponent> {
  @override
  Widget build(BuildContext context) {
    return widget.componentMode == ComponentMode.simpleMode
        ? _simpleLinkedinLoginButton()
        : _complexLinkedinLoginButton();
  }

  _simpleLinkedinLoginButton() {
    return ButtonComponent(
      onPressed: () => _onLinkedinLogin(),
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
      onPressed: () => _onLinkedinLogin(),
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

  // CONTROLLER----------------------------------------------------
  _onLinkedinLogin() async {
    LinkedinInitLoginModel? lkLoginData = AuthManager().linkedinLoginData;
    if (lkLoginData != null) {
      Navigator.push(
        context,
        MaterialPageRoute<void>(
          builder: (final BuildContext context) => LinkedInUserWidget(
            destroySession: true,
            redirectUrl: lkLoginData.redirectUrl,
            clientId: lkLoginData.clientId,
            clientSecret: lkLoginData.clientSecret,
            onError: (final UserFailedAction error) {
              if (widget.onErrorLinkedinLogin != null) {
                widget.onErrorLinkedinLogin!(error);
              } else {
                debugPrint("El error fue: ${error.toString()}");
              }
            },
            onGetUserProfile: (final UserSucceededAction linkedInUser) {
              CurrentUserModel currentLkUser = CurrentUserModel(
                displayName:
                    "${linkedInUser.user.firstName?.localized?.label} ${linkedInUser.user.lastName?.localized?.label}",
                email: linkedInUser
                    .user.email?.elements?[0].handleDeep?.emailAddress,
                photoURL: linkedInUser.user.profilePicture?.displayImageContent
                    ?.elements?[0].identifiers?[0].identifier,
                token: linkedInUser.user.token.accessToken,
              );
              AuthManager().getUserCredential(currentUser: currentLkUser);
              Navigator.pop(context);
              if (currentLkUser.token != null) {
                if (widget.onResultLinkedinLogin != null) {
                  widget.onResultLinkedinLogin!(currentLkUser);
                } else {
                  debugPrint("Null result LinkedinLogin");
                }
              } else {
                debugPrint("Error on LinkedinLogin");
              }
            },
          ),
          fullscreenDialog: true,
        ),
      );
    } else {
      return throw Exception(
          "No es posible iniciar sesión con LinkedIn si primero no se definen los parámetros \"linkedinClientId\", \"linkedinClientSecret\" y \"linkedinRedirectUrl\" en \"SMultiLogin().multiLoginInit()\"");
    }
  }
}
