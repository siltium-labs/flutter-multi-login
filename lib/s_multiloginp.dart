//* Dart imports
import 'dart:io';

//* Flutter imports
import 'package:flutter/material.dart';

//* Package/Firebase imports
import 'package:firebase_core/firebase_core.dart';

//* Project imports
import 'package:s_multiloginp/src/components/card_background_component.dart';
import 'package:s_multiloginp/src/components/email_login_component.dart';
import 'package:s_multiloginp/src/components/social_media_buttons/google_btn_component.dart';
import 'package:s_multiloginp/src/components/social_media_buttons/facebook_btn_component.dart';
import 'package:s_multiloginp/src/components/social_media_buttons/apple_btn_component.dart';
import 'package:s_multiloginp/src/components/social_media_buttons/twitter_btn_component.dart';
import 'package:s_multiloginp/src/components/social_media_buttons/microsoft_btn_component.dart';
import 'package:s_multiloginp/src/components/social_media_buttons/linkedin_btn_component.dart';
import 'package:s_multiloginp/src/constants/k_colors.dart';
import 'package:s_multiloginp/src/enums/component_mode_enum.dart';
import 'package:s_multiloginp/src/manager/auth_manager.dart';
import 'package:s_multiloginp/src/models/current_user_model.dart';
import 'package:s_multiloginp/src/models/linkedin_init_login_model.dart';
import 'package:s_multiloginp/src/models/twitter_init_login_model.dart';
import 'package:s_multiloginp/src/utils/extensions.dart';

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

  multiLoginInit({
    required FirebaseOptions options,
    String? googleIOSClientId,
    String? twitterApiKey,
    String? twitterApiSecretKey,
    String? twitterRedirectURI,
    String? linkedinClientId,
    String? linkedinClientSecret,
    String? linkedinRedirectUrl,
  }) async {
    // Init de Firebase -Correo y redes sociales- (Android & iOS)
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: options,
    );
    // Init Google (iOS)
    if (googleIOSClientId.isNotNullOrEmpty()) {
      AuthManager().googleLoginInit(googleIOSClientId);
    }
    // Init Twitter (Android & iOS)
    if (twitterApiKey.isNotNullOrEmpty() &&
        twitterApiSecretKey.isNotNullOrEmpty() &&
        twitterRedirectURI.isNotNullOrEmpty()) {
      AuthManager().twitterLoginInit(
        newTwLoginData: TwitterInitLoginModel(
          apiKey: twitterApiKey!,
          apiSecretKey: twitterApiSecretKey!,
          redirectURI: twitterRedirectURI!,
        ),
      );
    }
    // Init LinkedIn (Android & iOS)
    if (linkedinClientId.isNotNullOrEmpty() &&
        linkedinClientSecret.isNotNullOrEmpty() &&
        linkedinRedirectUrl.isNotNullOrEmpty()) {
      AuthManager().linkedinLoginInit(
        newLkLoginData: LinkedinInitLoginModel(
          clientId: linkedinClientId!,
          clientSecret: linkedinClientSecret!,
          redirectUrl: linkedinRedirectUrl!,
        ),
      );
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
  BoxDecoration? cardDecoration;
  EdgeInsets? cardInnerPadding;
  String? footerText;
  TextStyle footerTextStyle;
  //* EMAIL
  InputDecoration? emailInputDecoration;
  InputDecoration? passwordInputDecoration;
  TextStyle? emailInputTextStyle;
  TextStyle? passwordInputTextStyle;
  ButtonStyle? emailButtonStyle;
  String? emailButtonText;
  Widget? emailButtonIcon;
  Function(CurrentUserModel)? onResultEmailLogin;
  Function? onErrorEmailLogin;
  //! GOOGLE
  ButtonStyle? googleButtonStyle;
  String? googleButtonText;
  Widget? googleButtonIcon;
  Function(CurrentUserModel)? onResultGoogleLogin;
  Function? onErrorGoogleLogin;
  //? FACEBOOK
  ButtonStyle? facebookButtonStyle;
  String? facebookButtonText;
  Widget? facebookButtonIcon;
  Function(CurrentUserModel)? onResultFacebookLogin;
  Function? onErrorFacebookLogin;
  // TODO: APPLE
  ButtonStyle? appleButtonStyle;
  String? appleButtonText;
  Widget? appleButtonIcon;
  Function(CurrentUserModel)? onResultAppleLogin;
  Function? onErrorAppleLogin;
  //? TWITTER
  ButtonStyle? twitterButtonStyle;
  String? twitterButtonText;
  Widget? twitterButtonIcon;
  Function(CurrentUserModel)? onResultTwitterLogin;
  Function? onErrorTwitterLogin;
  //* MICROSOFT
  ButtonStyle? microsoftButtonStyle;
  String? microsoftButtonText;
  Widget? microsoftButtonIcon;
  Function(CurrentUserModel)? onResultMicrosoftLogin;
  Function? onErrorMicrosoftLogin;
  //? LINKEDIN
  ButtonStyle? linkedinButtonStyle;
  String? linkedinButtonText;
  Widget? linkedinButtonIcon;
  Function(CurrentUserModel)? onResultLinkedinLogin;
  Function? onErrorLinkedinLogin;

  SMultiLoginComponent.simpleCardMode({
    Key? key,
    this.cardDecoration,
    this.cardInnerPadding,
    this.footerText,
    this.footerTextStyle = const TextStyle(
      color: kblack,
      fontSize: 15,
      fontWeight: FontWeight.normal,
    ),
    //* EMAIL
    this.emailInputDecoration,
    this.passwordInputDecoration,
    this.emailInputTextStyle,
    this.passwordInputTextStyle,
    this.emailButtonStyle,
    this.emailButtonText,
    this.emailButtonIcon,
    this.onResultEmailLogin,
    this.onErrorEmailLogin,
    //! GOOGLE
    this.googleButtonStyle,
    this.googleButtonIcon,
    this.onResultGoogleLogin,
    this.onErrorGoogleLogin,
    //? FACEBOOK
    this.facebookButtonStyle,
    this.facebookButtonIcon,
    this.onResultFacebookLogin,
    this.onErrorFacebookLogin,
    // TODO: APPLE
    this.appleButtonStyle,
    this.appleButtonIcon,
    this.onResultAppleLogin,
    this.onErrorAppleLogin,
    //? TWITTER
    this.twitterButtonStyle,
    this.twitterButtonIcon,
    this.onResultTwitterLogin,
    this.onErrorTwitterLogin,
    //* MICROSOFT
    this.microsoftButtonStyle,
    this.microsoftButtonIcon,
    this.onResultMicrosoftLogin,
    this.onErrorMicrosoftLogin,
    //? LINKEDIN
    this.linkedinButtonStyle,
    this.linkedinButtonIcon,
    this.onResultLinkedinLogin,
    this.onErrorLinkedinLogin,
  }) : super(key: key) {
    componentMode = ComponentMode.simpleCardMode;
  }

  SMultiLoginComponent.simpleMode({
    Key? key,
    this.cardDecoration,
    this.cardInnerPadding,
    this.footerText,
    this.footerTextStyle = const TextStyle(
      color: kblack,
      fontSize: 15,
      fontWeight: FontWeight.normal,
    ),
    //* EMAIL
    this.emailInputDecoration,
    this.passwordInputDecoration,
    this.emailInputTextStyle,
    this.passwordInputTextStyle,
    this.emailButtonStyle,
    this.emailButtonText,
    this.emailButtonIcon,
    this.onResultEmailLogin,
    this.onErrorEmailLogin,
    //! GOOGLE
    this.googleButtonStyle,
    this.googleButtonIcon,
    this.onResultGoogleLogin,
    this.onErrorGoogleLogin,
    //? FACEBOOK
    this.facebookButtonStyle,
    this.facebookButtonIcon,
    this.onResultFacebookLogin,
    this.onErrorFacebookLogin,
    // TODO: APPLE
    this.appleButtonStyle,
    this.appleButtonIcon,
    this.onResultAppleLogin,
    this.onErrorAppleLogin,
    //? TWITTER
    this.twitterButtonStyle,
    this.twitterButtonIcon,
    this.onResultTwitterLogin,
    this.onErrorTwitterLogin,
    //* MICROSOFT
    this.microsoftButtonStyle,
    this.microsoftButtonIcon,
    this.onResultMicrosoftLogin,
    this.onErrorMicrosoftLogin,
    //? LINKEDIN
    this.linkedinButtonStyle,
    this.linkedinButtonIcon,
    this.onResultLinkedinLogin,
    this.onErrorLinkedinLogin,
  }) : super(key: key) {
    componentMode = ComponentMode.simpleMode;
  }

  SMultiLoginComponent.complexCardMode({
    Key? key,
    this.cardDecoration,
    this.cardInnerPadding,
    this.footerText,
    this.footerTextStyle = const TextStyle(
      color: kblack,
      fontSize: 15,
      fontWeight: FontWeight.normal,
    ),
    //* EMAIL
    this.emailInputDecoration,
    this.passwordInputDecoration,
    this.emailInputTextStyle,
    this.passwordInputTextStyle,
    this.emailButtonStyle,
    this.emailButtonText,
    this.emailButtonIcon,
    this.onResultEmailLogin,
    this.onErrorEmailLogin,
    //! GOOGLE
    this.googleButtonStyle,
    this.googleButtonText,
    this.googleButtonIcon,
    this.onResultGoogleLogin,
    this.onErrorGoogleLogin,
    //? FACEBOOK
    this.facebookButtonStyle,
    this.facebookButtonText,
    this.facebookButtonIcon,
    this.onResultFacebookLogin,
    this.onErrorFacebookLogin,
    // TODO: APPLE
    this.appleButtonStyle,
    this.appleButtonText,
    this.appleButtonIcon,
    this.onResultAppleLogin,
    this.onErrorAppleLogin,
    //? TWITTER
    this.twitterButtonStyle,
    this.twitterButtonText,
    this.twitterButtonIcon,
    this.onResultTwitterLogin,
    this.onErrorTwitterLogin,
    //* MICROSOFT
    this.microsoftButtonStyle,
    this.microsoftButtonText,
    this.microsoftButtonIcon,
    this.onResultMicrosoftLogin,
    this.onErrorMicrosoftLogin,
    //? LINKEDIN
    this.linkedinButtonStyle,
    this.linkedinButtonText,
    this.linkedinButtonIcon,
    this.onResultLinkedinLogin,
    this.onErrorLinkedinLogin,
  }) : super(key: key) {
    componentMode = ComponentMode.complexCardMode;
  }

  SMultiLoginComponent.complexMode({
    Key? key,
    this.cardDecoration,
    this.cardInnerPadding,
    this.footerText,
    this.footerTextStyle = const TextStyle(
      color: kblack,
      fontSize: 15,
      fontWeight: FontWeight.normal,
    ),
    //* EMAIL
    this.emailInputDecoration,
    this.passwordInputDecoration,
    this.emailInputTextStyle,
    this.passwordInputTextStyle,
    this.emailButtonStyle,
    this.emailButtonText,
    this.emailButtonIcon,
    this.onResultEmailLogin,
    this.onErrorEmailLogin,
    //! GOOGLE
    this.googleButtonStyle,
    this.googleButtonText,
    this.googleButtonIcon,
    this.onResultGoogleLogin,
    this.onErrorGoogleLogin,
    //? FACEBOOK
    this.facebookButtonStyle,
    this.facebookButtonText,
    this.facebookButtonIcon,
    this.onResultFacebookLogin,
    this.onErrorFacebookLogin,
    // TODO: APPLE
    this.appleButtonStyle,
    this.appleButtonText,
    this.appleButtonIcon,
    this.onResultAppleLogin,
    this.onErrorAppleLogin,
    //? TWITTER
    this.twitterButtonStyle,
    this.twitterButtonText,
    this.twitterButtonIcon,
    this.onResultTwitterLogin,
    this.onErrorTwitterLogin,
    //* MICROSOFT
    this.microsoftButtonStyle,
    this.microsoftButtonText,
    this.microsoftButtonIcon,
    this.onResultMicrosoftLogin,
    this.onErrorMicrosoftLogin,
    //? LINKEDIN
    this.linkedinButtonStyle,
    this.linkedinButtonText,
    this.linkedinButtonIcon,
    this.onResultLinkedinLogin,
    this.onErrorLinkedinLogin,
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
              EmailLoginComponent(
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
        // Text before Social Media Login Buttons
        Visibility(
          visible: widget.footerText != null,
          child: Column(
            children: [
              const SizedBox(height: 50),
              Text(
                widget.footerText ?? "O podés ingresar con:",
                style: widget.footerTextStyle,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
        const SizedBox(height: 20),
        // Social Media Login Buttons
        Wrap(
          alignment: WrapAlignment.center,
          spacing: 10,
          runSpacing: 10,
          children: [
            ...(widget.componentMode == ComponentMode.simpleCardMode ||
                    widget.componentMode == ComponentMode.simpleMode)
                ? _getSimpleLoginButtonsList()
                : _getComplexLoginButtonsList()
          ],
        ),
      ],
    );
  }

  _getSimpleLoginButtonsList() {
    List<Widget> buttonsList = [];
    if (widget.onResultGoogleLogin != null) {
      buttonsList.add(
        GoogleBtnComponent.simple(
          googleButtonStyle: widget.googleButtonStyle,
          googleButtonIcon: widget.googleButtonIcon,
          onResultGoogleLogin: widget.onResultGoogleLogin,
          onErrorGoogleLogin: widget.onErrorGoogleLogin,
        ),
      );
    }
    if (widget.onResultFacebookLogin != null) {
      buttonsList.add(
        FacebookBtnComponent.simple(
          facebookButtonStyle: widget.facebookButtonStyle,
          facebookButtonIcon: widget.facebookButtonIcon,
          onResultFacebookLogin: widget.onResultFacebookLogin,
          onErrorFacebookLogin: widget.onErrorFacebookLogin,
        ),
      );
    }
    if (widget.onResultAppleLogin != null && Platform.isIOS) {
      buttonsList.add(
        AppleBtnComponent.simple(
          appleButtonStyle: widget.appleButtonStyle,
          appleButtonIcon: widget.appleButtonIcon,
          onResultAppleLogin: widget.onResultAppleLogin,
          onErrorAppleLogin: widget.onErrorAppleLogin,
        ),
      );
    }
    if (widget.onResultTwitterLogin != null) {
      buttonsList.add(
        TwitterBtnComponent.simple(
          twitterButtonStyle: widget.twitterButtonStyle,
          twitterButtonIcon: widget.twitterButtonIcon,
          onResultTwitterLogin: widget.onResultTwitterLogin,
          onErrorTwitterLogin: widget.onErrorTwitterLogin,
        ),
      );
    }
    if (widget.onResultLinkedinLogin != null) {
      buttonsList.add(
        LinkedinBtnComponent.simple(
          linkedinButtonStyle: widget.linkedinButtonStyle,
          linkedinButtonIcon: widget.linkedinButtonIcon,
          onResultLinkedinLogin: widget.onResultLinkedinLogin,
          onErrorLinkedinLogin: widget.onErrorLinkedinLogin,
        ),
      );
    }
    if (widget.onResultMicrosoftLogin != null) {
      buttonsList.add(
        MicrosoftBtnComponent.simple(
          microsoftButtonStyle: widget.microsoftButtonStyle,
          microsoftButtonIcon: widget.microsoftButtonIcon,
          onResultMicrosoftLogin: widget.onResultMicrosoftLogin,
          onErrorMicrosoftLogin: widget.onErrorMicrosoftLogin,
        ),
      );
    }
    return buttonsList;
  }

  _getComplexLoginButtonsList() {
    List<Widget> buttonsList = [];
    if (widget.onResultGoogleLogin != null) {
      buttonsList.add(
        GoogleBtnComponent.complex(
          googleButtonStyle: widget.googleButtonStyle,
          googleButtonText: widget.googleButtonText,
          googleButtonIcon: widget.googleButtonIcon,
          onResultGoogleLogin: widget.onResultGoogleLogin,
          onErrorGoogleLogin: widget.onErrorGoogleLogin,
        ),
      );
    }
    if (widget.onResultFacebookLogin != null) {
      buttonsList.add(
        FacebookBtnComponent.complex(
          facebookButtonStyle: widget.facebookButtonStyle,
          facebookButtonText: widget.facebookButtonText,
          facebookButtonIcon: widget.facebookButtonIcon,
          onResultFacebookLogin: widget.onResultFacebookLogin,
          onErrorFacebookLogin: widget.onErrorFacebookLogin,
        ),
      );
    }
    if (widget.onResultAppleLogin != null && Platform.isIOS) {
      buttonsList.add(
        AppleBtnComponent.complex(
          appleButtonStyle: widget.appleButtonStyle,
          appleButtonText: widget.appleButtonText,
          appleButtonIcon: widget.appleButtonIcon,
          onResultAppleLogin: widget.onResultAppleLogin,
          onErrorAppleLogin: widget.onErrorAppleLogin,
        ),
      );
    }
    if (widget.onResultTwitterLogin != null) {
      buttonsList.add(
        TwitterBtnComponent.complex(
          twitterButtonStyle: widget.twitterButtonStyle,
          twitterButtonText: widget.twitterButtonText,
          twitterButtonIcon: widget.twitterButtonIcon,
          onResultTwitterLogin: widget.onResultTwitterLogin,
          onErrorTwitterLogin: widget.onErrorTwitterLogin,
        ),
      );
    }
    if (widget.onResultLinkedinLogin != null) {
      buttonsList.add(
        LinkedinBtnComponent.complex(
          linkedinButtonStyle: widget.linkedinButtonStyle,
          linkedinButtonText: widget.linkedinButtonText,
          linkedinButtonIcon: widget.linkedinButtonIcon,
          onResultLinkedinLogin: widget.onResultLinkedinLogin,
          onErrorLinkedinLogin: widget.onErrorLinkedinLogin,
        ),
      );
    }
    if (widget.onResultMicrosoftLogin != null) {
      buttonsList.add(
        MicrosoftBtnComponent.complex(
          microsoftButtonStyle: widget.microsoftButtonStyle,
          microsoftButtonText: widget.microsoftButtonText,
          microsoftButtonIcon: widget.microsoftButtonIcon,
          onResultMicrosoftLogin: widget.onResultMicrosoftLogin,
          onErrorMicrosoftLogin: widget.onErrorMicrosoftLogin,
        ),
      );
    }
    return buttonsList;
  }
}
