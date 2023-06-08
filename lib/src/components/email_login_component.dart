//* Flutter imports
import 'package:flutter/material.dart';

//* Project imports
import 'package:s_multiloginp/src/constants/k_colors.dart';
import 'package:s_multiloginp/src/models/current_user_model.dart';
import 'package:s_multiloginp/src/components/button_component.dart';
import 'package:s_multiloginp/src/controllers/login_controller.dart';

// ignore: must_be_immutable
class EmailLoginComponent extends StatefulWidget {
  // Custom style parameters
  final InputDecoration? emailInputDecoration;
  final TextStyle? emailInputTextStyle;
  final InputDecoration? passwordInputDecoration;
  final TextStyle? passwordInputTextStyle;
  final ButtonStyle? emailButtonStyle;
  final String? emailButtonText;
  final Widget? emailButtonIcon;
  // Functions
  Function(CurrentUserModel)? onResultEmailLogin;
  Function? onErrorEmailLogin;
  // Loading custom color
  final Color? backgroundColor;
  final Color? loadingColor;

  EmailLoginComponent({
    Key? key,
    // Custom style parameters
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
    // Loading custom color
    this.backgroundColor,
    this.loadingColor,
  }) : super(key: key);

  @override
  EmailLoginComponentState createState() => EmailLoginComponentState();
}

class EmailLoginComponentState extends State<EmailLoginComponent> {
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
      onPressed: () => LoginController().onEmailLogin(
        context: context,
        email: _emailController,
        password: _passwordController,
        onResultEmailLogin: widget.onResultEmailLogin,
        onErrorEmailLogin: widget.onErrorEmailLogin,
        backgroundColor: widget.backgroundColor,
        loadingColor: widget.loadingColor,
      ),
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
}
