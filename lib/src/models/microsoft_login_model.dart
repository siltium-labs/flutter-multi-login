import 'package:flutter/material.dart';

class MicrosoftLoginModel {
  String tenant;
  String clientId;
  String redirectUri;
  GlobalKey<NavigatorState> navigatorKey;

  MicrosoftLoginModel({
    required this.tenant,
    required this.clientId,
    required this.redirectUri,
    required this.navigatorKey,
  });
}
