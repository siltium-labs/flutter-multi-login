//* Package imports
import 'package:firebase_auth/firebase_auth.dart';

//* Project imports
import 'package:s_multiloginp/s_multiloginp.dart';
import 'package:s_multiloginp/src/models/current_user_model.dart';
import 'package:s_multiloginp/src/manager/apple_login_manager.dart';
import 'package:s_multiloginp/src/manager/facebook_login_manager.dart';
import 'package:s_multiloginp/src/manager/google_login_manager.dart';
import 'package:s_multiloginp/twitter_login_model.dart';
import 'package:s_multiloginp/src/manager/linkedin_login_manager.dart';
import 'package:s_multiloginp/src/manager/twitter_login_manager.dart';

class AuthManager {
  static final AuthManager _instance = AuthManager._constructor();
  factory AuthManager() {
    return _instance;
  }
  AuthManager._constructor();

  // Variables
  final FirebaseAuth _auth = FirebaseAuth.instance;
  UserCredential? user;
  CurrentUserModel? userCredential;
  // Variales init social media
  String? googleIOSClientId;
  TwitterLoginModel? twitterLoginData;
  LinkedinLoginModel? linkedinLoginData;

  //* EMAIL
  Future<UserCredential?> signInEmailAndPassword(
      {required String email, required String password}) async {
    try {
      user = await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
      return user;
    } on FirebaseAuthException catch (e) {
      await onFirebaseAuthException(error: e, inputEmail: email);
      return null;
    }
  }

  //! GOOGLE
  Future<UserCredential?> signInWithGoogle() async {
    try {
      OAuthCredential googleOAuthCredential =
          await GoogleLoginManager().googleLogin(googleIOSClientId);
      return user = await _auth.signInWithCredential(googleOAuthCredential);
    } on FirebaseAuthException catch (e) {
      await onFirebaseAuthException(error: e);
      return null;
    }
  }

  //? FACEBOOK
  Future<UserCredential?> signInWithFacebook() async {
    try {
      OAuthCredential facebookOAuthCredential =
          await FacebookLoginManager().facebookLogin();
      return user = await _auth.signInWithCredential(facebookOAuthCredential);
    } on FirebaseAuthException catch (e) {
      await onFirebaseAuthException(error: e);
      return null;
    }
  }

  //TODO: APPLE (para ios)
  Future<UserCredential?> signInWithApple() async {
    try {
      OAuthCredential appleOAuthCredential =
          await AppleLoginManager().appleLogin();
      return user = await _auth.signInWithCredential(appleOAuthCredential);
    } on FirebaseAuthException catch (e) {
      await onFirebaseAuthException(error: e);
      return null;
    }
  }

  //? TWITTER
  Future<UserCredential?> singInWithTwitter() async {
    try {
      OAuthCredential twitterOAuthCredential = await TwitterLoginManager().twitterLogin(twitterLoginData);
      return user = await _auth.signInWithCredential(twitterOAuthCredential);
    } on FirebaseAuthException catch (e) {
      await onFirebaseAuthException(error: e);
      return null;
    }
  }

  //? LINKEDIN
  Future<UserCredential?> singInWithLinkedin() async {
    try {
      // OAuthCredential linkedinOAuthCredential = await LinkedinLoginManager().linkedinLogin(linkedinLoginData);
      // return user = await _auth.signInWithCredential(linkedinOAuthCredential);
      String token = await LinkedinLoginManager().linkedinLogin(linkedinLoginData);
      return user = await _auth.signInWithCustomToken(token);
    } on FirebaseAuthException catch (e) {
      await onFirebaseAuthException(error: e);
      return null;
    }
  }

  // OTROS
  Future<CurrentUserModel> getUserCredential() async {
    return userCredential = CurrentUserModel(
      token: await user?.user?.getIdToken(),
    );
  }

  Future<void> onFirebaseAuthException(
      {required FirebaseAuthException error, String? inputEmail}) async {
    switch (error.code) {
      default:
        throw Exception(error.message);
    }
  }

  onLogOut() async {
    // Firebase Logout
    await _auth.signOut();
    // Social Media Logouts
    GoogleLoginManager().googleLogout();
    FacebookLoginManager().facebookLogout();
    //TODO: Apple().logout();
    // AuthManager Logout
    user = null;
    userCredential = null;
  }

  String getUserData() {
    return user!.user!.email ?? (user!.user!.displayName ?? "No hay datos");
  }

  googleLoginInit(String? iOSClientId){
    googleIOSClientId = iOSClientId;
  }

  twitterLoginInit({TwitterLoginModel? newTwLoginData}){
    twitterLoginData = newTwLoginData;
  }

  linkedinLoginInit({LinkedinLoginModel? newLkLoginData}){
    linkedinLoginData = newLkLoginData;
  }
}
