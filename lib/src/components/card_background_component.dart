//* Flutter imports
import 'package:flutter/cupertino.dart';

//* Project imports
import 'package:s_multiloginp/src/constants/k_colors.dart';

class CardBackgroundComponent extends StatefulWidget {
  final BoxDecoration? cardDecoration;
  final EdgeInsets? cardInnerPadding;
  final Widget child;

  const CardBackgroundComponent({
    Key? key,
    required this.cardDecoration,
    required this.cardInnerPadding,
    required this.child,
  }) : super(key: key);

  @override
  CardBackgroundComponentState createState() => CardBackgroundComponentState();
}

class CardBackgroundComponentState extends State<CardBackgroundComponent> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: widget.cardDecoration ??
          BoxDecoration(
            color: kwhite,
            borderRadius: BorderRadius.circular(20),
            boxShadow: const [
              BoxShadow(
                color: Color(0x40666666),
                spreadRadius: -3,
                blurRadius: 20,
                offset: Offset(0, 10),
              ),
            ],
          ),
      child: Padding(
        padding: widget.cardInnerPadding ?? const EdgeInsets.all(20),
        child: widget.child,
      ),
    );
  }
}
