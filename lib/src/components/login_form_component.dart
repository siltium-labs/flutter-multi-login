//* Flutter imports
import 'package:flutter/material.dart';
import 'package:s_multiloginp/src/components/button_component.dart';

//* Project imports
import 'package:s_multiloginp/src/constants/k_colors.dart';
import 'package:s_multiloginp/src/manager/auth_manager.dart';
import 'package:s_multiloginp/src/models/current_user_model.dart';
import 'package:s_multiloginp/src/utils/loading_popup.dart';

// ignore: must_be_immutable
class LoginFormComponent extends StatefulWidget {
  final TextEditingController emailController;
  final InputDecoration? emailInputDecoration;
  final TextStyle? emailInputTextStyle;
  final TextEditingController passwordController;
  final InputDecoration? passwordInputDecoration;
  final TextStyle? passwordInputTextStyle;
  final ButtonStyle? emailButtonStyle;
  final String? emailButtonText;
  final Widget? emailButtonIcon;
  Function(CurrentUserModel)? onResultEmailLogin;
  Function(String)? onErrorEmailLogin;

  LoginFormComponent({
    Key? key,
    required this.emailController,
    required this.emailInputDecoration,
    required this.emailInputTextStyle,
    required this.passwordController,
    required this.passwordInputDecoration,
    required this.passwordInputTextStyle,
    required this.emailButtonStyle,
    required this.emailButtonText,
    required this.emailButtonIcon,
    required this.onResultEmailLogin,
    required this.onErrorEmailLogin,
  }) : super(key: key);

  @override
  LoginFormComponentState createState() => LoginFormComponentState();
}

class LoginFormComponentState extends State<LoginFormComponent> {
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          controller: widget.emailController,
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
          controller: widget.passwordController,
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
        ),
        const SizedBox(height: 40),
        _emailLoginButton(),
        const SizedBox(height: 70),
      ],
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
  // //*EMAIL
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
        email: widget.emailController.text,
        password: widget.passwordController.text);
    return AuthManager().getUserCredential(); //_getUserCredential();
  }

  _onEmailResult(CurrentUserModel data) async {
    if (data.token != null) {
      if (widget.onResultEmailLogin != null) {
        widget.emailController.clear();
        widget.passwordController.clear();
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
