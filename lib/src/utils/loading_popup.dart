//* Flutter imports
import 'package:flutter/material.dart';

//* Project imports
import 'package:s_multiloginp/src/utils/futuristic.dart';
import 'package:s_multiloginp/src/utils/loading_component.dart';
import 'package:s_multiloginp/src/constants/k_colors.dart';

class LoadingPopup {
  final BuildContext context;
  final Color backgroundColor;
  final Color loadingColor;
  final Future onLoading;
  Function? onResult;
  Function? onError;

  LoadingPopup({
    required this.context,
    required this.onLoading,
    this.onResult,
    this.onError,
    this.backgroundColor = kblue,
    this.loadingColor = kwhite,
  });

  final double radius = 20;

  Future show() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return _dialog();
        });
  }

  _dialog() {
    return Futuristic(
      autoStart: true,
      futureBuilder: () => onLoading,
      busyBuilder: (context) => body(),
      onData: (data) {
        Navigator.pop(context);
        onResult!(data);
      },
      onError: (error, retry) {
        Navigator.pop(context);
        onError!(error);
      },
    );
  }

  body() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            backgroundColor.withOpacity(0.5),
            // backgroundColor.withOpacity(0.5),
          ],
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          loadingComponent(
            true,
            color: loadingColor,
            size: 50,
          ),
        ],
      ),
    );
  }
}
