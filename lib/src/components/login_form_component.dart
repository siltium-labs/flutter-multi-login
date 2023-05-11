//* Flutter imports
import 'package:flutter/material.dart';

//* Project imports
import 'package:s_multiloginp/src/constants/k_colors.dart';

class LoginFormComponent extends StatefulWidget {
  final InputDecoration? emailInputDecoration;
  final TextStyle? emailInputTextStyle;
  final TextEditingController emailController;
  final InputDecoration? passwordInputDecoration;
  final TextStyle? passwordInputTextStyle;
  final TextEditingController passwordController;
  

  const LoginFormComponent({
    Key? key,
    required this.emailController,
    required this.emailInputDecoration,
    required this.emailInputTextStyle,
    required this.passwordController,
    required this.passwordInputDecoration,
    required this.passwordInputTextStyle,
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
        ],
      );
  }
}
