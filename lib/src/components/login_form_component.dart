//* Flutter imports
import 'package:flutter/material.dart';

//* Project imports
import 'package:s_multiloginp/src/constants/k_colors.dart';
import 'package:s_multiloginp/src/manager/auth_manager.dart';
import 'package:s_multiloginp/src/models/current_user_model.dart';
import 'package:s_multiloginp/src/utils/loading_popup.dart';
import 'package:s_multiloginp/src/components/button_component.dart';

// ignore: must_be_immutable
class LoginFormComponent extends StatefulWidget {
  // Styles
  final InputDecoration? emailInputDecoration;
  final TextStyle? emailInputTextStyle;
  final InputDecoration? passwordInputDecoration;
  final TextStyle? passwordInputTextStyle;
  final ButtonStyle? emailButtonStyle;
  final String? emailButtonText;
  final Widget? emailButtonIcon;
  // Functions
  Function(CurrentUserModel)? onResultEmailLogin;
  Function(String)? onErrorEmailLogin;

  LoginFormComponent({
    Key? key,
    // Styles
    required this.emailInputDecoration,
    required this.emailInputTextStyle,
    required this.passwordInputDecoration,
    required this.passwordInputTextStyle,
    required this.emailButtonStyle,
    required this.emailButtonText,
    required this.emailButtonIcon,
    // Functions
    required this.onResultEmailLogin,
    required this.onErrorEmailLogin,
  }) : super(key: key);

  @override
  LoginFormComponentState createState() => LoginFormComponentState();
}

class LoginFormComponentState extends State<LoginFormComponent> {
  // Initialize TextEditingControllers and variables
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _emailInput(),
        const SizedBox(height: 20),
        _passwordInput(),
        const SizedBox(height: 40),
        _emailLoginButton(),
        const SizedBox(height: 70),
      ],
    );
  }

  _emailInput() {
    return TextFormField(
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
    );
  }

  _passwordInput() {
    return TextFormField(
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
                _obscurePassword ? Icons.visibility : Icons.visibility_off,
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

  //CONTROLLER----------------------------------------------------
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
      email: _emailController.text,
      password: _passwordController.text,
    );
    return AuthManager().getUserCredential();
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
}
