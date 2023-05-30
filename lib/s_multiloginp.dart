//* Flutter imports
import 'package:flutter/material.dart';

//* Package/Firebase imports
import 'package:firebase_core/firebase_core.dart';

//* Project imports
import 'package:s_multiloginp/src/components/card_background_component.dart';
import 'package:s_multiloginp/src/components/login_form_component.dart';
import 'package:s_multiloginp/src/components/social_media_buttons_component.dart';
import 'package:s_multiloginp/src/constants/k_colors.dart';
import 'package:s_multiloginp/src/enums/component_mode_enum.dart';
import 'package:s_multiloginp/src/manager/auth_manager.dart';
import 'package:s_multiloginp/src/models/multilogin_init_model.dart';
import 'package:s_multiloginp/src/models/current_user_model.dart';

//* Models exports
export 'package:s_multiloginp/src/models/multilogin_init_model.dart';
export 'package:s_multiloginp/src/models/twitter_login_model.dart';
export 'package:s_multiloginp/src/models/linkedin_login_model.dart';

// Plugin class (with Method Channel)
import 's_multiloginp_platform_interface.dart';

class SMultiloginp {
  Future<String?> getPlatformVersion() {
    return SMultiloginpPlatform.instance.getPlatformVersion();
  }
}
//

class SMultiLogin {
  static final SMultiLogin _instance = SMultiLogin._constructor();
  factory SMultiLogin() {
    return _instance;
  }
  SMultiLogin._constructor();

  multiLoginInit({required MultiLoginInitModel initModel}) async {
    // Init de Firebase -Correo y redes sociales- (Android & iOS)
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: initModel.options,
    );
    // Init Google (iOS)
    if (initModel.googleIOSClientId != null &&
        initModel.googleIOSClientId!.isNotEmpty) {
      AuthManager().googleLoginInit(initModel.googleIOSClientId!);
    }
    // Init Twitter (Android & iOS)
    if (initModel.twitterInitData != null) {
      AuthManager()
          .twitterLoginInit(newTwLoginData: initModel.twitterInitData!);
    }
    // Init LinkedIn (Android & iOS)
    if (initModel.linkedinInitData != null) {
      AuthManager()
          .linkedinLoginInit(newLkLoginData: initModel.linkedinInitData!);
    }
  }

  logout() async {
    AuthManager().onLogOut();
  }

  CurrentUserModel? userData() {
    return AuthManager().getUserData();
  }
}

// ignore: must_be_immutable
class SMultiLoginComponent extends StatefulWidget {
  late ComponentMode componentMode;
  // Custom style parameters
  BoxDecoration? cardDecoration;
  EdgeInsets? cardInnerPadding;
  InputDecoration? emailInputDecoration;
  InputDecoration? passwordInputDecoration;
  TextStyle? emailInputTextStyle;
  TextStyle? passwordInputTextStyle;
  String? footerText;
  TextStyle footerTextStyle;
  ButtonStyle? emailButtonStyle;
  String? emailButtonText;
  Widget? emailButtonIcon;
  ButtonStyle? googleButtonStyle;
  String? googleButtonText;
  Widget? googleButtonIcon;
  ButtonStyle? facebookButtonStyle;
  String? facebookButtonText;
  Widget? facebookButtonIcon;
  ButtonStyle? appleButtonStyle;
  String? appleButtonText;
  Widget? appleButtonIcon;
  ButtonStyle? twitterButtonStyle;
  String? twitterButtonText;
  Widget? twitterButtonIcon;
  ButtonStyle? linkedinButtonStyle;
  String? linkedinButtonText;
  Widget? linkedinButtonIcon;
  ButtonStyle? microsoftButtonStyle;
  String? microsoftButtonText;
  Widget? microsoftButtonIcon;
  // Functions
  Function(CurrentUserModel)? onResultEmailLogin;
  Function(CurrentUserModel)? onResultGoogleLogin;
  Function(CurrentUserModel)? onResultFacebookLogin;
  Function(CurrentUserModel)? onResultAppleLogin;
  Function(CurrentUserModel)? onResultTwitterLogin;
  Function(CurrentUserModel)? onResultLinkedinLogin;
  Function(CurrentUserModel)? onResultMicrosoftLogin;
  Function(String)? onErrorEmailLogin;
  Function(String)? onErrorGoogleLogin;
  Function(String)? onErrorFacebookLogin;
  Function(String)? onErrorAppleLogin;
  Function(String)? onErrorTwitterLogin;
  Function(String)? onErrorLinkedinLogin;
  Function(String)? onErrorMicrosoftLogin;

  SMultiLoginComponent.simpleCardMode({
    Key? key,
    // Custom style parameters
    this.cardDecoration,
    this.cardInnerPadding,
    this.emailInputDecoration,
    this.passwordInputDecoration,
    this.emailInputTextStyle,
    this.passwordInputTextStyle,
    this.footerText,
    this.footerTextStyle = const TextStyle(
      color: kblack,
      fontSize: 15,
      fontWeight: FontWeight.normal,
    ),
    this.emailButtonStyle,
    this.emailButtonText,
    this.emailButtonIcon,
    this.googleButtonStyle,
    this.googleButtonIcon,
    this.facebookButtonStyle,
    this.facebookButtonIcon,
    this.appleButtonStyle,
    this.appleButtonIcon,
    this.twitterButtonStyle,
    this.twitterButtonIcon,
    this.linkedinButtonStyle,
    this.linkedinButtonIcon,
    this.microsoftButtonStyle,
    this.microsoftButtonIcon,
    // Functions
    this.onResultEmailLogin,
    this.onResultGoogleLogin,
    this.onResultFacebookLogin,
    this.onResultAppleLogin,
    this.onResultTwitterLogin,
    this.onResultLinkedinLogin,
    this.onResultMicrosoftLogin,
    this.onErrorEmailLogin,
    this.onErrorGoogleLogin,
    this.onErrorFacebookLogin,
    this.onErrorAppleLogin,
    this.onErrorTwitterLogin,
    this.onErrorLinkedinLogin,
    this.onErrorMicrosoftLogin,
  }) : super(key: key) {
    componentMode = ComponentMode.simpleCardMode;
  }

  SMultiLoginComponent.simpleMode({
    Key? key,
    // Custom style parameters
    this.emailInputDecoration,
    this.passwordInputDecoration,
    this.emailInputTextStyle,
    this.passwordInputTextStyle,
    this.footerText,
    this.footerTextStyle = const TextStyle(
      color: kblack,
      fontSize: 15,
      fontWeight: FontWeight.normal,
    ),
    this.emailButtonStyle,
    this.emailButtonText,
    this.emailButtonIcon,
    this.googleButtonStyle,
    this.googleButtonIcon,
    this.facebookButtonStyle,
    this.facebookButtonIcon,
    this.appleButtonStyle,
    this.appleButtonIcon,
    this.twitterButtonStyle,
    this.twitterButtonIcon,
    this.linkedinButtonStyle,
    this.linkedinButtonIcon,
    this.microsoftButtonStyle,
    this.microsoftButtonIcon,
    // Functions
    this.onResultEmailLogin,
    this.onResultGoogleLogin,
    this.onResultFacebookLogin,
    this.onResultAppleLogin,
    this.onResultTwitterLogin,
    this.onResultLinkedinLogin,
    this.onResultMicrosoftLogin,
    this.onErrorEmailLogin,
    this.onErrorGoogleLogin,
    this.onErrorFacebookLogin,
    this.onErrorAppleLogin,
    this.onErrorTwitterLogin,
    this.onErrorLinkedinLogin,
    this.onErrorMicrosoftLogin,
  }) : super(key: key) {
    componentMode = ComponentMode.simpleMode;
  }

  SMultiLoginComponent.complexCardMode({
    Key? key,
    // Custom style parameters
    this.cardDecoration,
    this.cardInnerPadding,
    this.emailInputDecoration,
    this.passwordInputDecoration,
    this.emailInputTextStyle,
    this.passwordInputTextStyle,
    this.footerText,
    this.footerTextStyle = const TextStyle(
      color: kblack,
      fontSize: 15,
      fontWeight: FontWeight.normal,
    ),
    this.emailButtonStyle,
    this.emailButtonText,
    this.emailButtonIcon,
    this.googleButtonStyle,
    this.googleButtonText,
    this.googleButtonIcon,
    this.facebookButtonStyle,
    this.facebookButtonText,
    this.facebookButtonIcon,
    this.appleButtonStyle,
    this.appleButtonText,
    this.appleButtonIcon,
    this.twitterButtonStyle,
    this.twitterButtonText,
    this.twitterButtonIcon,
    this.linkedinButtonStyle,
    this.linkedinButtonText,
    this.linkedinButtonIcon,
    this.microsoftButtonStyle,
    this.microsoftButtonText,
    this.microsoftButtonIcon,
    // Functions
    this.onResultEmailLogin,
    this.onResultGoogleLogin,
    this.onResultFacebookLogin,
    this.onResultAppleLogin,
    this.onResultTwitterLogin,
    this.onResultLinkedinLogin,
    this.onResultMicrosoftLogin,
    this.onErrorEmailLogin,
    this.onErrorGoogleLogin,
    this.onErrorFacebookLogin,
    this.onErrorAppleLogin,
    this.onErrorTwitterLogin,
    this.onErrorLinkedinLogin,
    this.onErrorMicrosoftLogin,
  }) : super(key: key) {
    componentMode = ComponentMode.complexCardMode;
  }

  SMultiLoginComponent.complexMode({
    Key? key,
    // Custom style parameters
    this.emailInputDecoration,
    this.passwordInputDecoration,
    this.emailInputTextStyle,
    this.passwordInputTextStyle,
    this.footerText,
    this.footerTextStyle = const TextStyle(
      color: kblack,
      fontSize: 15,
      fontWeight: FontWeight.normal,
    ),
    this.emailButtonStyle,
    this.emailButtonText,
    this.emailButtonIcon,
    this.googleButtonStyle,
    this.googleButtonText,
    this.googleButtonIcon,
    this.facebookButtonStyle,
    this.facebookButtonText,
    this.facebookButtonIcon,
    this.appleButtonStyle,
    this.appleButtonText,
    this.appleButtonIcon,
    this.twitterButtonStyle,
    this.twitterButtonText,
    this.twitterButtonIcon,
    this.linkedinButtonStyle,
    this.linkedinButtonText,
    this.linkedinButtonIcon,
    this.microsoftButtonStyle,
    this.microsoftButtonText,
    this.microsoftButtonIcon,
    // Functions
    this.onResultEmailLogin,
    this.onResultGoogleLogin,
    this.onResultFacebookLogin,
    this.onResultAppleLogin,
    this.onResultTwitterLogin,
    this.onResultLinkedinLogin,
    this.onResultMicrosoftLogin,
    this.onErrorEmailLogin,
    this.onErrorGoogleLogin,
    this.onErrorFacebookLogin,
    this.onErrorAppleLogin,
    this.onErrorTwitterLogin,
    this.onErrorLinkedinLogin,
    this.onErrorMicrosoftLogin,
  }) : super(key: key) {
    componentMode = ComponentMode.complexMode;
  }

  @override
  SMultiLoginComponentState createState() => SMultiLoginComponentState();
}

class SMultiLoginComponentState extends State<SMultiLoginComponent> {
  @override
  Widget build(BuildContext context) {
    switch (widget.componentMode) {
      case ComponentMode.simpleCardMode:
        return _cardModeContent();
      case ComponentMode.complexCardMode:
        return _cardModeContent();
      default:
        return _content();
    }
  }

  _cardModeContent() {
    return CardBackgroundComponent(
      cardDecoration: widget.cardDecoration,
      cardInnerPadding: widget.cardInnerPadding,
      child: _content(),
    );
  }

  _content() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Email Login Form & Button
        Visibility(
          visible: widget.onResultEmailLogin != null,
          child: Column(
            children: [
              LoginFormComponent(
                emailInputDecoration: widget.emailInputDecoration,
                emailInputTextStyle: widget.emailInputTextStyle,
                passwordInputDecoration: widget.passwordInputDecoration,
                passwordInputTextStyle: widget.passwordInputTextStyle,
                emailButtonStyle: widget.emailButtonStyle,
                emailButtonText: widget.emailButtonText,
                emailButtonIcon: widget.emailButtonIcon,
                onResultEmailLogin: widget.onResultEmailLogin,
                onErrorEmailLogin: widget.onErrorEmailLogin,
              ),
            ],
          ),
        ),
        Visibility(
          visible: widget.footerText != null,
          child: Column(
            children: [
              Text(
                widget.footerText ?? "O podés ingresar con:",
                style: widget.footerTextStyle,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
        // Social Media Login Buttons
        Wrap(
          alignment: WrapAlignment.center,
          spacing: 10,
          runSpacing: 10,
          children: [
            SocialMediaButtonsComponent(
              componentMode: widget.componentMode,
              googleButtonStyle: widget.googleButtonStyle,
              googleButtonText: widget.googleButtonText,
              googleButtonIcon: widget.googleButtonIcon,
              facebookButtonStyle: widget.facebookButtonStyle,
              facebookButtonText: widget.facebookButtonText,
              facebookButtonIcon: widget.facebookButtonIcon,
              appleButtonStyle: widget.appleButtonStyle,
              appleButtonText: widget.appleButtonText,
              appleButtonIcon: widget.appleButtonIcon,
              twitterButtonStyle: widget.twitterButtonStyle,
              twitterButtonText: widget.twitterButtonText,
              twitterButtonIcon: widget.twitterButtonIcon,
              linkedinButtonStyle: widget.linkedinButtonStyle,
              linkedinButtonText: widget.linkedinButtonText,
              linkedinButtonIcon: widget.linkedinButtonIcon,
              microsoftButtonStyle: widget.microsoftButtonStyle,
              microsoftButtonText: widget.microsoftButtonText,
              microsoftButtonIcon: widget.microsoftButtonIcon,
              onResultGoogleLogin: widget.onResultGoogleLogin,
              onResultFacebookLogin: widget.onResultFacebookLogin,
              onResultAppleLogin: widget.onResultAppleLogin,
              onResultTwitterLogin: widget.onResultTwitterLogin,
              onResultLinkedinLogin: widget.onResultLinkedinLogin,
              onResultMicrosoftLogin: widget.onResultMicrosoftLogin,
              onErrorGoogleLogin: widget.onErrorGoogleLogin,
              onErrorFacebookLogin: widget.onErrorFacebookLogin,
              onErrorAppleLogin: widget.onErrorAppleLogin,
              onErrorTwitterLogin: widget.onErrorTwitterLogin,
              onErrorLinkedinLogin: widget.onErrorLinkedinLogin,
              onErrorMicrosoftLogin: widget.onErrorMicrosoftLogin,
            ),
          ],
        ),
      ],
    );
  }
}
