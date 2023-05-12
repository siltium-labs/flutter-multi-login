class SMultiloginOptionsModel {
  String apiKey;
  String appId;
  String messagingSenderId;
  String projectId;
  String? authDomain;
  String? databaseURL;
  String? storageBucket;
  String? measurementId;
  // ios specific
  String? trackingId;
  String? deepLinkURLScheme;
  String? androidClientId;
  String? iosClientId;
  String? iosBundleId;
  String? appGroupId;

  SMultiloginOptionsModel({
    required this.apiKey,
    required this.appId,
    required this.messagingSenderId,
    required this.projectId,
    this.authDomain,
    this.databaseURL,
    this.storageBucket,
    this.measurementId,
    // ios specific
    this.trackingId,
    this.deepLinkURLScheme,
    this.androidClientId,
    this.iosClientId,
    this.iosBundleId,
    this.appGroupId,
  });
}
