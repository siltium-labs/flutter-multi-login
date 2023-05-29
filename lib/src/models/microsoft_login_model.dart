import 'package:flutter/material.dart';

class MicrosoftLoginModel {
  String tenant;
  String clientId;
  // String clientSecret;
  String redirectUri;
  GlobalKey<NavigatorState> navigatorKey;

  MicrosoftLoginModel({
    required this.tenant,
    required this.clientId,
    // required this.clientSecret,
    required this.redirectUri,
    required this.navigatorKey,
  });
}
