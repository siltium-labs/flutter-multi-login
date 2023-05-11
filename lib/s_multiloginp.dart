//* Dart imports
import 'dart:io';

//* Flutter imports
import 'package:flutter/material.dart';
import 'package:s_multiloginp/src/components/card_background_component.dart';

//* Project imports
import 'package:s_multiloginp/src/constants/k_colors.dart';
import 'package:s_multiloginp/src/components/button_component.dart';
import 'package:s_multiloginp/src/enums/component_mode_enum.dart';
import 'package:s_multiloginp/src/manager/auth_manager.dart';
import 'package:s_multiloginp/src/utils/loading_popup.dart';
import 'package:s_multiloginp/src/models/current_user_model.dart';

//* Firebase imports
import 'package:firebase_core/firebase_core.dart';

//* Plugin imports
import 's_multiloginp_platform_interface.dart';

//TODO: PLUGIN CLASS (Method Channel)
class SMultiloginp {
  Future<String?> getPlatformVersion() {
    return SMultiloginpPlatform.instance.getPlatformVersion();
  }
}

class SMultiLogin {
  static final SMultiLogin _instance = SMultiLogin._constructor();
  factory SMultiLogin() {
    return _instance;
  }
  SMultiLogin._constructor();

  multiLoginInit(MultiloginOptionsModel options) async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: FirebaseOptions(
        apiKey: options.apiKey,
        appId: options.appId,
        messagingSenderId: options.messagingSenderId,
        projectId: options.projectId,
        authDomain: options.authDomain,
        databaseURL: options.databaseURL,
        storageBucket: options.storageBucket,
        measurementId: options.measurementId,
        // ios specific
        trackingId: options.trackingId,
        deepLinkURLScheme: options.deepLinkURLScheme,
        androidClientId: options.androidClientId,
        iosClientId: options.iosClientId,
        iosBundleId: options.iosBundleId,
        appGroupId: options.appGroupId,
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

class MultiloginOptionsModel {
  String apiKey;
  String appId;
  String messagingSenderId;
  String projectId;
  String? authDomain;
  String? databaseURL;
  String? storageBucket;
  String? measurementId;
  // ios specific
  String? trackingId;
  String? deepLinkURLScheme;
  String? androidClientId;
  String? iosClientId;
  String? iosBundleId;
  String? appGroupId;

  MultiloginOptionsModel({
    required this.apiKey,
    required this.appId,
    required this.messagingSenderId,
    required this.projectId,
    this.authDomain,
    this.databaseURL,
    this.storageBucket,
    this.measurementId,
    // ios specific
    this.trackingId,
    this.deepLinkURLScheme,
    this.androidClientId,
    this.iosClientId,
    this.iosBundleId,
    this.appGroupId,
  });
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
  // Functions
  Function(CurrentUserModel)? onResultEmailLogin;
  Function(CurrentUserModel)? onResultGoogleLogin;
  Function(CurrentUserModel)? onResultFacebookLogin;
  Function(CurrentUserModel)? onResultAppleLogin;
  Function(String)? onErrorEmailLogin;
  Function(String)? onErrorGoogleLogin;
  Function(String)? onErrorFacebookLogin;
  Function(String)? onErrorAppleLogin;

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
  // Initialize TextEditingControllers and variables
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    switch (widget.componentMode) {
      case ComponentMode.simpleCardMode:
        return _cardModeContent();
      case ComponentMode.simpleMode:
        return _simpleModeContent();
      case ComponentMode.complexCardMode:
        return _cardModeContent();
      case ComponentMode.complexMode:
        return _complexModeContent();
      default:
        return _simpleModeContent();
    }
  }

  _cardModeContent() {
    // return Container(
    //   decoration: widget.cardDecoration ??
    //       BoxDecoration(
    //         color: kwhite,
    //         borderRadius: BorderRadius.circular(20),
    //         boxShadow: const [
    //           BoxShadow(
    //             color: Color(0x40666666),
    //             spreadRadius: -3,
    //             blurRadius: 20,
    //             offset: Offset(0, 10),
    //           ),
    //         ],
    //       ),
    //   child: Padding(
    //     padding: widget.cardInnerPadding ?? const EdgeInsets.all(20),
    //     child: widget.componentMode == ComponentMode.simpleCardMode
    //         ? _simpleModeContent()
    //         : _complexModeContent(),
    //   ),
    // );
    return CardBackgroundComponent(
      cardDecoration: widget.cardDecoration,
      cardInnerPadding: widget.cardInnerPadding,
      child: widget.componentMode == ComponentMode.simpleCardMode
          ? _simpleModeContent()
          : _complexModeContent(),
    );
  }

  _simpleModeContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _emailLoginForm(),
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
        Wrap(
          alignment: WrapAlignment.center,
          spacing: 10,
          runSpacing: 10,
          children: [
            ..._getSimpleLoginButtonsList(),
          ],
        ),
      ],
    );
  }

  _complexModeContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _emailLoginForm(),
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
        Wrap(
          alignment: WrapAlignment.center,
          spacing: 10,
          runSpacing: 10,
          children: [
            ..._getComplexLoginButtonsList(),
          ],
        ),
      ],
    );
  }

  _emailLoginForm() {
    return Visibility(
      visible: widget.onResultEmailLogin != null,
      child: Column(
        children: [
          const SizedBox(height: 20),
          TextFormField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            cursorColor: kgrey,
            textInputAction: TextInputAction.next,
            decoration: widget.emailInputDecoration ??
                InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide.none,
                  ),
                  fillColor: kbackground,
                  filled: true,
                  hintStyle: const TextStyle(
                    color: kgrey,
                    fontWeight: FontWeight.w400,
                    fontSize: 13,
                    fontStyle: FontStyle.italic,
                  ),
                  hintText: 'Correo electrónico...',
                ),
            style: widget.emailInputTextStyle ??
                const TextStyle(
                  color: kdarkgrey,
                  fontWeight: FontWeight.w400,
                  fontSize: 13,
                ),
          ),
          const SizedBox(height: 20),
          TextFormField(
            controller: _passwordController,
            cursorColor: kgrey,
            textInputAction: TextInputAction.next,
            obscureText: _obscurePassword,
            obscuringCharacter: "*",
            decoration: widget.passwordInputDecoration ??
                InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide.none,
                  ),
                  fillColor: kbackground,
                  filled: true,
                  hintStyle: const TextStyle(
                    color: kgrey,
                    fontWeight: FontWeight.w400,
                    fontSize: 13,
                    fontStyle: FontStyle.italic,
                  ),
                  hintText: 'Contraseña...',
                  suffixIcon: GestureDetector(
                    onTap: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                    child: Icon(
                      _obscurePassword
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: kgrey,
                      size: 30,
                    ),
                  ),
                ),
            style: widget.passwordInputTextStyle ??
                const TextStyle(
                  color: kdarkgrey,
                  fontWeight: FontWeight.w400,
                  fontSize: 13,
                ),
          ),
          const SizedBox(height: 40),
          _emailLoginButton(),
          const SizedBox(height: 70),
        ],
      ),
    );
  }

  _emailLoginButton() {
    return ButtonComponent(
      onPressed: () => _onEmailLogin(),
      text: widget.emailButtonText ?? "Iniciar Sesión",
      icon: widget.emailButtonIcon,
      buttonStyle: widget.emailButtonStyle ??
          ButtonStyle(
            backgroundColor: const MaterialStatePropertyAll<Color>(kblue),
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

  _getSimpleLoginButtonsList() {
    List<Widget> buttonsList = [];
    if (widget.onResultGoogleLogin != null) {
      buttonsList.add(_simpleGoogleLoginButton());
    }
    if (widget.onResultFacebookLogin != null) {
      buttonsList.add(_simpleFacebookLoginButton());
    }
    if (widget.onResultAppleLogin != null && Platform.isIOS) {
      buttonsList.add(_simpleAppleLoginButton());
    }
    return buttonsList;
  }

  _simpleGoogleLoginButton() {
    return ButtonComponent(
      onPressed: () => _onGoogleLogin(),
      icon: widget.googleButtonIcon ??
          Image.asset(
            "assets/icon_google_default.png",
            package: 's_multiloginp',
            height: 30,
            color: kwhite,
          ),
      buttonStyle: widget.googleButtonStyle ??
          ButtonStyle(
            backgroundColor: const MaterialStatePropertyAll<Color>(kred),
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

  _simpleFacebookLoginButton() {
    return ButtonComponent(
      onPressed: () => _onFacebookLogin(),
      icon: widget.facebookButtonIcon ??
          const Icon(
            Icons.facebook,
            color: kwhite,
            size: 30,
          ),
      buttonStyle: widget.facebookButtonStyle ??
          ButtonStyle(
            backgroundColor: const MaterialStatePropertyAll<Color>(kblue),
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
            backgroundColor: const MaterialStatePropertyAll<Color>(kblack),
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

  _getComplexLoginButtonsList() {
    List<Widget> buttonsList = [];
    if (widget.onResultGoogleLogin != null) {
      buttonsList.add(_complexGoogleLoginButton());
    }
    if (widget.onResultFacebookLogin != null) {
      buttonsList.add(_complexFacebookLoginButton());
    }
    if (widget.onResultAppleLogin != null && Platform.isIOS) {
      buttonsList.add(_complexAppleLoginButton());
    }
    return buttonsList;
  }

  _complexGoogleLoginButton() {
    return ButtonComponent(
      onPressed: () => _onGoogleLogin(),
      text: widget.googleButtonText ?? "Sing In with Google",
      icon: widget.googleButtonIcon ??
          Image.asset(
            "assets/icon_google_default.png",
            package: 's_multiloginp',
            height: 30,
          ),
      buttonStyle: widget.googleButtonStyle ??
          ButtonStyle(
            backgroundColor: const MaterialStatePropertyAll<Color>(kred),
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

  _complexFacebookLoginButton() {
    return ButtonComponent(
      onPressed: () => _onFacebookLogin(),
      text: widget.facebookButtonText ?? "Sing In with Facebook",
      icon: widget.facebookButtonIcon ??
          const Icon(
            Icons.facebook,
            color: kwhite,
            size: 30,
          ),
      buttonStyle: widget.facebookButtonStyle ??
          ButtonStyle(
            backgroundColor: const MaterialStatePropertyAll<Color>(kblue),
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

  _complexAppleLoginButton() {
    return ButtonComponent(
      onPressed: () => _onAppleLogin(),
      text: widget.appleButtonText ?? "Sing In with Apple",
      icon: widget.appleButtonIcon ??
          const Icon(
            Icons.apple,
            color: kwhite,
            size: 30,
          ),
      buttonStyle: widget.appleButtonStyle ??
          ButtonStyle(
            backgroundColor: const MaterialStatePropertyAll<Color>(kblack),
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

  //CONTROLLER----------------------------------------------------
  //*EMAIL
  _onEmailLogin() async {
    await LoadingPopup(
      context: context,
      onLoading: _onEmailLoading(),
      onResult: (data) => _onEmailResult(data),
      onError: (error) => _onEmailError(error),
    ).show();
  }

  _onEmailLoading() async {
    await AuthManager().signInEmailAndPassword(
        email: _emailController.text, password: _passwordController.text);
    return _getUserCredential();
  }

  _onEmailResult(CurrentUserModel data) async {
    if (data.token != null) {
      if (widget.onResultEmailLogin != null) {
        _emailController.clear();
        _passwordController.clear();
        widget.onResultEmailLogin!(data);
      } else {
        debugPrint("Null result EmailLogin");
      }
    } else {
      debugPrint("Error on EmailLogin");
    }
  }

  _onEmailError(String error) {
    if (widget.onErrorEmailLogin != null) {
      widget.onErrorEmailLogin!(error);
    } else {
      debugPrint("El error fue: $error");
    }
  }

  //!GOOGLE
  _onGoogleLogin() async {
    await LoadingPopup(
      context: context,
      onLoading: _onGoogleLoading(),
      onResult: (data) => _onGoogleResult(data),
      onError: (error) => _onGoogleError(error),
    ).show();
  }

  _onGoogleLoading() async {
    await AuthManager().signInWithGoogle();
    return _getUserCredential();
  }

  _onGoogleResult(CurrentUserModel data) async {
    if (data.token != null) {
      if (widget.onResultGoogleLogin != null) {
        _emailController.clear();
        _passwordController.clear();
        widget.onResultGoogleLogin!(data);
      } else {
        debugPrint("Null result GoogleLogin");
      }
    } else {
      debugPrint("Error on GoogleLogin");
    }
  }

  _onGoogleError(String error) {
    if (widget.onErrorGoogleLogin != null) {
      widget.onErrorGoogleLogin!(error);
    } else {
      debugPrint("El error fue: $error");
    }
  }

  //?FACEBOOK
  _onFacebookLogin() async {
    await LoadingPopup(
      context: context,
      onLoading: _onFacebookLoading(),
      onResult: (data) => _onFacebookResult(data),
      onError: (error) => _onFacebookError(error),
    ).show();
  }

  _onFacebookLoading() async {
    await AuthManager().signInWithFacebook();
    return _getUserCredential();
  }

  _onFacebookResult(CurrentUserModel data) async {
    if (data.token != null) {
      if (widget.onResultFacebookLogin != null) {
        _emailController.clear();
        _passwordController.clear();
        widget.onResultFacebookLogin!(data);
      } else {
        debugPrint("Null result FacebookLogin");
      }
    } else {
      debugPrint("Error on FacebookLogin");
    }
  }

  _onFacebookError(String error) {
    if (widget.onErrorFacebookLogin != null) {
      widget.onErrorFacebookLogin!(error);
    } else {
      debugPrint("El error fue: $error");
    }
  }

  //TODO: APPLE
  _onAppleLogin() async {
    await LoadingPopup(
      context: context,
      onLoading: _onAppleLoading(),
      onResult: (data) => _onAppleResult(data),
      onError: (error) => _onAppleError(error),
    ).show();
  }

  _onAppleLoading() async {
    await AuthManager().signInWithApple();
    return _getUserCredential();
  }

  _onAppleResult(CurrentUserModel data) {
    debugPrint("Apple login");
  }
  // _onAppleResult(GetUserCredentialModel data) async {
  //   if (data.token != null) {
  //     if (widget.onResultAppleLogin != null) {
  //       _emailController!.clear();
  //       _passwordController!.clear();
  //       widget.onResultAppleLogin!(data);
  //     } else {
  //       debugPrint("Null result AppleLogin");
  //     }
  //   } else {
  //     debugPrint("Error on AppleLogin");
  //   }
  // }

  _onAppleError(String error) {
    if (widget.onErrorAppleLogin != null) {
      widget.onErrorAppleLogin!(error);
    } else {
      debugPrint("El error fue: $error");
    }
  }

  //OTROS
  Future<CurrentUserModel> _getUserCredential() {
    return AuthManager().getUserCredential();
  }
}
