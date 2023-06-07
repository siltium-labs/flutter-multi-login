//* Dart imports
import 'dart:io';

//* Flutter imports
import 'package:flutter/material.dart';

//* Package/Firebase imports
import 'package:firebase_core/firebase_core.dart';

//* Project imports
import 'package:s_multiloginp/src/components/email_login_component.dart';
import 'package:s_multiloginp/src/components/social_media_buttons/google_btn_component.dart';
import 'package:s_multiloginp/src/components/social_media_buttons/facebook_btn_component.dart';
import 'package:s_multiloginp/src/components/social_media_buttons/apple_btn_component.dart';
import 'package:s_multiloginp/src/components/social_media_buttons/twitter_btn_component.dart';
import 'package:s_multiloginp/src/components/social_media_buttons/microsoft_btn_component.dart';
import 'package:s_multiloginp/src/components/social_media_buttons/linkedin_btn_component.dart';
import 'package:s_multiloginp/src/controllers/email_login_controller.dart';
import 'package:s_multiloginp/src/enums/component_mode_enum.dart';
import 'package:s_multiloginp/src/enums/component_type_enum.dart';
import 'package:s_multiloginp/src/manager/auth_manager.dart';
import 'package:s_multiloginp/src/models/current_user_model.dart';
import 'package:s_multiloginp/src/models/linkedin_init_login_model.dart';
import 'package:s_multiloginp/src/models/twitter_init_login_model.dart';
import 'package:s_multiloginp/src/utils/extensions.dart';

//* Plugin exports
export 'package:s_multiloginp/src/models/current_user_model.dart';

// Plugin class (with Method Channel)
import 's_multiloginp_platform_interface.dart';

Color? _backgroundLoadingColor;
Color? _circleLoadingColor;

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

  emailLogin({
    required BuildContext context,
    required String email,
    required String password,
    Function(CurrentUserModel)? onResultEmailLogin,
    Function? onErrorEmailLogin,
  }) async {
    await EmailLoginController().onEmailLogin(
      context: context,
      email: email,
      password: password,
      onResultEmailLogin: onResultEmailLogin,
      onErrorEmailLogin: onErrorEmailLogin,
      backgroundColor: _backgroundLoadingColor,
      loadingColor: _circleLoadingColor,
    );
  }

  // Init design
  customLoadingColor(Color backgroundColor, Color loadingColor) {
    _backgroundLoadingColor = backgroundColor;
    _circleLoadingColor = loadingColor;
  }
}

// ignore: must_be_immutable
class SMultiLoginComponent extends StatefulWidget {
  late ComponentTypeEnum componentType;
  late ComponentModeEnum componentMode;
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
  //? FACEBOOK
  ButtonStyle? facebookButtonStyle;
  String? facebookButtonText;
  Widget? facebookButtonIcon;
  Function(CurrentUserModel)? onResultFacebookLogin;
  Function? onErrorFacebookLogin;
  //! GOOGLE
  ButtonStyle? googleButtonStyle;
  String? googleButtonText;
  Widget? googleButtonIcon;
  Function(CurrentUserModel)? onResultGoogleLogin;
  Function? onErrorGoogleLogin;
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

  SMultiLoginComponent.emailLogin({
    Key? key,
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
  }) : super(key: key) {
    componentType = ComponentTypeEnum.emailLogin;
    componentMode = ComponentModeEnum.simpleMode;
  }

  SMultiLoginComponent.socialMediaLogin({
    Key? key,
    //? FACEBOOK
    this.facebookButtonStyle,
    this.facebookButtonIcon,
    this.onResultFacebookLogin,
    this.onErrorFacebookLogin,
    //! GOOGLE
    this.googleButtonStyle,
    this.googleButtonIcon,
    this.onResultGoogleLogin,
    this.onErrorGoogleLogin,
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
    componentType = ComponentTypeEnum.socialMediaLogin;
    componentMode = ComponentModeEnum.simpleMode;
  }

  SMultiLoginComponent.socialMediaLoginComplex({
    Key? key,
    //? FACEBOOK
    this.facebookButtonStyle,
    this.facebookButtonText,
    this.facebookButtonIcon,
    this.onResultFacebookLogin,
    this.onErrorFacebookLogin,
    //! GOOGLE
    this.googleButtonStyle,
    this.googleButtonText,
    this.googleButtonIcon,
    this.onResultGoogleLogin,
    this.onErrorGoogleLogin,
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
    componentType = ComponentTypeEnum.socialMediaLogin;
    componentMode = ComponentModeEnum.complexMode;
  }

  @override
  SMultiLoginComponentState createState() => SMultiLoginComponentState();
}

class SMultiLoginComponentState extends State<SMultiLoginComponent> {
  @override
  Widget build(BuildContext context) {
    switch (widget.componentType) {
      case ComponentTypeEnum.emailLogin:
        return _emailComponent();
      case ComponentTypeEnum.socialMediaLogin:
        return _socialMediaComponent();
      default:
        return _emailComponent();
    }
  }

  _emailComponent() {
    return EmailLoginComponent(
      emailInputDecoration: widget.emailInputDecoration,
      emailInputTextStyle: widget.emailInputTextStyle,
      passwordInputDecoration: widget.passwordInputDecoration,
      passwordInputTextStyle: widget.passwordInputTextStyle,
      emailButtonStyle: widget.emailButtonStyle,
      emailButtonText: widget.emailButtonText,
      emailButtonIcon: widget.emailButtonIcon,
      onResultEmailLogin: widget.onResultEmailLogin,
      onErrorEmailLogin: widget.onErrorEmailLogin,
      backgroundColor: _backgroundLoadingColor,
      loadingColor: _circleLoadingColor,
    );
  }

  _socialMediaComponent() {
    return Wrap(
      alignment: WrapAlignment.center,
      spacing: 10,
      runSpacing: 10,
      children: [
        ...(widget.componentMode == ComponentModeEnum.simpleMode)
            ? _getSimpleLoginButtonsList()
            : _getComplexLoginButtonsList()
      ],
    );
  }

  _getSimpleLoginButtonsList() {
    List<Widget> buttonsList = [];
    if (widget.onResultFacebookLogin != null) {
      buttonsList.add(
        FacebookBtnComponent.simple(
          facebookButtonStyle: widget.facebookButtonStyle,
          facebookButtonIcon: widget.facebookButtonIcon,
          onResultFacebookLogin: widget.onResultFacebookLogin,
          onErrorFacebookLogin: widget.onErrorFacebookLogin,
          backgroundColor: _backgroundLoadingColor,
          loadingColor: _circleLoadingColor,
        ),
      );
    }
    if (widget.onResultGoogleLogin != null) {
      buttonsList.add(
        GoogleBtnComponent.simple(
          googleButtonStyle: widget.googleButtonStyle,
          googleButtonIcon: widget.googleButtonIcon,
          onResultGoogleLogin: widget.onResultGoogleLogin,
          onErrorGoogleLogin: widget.onErrorGoogleLogin,
          backgroundColor: _backgroundLoadingColor,
          loadingColor: _circleLoadingColor,
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
          backgroundColor: _backgroundLoadingColor,
          loadingColor: _circleLoadingColor,
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
          backgroundColor: _backgroundLoadingColor,
          loadingColor: _circleLoadingColor,
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
          backgroundColor: _backgroundLoadingColor,
          loadingColor: _circleLoadingColor,
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
          backgroundColor: _backgroundLoadingColor,
          loadingColor: _circleLoadingColor,
        ),
      );
    }
    return buttonsList;
  }

  _getComplexLoginButtonsList() {
    List<Widget> buttonsList = [];
    if (widget.onResultFacebookLogin != null) {
      buttonsList.add(
        FacebookBtnComponent.complex(
          facebookButtonStyle: widget.facebookButtonStyle,
          facebookButtonText: widget.facebookButtonText,
          facebookButtonIcon: widget.facebookButtonIcon,
          onResultFacebookLogin: widget.onResultFacebookLogin,
          onErrorFacebookLogin: widget.onErrorFacebookLogin,
          backgroundColor: _backgroundLoadingColor,
          loadingColor: _circleLoadingColor,
        ),
      );
    }
    if (widget.onResultGoogleLogin != null) {
      buttonsList.add(
        GoogleBtnComponent.complex(
          googleButtonStyle: widget.googleButtonStyle,
          googleButtonText: widget.googleButtonText,
          googleButtonIcon: widget.googleButtonIcon,
          onResultGoogleLogin: widget.onResultGoogleLogin,
          onErrorGoogleLogin: widget.onErrorGoogleLogin,
          backgroundColor: _backgroundLoadingColor,
          loadingColor: _circleLoadingColor,
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
          backgroundColor: _backgroundLoadingColor,
          loadingColor: _circleLoadingColor,
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
          backgroundColor: _backgroundLoadingColor,
          loadingColor: _circleLoadingColor,
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
          backgroundColor: _backgroundLoadingColor,
          loadingColor: _circleLoadingColor,
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
          backgroundColor: _backgroundLoadingColor,
          loadingColor: _circleLoadingColor,
        ),
      );
    }
    return buttonsList;
  }
}
