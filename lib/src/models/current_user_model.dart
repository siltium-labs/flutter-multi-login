class CurrentUserModel {
  String? fbUserId;
  String? appleUserId;
  String? displayName;
  String? email;
  String? phoneNumber;
  String? photoURL;
  String? token;
  String? refreshToken;
  String? accessToken;
  String? providerId;

  CurrentUserModel({
    this.fbUserId,
    this.appleUserId,
    this.displayName,
    this.email,
    this.phoneNumber,
    this.photoURL,
    this.token,
    this.refreshToken,
    this.accessToken,
    this.providerId,
  });
}
