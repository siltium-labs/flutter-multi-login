//* Flutter imports
import 'package:flutter/material.dart';

//* Project imports
import 'package:s_multiloginp/src/constants/k_colors.dart';
import 'package:s_multiloginp/src/enums/component_mode_enum.dart';
import 'package:s_multiloginp/src/manager/auth_manager.dart';
import 'package:s_multiloginp/src/models/current_user_model.dart';

//* Components imports
import 'package:s_multiloginp/src/components/card_background_component.dart';
import 'package:s_multiloginp/src/components/login_form_component.dart';
import 'package:s_multiloginp/src/components/social_media_buttons_component.dart';

//* Firebase imports
import 'package:firebase_core/firebase_core.dart';
import 'package:s_multiloginp/src/models/twitter_login_model.dart';

//* Plugin imports
import 's_multiloginp_platform_interface.dart';

// Plugin class (with Method Channel)
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

  multiLoginInit({required FirebaseOptions options}) async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: options,
    );
  }

  googleLoginInit({required String iOSClientId}) {
    AuthManager().googleLoginInit(iOSClientId);
  }

  twitterLoginInit({
    required String apiKey,
    required String apiSecretKey,
    required String redirectURI,
  }) {
    AuthManager().twitterLoginInit(
      newTwLoginData: TwitterLoginModel(
        apiKey: apiKey,
        apiSecretKey: apiSecretKey,
        redirectURI: redirectURI,
      ),
    );
  }

  logout() async {
    AuthManager().onLogOut();
  }

  userData() {
    return AuthManager().getUserData();
  }
}

// ignore: must_be_immutable
class SMultiLoginComponent extends StatefulWidget {
  late ComponentMode componentMode;
  // Custom parameters
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
  // Functions
  Function(CurrentUserModel)? onResultEmailLogin;
  Function(CurrentUserModel)? onResultGoogleLogin;
  Function(CurrentUserModel)? onResultFacebookLogin;
  Function(CurrentUserModel)? onResultAppleLogin;
  Function(CurrentUserModel)? onResultTwitterLogin;
  Function(String)? onErrorEmailLogin;
  Function(String)? onErrorGoogleLogin;
  Function(String)? onErrorFacebookLogin;
  Function(String)? onErrorAppleLogin;
  Function(String)? onErrorTwitterLogin;

  SMultiLoginComponent.simpleCardMode({
    Key? key,
    // Custom parameters
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
    // Functions
    this.onResultEmailLogin,
    this.onResultGoogleLogin,
    this.onResultFacebookLogin,
    this.onResultAppleLogin,
    this.onResultTwitterLogin,
    this.onErrorEmailLogin,
    this.onErrorGoogleLogin,
    this.onErrorFacebookLogin,
    this.onErrorAppleLogin,
    this.onErrorTwitterLogin,
  }) : super(key: key) {
    componentMode = ComponentMode.simpleCardMode;
  }

  SMultiLoginComponent.simpleMode({
    Key? key,
    // Custom parameters
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
    // Functions
    this.onResultEmailLogin,
    this.onResultGoogleLogin,
    this.onResultFacebookLogin,
    this.onResultAppleLogin,
    this.onErrorEmailLogin,
    this.onErrorGoogleLogin,
    this.onErrorFacebookLogin,
    this.onErrorAppleLogin,
  }) : super(key: key) {
    componentMode = ComponentMode.simpleMode;
  }

  SMultiLoginComponent.complexCardMode({
    Key? key,
    // Custom parameters
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
    // Functions
    this.onResultEmailLogin,
    this.onResultGoogleLogin,
    this.onResultFacebookLogin,
    this.onResultAppleLogin,
    this.onErrorEmailLogin,
    this.onErrorGoogleLogin,
    this.onErrorFacebookLogin,
    this.onErrorAppleLogin,
  }) : super(key: key) {
    componentMode = ComponentMode.complexCardMode;
  }

  SMultiLoginComponent.complexMode({
    Key? key,
    // Custom parameters
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
    // Functions
    this.onResultEmailLogin,
    this.onResultGoogleLogin,
    this.onResultFacebookLogin,
    this.onResultAppleLogin,
    this.onErrorEmailLogin,
    this.onErrorGoogleLogin,
    this.onErrorFacebookLogin,
    this.onErrorAppleLogin,
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
              onResultGoogleLogin: widget.onResultGoogleLogin,
              onResultFacebookLogin: widget.onResultFacebookLogin,
              onResultAppleLogin: widget.onResultAppleLogin,
              onResultTwitterLogin: widget.onResultTwitterLogin,
              onErrorGoogleLogin: widget.onErrorGoogleLogin,
              onErrorFacebookLogin: widget.onErrorFacebookLogin,
              onErrorAppleLogin: widget.onErrorAppleLogin,
              onErrorTwitterLogin: widget.onErrorTwitterLogin,
            ),
          ],
        ),
      ],
    );
  }
}
