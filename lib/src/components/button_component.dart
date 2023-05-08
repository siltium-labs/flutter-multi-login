//* Flutter imports
import 'package:flutter/material.dart';

//* Project imports
import 'package:s_multiloginp/src/constants/k_colors.dart';

class ButtonComponent extends StatefulWidget {
  final String? text;
  final Widget? icon;
  final ButtonStyle? buttonStyle;
  final VoidCallback onPressed;

  const ButtonComponent({
    Key? key,
    this.text,
    this.icon,
    this.buttonStyle,
    required this.onPressed,
  }) : super(key: key);

  @override
  ButtonComponentState createState() => ButtonComponentState();
}

class ButtonComponentState extends State<ButtonComponent> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => widget.onPressed(),
      style: widget.buttonStyle ?? _defaultButtonStyle(),
      child: _content(),
    );
  }

  _content() {
    if (widget.icon != null && widget.text != null && widget.text!.isNotEmpty) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Flexible(
            flex: 1,
            child: widget.icon!,
          ),
          const SizedBox(width: 10),
          Flexible(
            flex: 3,
            child: FittedBox(
              child: Text(
                widget.text!,
              ),
            ),
          )
        ],
      );
    } else if (widget.text != null && widget.text!.isNotEmpty) {
      return FittedBox(
        child: Text(
          widget.text!,
        ),
      );
    } else if (widget.icon != null) {
      return widget.icon;
    } else {
      return const SizedBox.shrink();
    }
  }

  _defaultButtonStyle() {
    return ButtonStyle(
      backgroundColor: const MaterialStatePropertyAll<Color>(kblue),
      maximumSize: const MaterialStatePropertyAll<Size>(
        Size(double.infinity, 100),
      ),
      minimumSize: const MaterialStatePropertyAll<Size>(
        Size(100, 40),
      ),
      shape: MaterialStatePropertyAll<OutlinedBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
      ),
    );
  }
}
