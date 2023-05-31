//* Packages imports
import 'package:firebase_core/firebase_core.dart';

//* Project imports
import 'package:s_multiloginp/src/models/linkedin_login_model.dart';
import 'package:s_multiloginp/src/models/twitter_login_model.dart';

class MultiLoginInitModel {
  FirebaseOptions options;
  String? googleIOSClientId;
  TwitterLoginModel? twitterInitData;
  LinkedinLoginModel? linkedinInitData;

  MultiLoginInitModel({
    required this.options,
    this.googleIOSClientId,
    this.twitterInitData,
    this.linkedinInitData,
  });
}