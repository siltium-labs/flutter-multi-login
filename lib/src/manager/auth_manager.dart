//* Package imports
import 'package:firebase_auth/firebase_auth.dart';

//* Project imports
import 'package:s_multiloginp/s_multiloginp.dart';
import 'package:s_multiloginp/src/manager/google_login_manager.dart';
import 'package:s_multiloginp/src/manager/facebook_login_manager.dart';
import 'package:s_multiloginp/src/manager/apple_login_manager.dart';
import 'package:s_multiloginp/src/manager/twitter_login_manager.dart';
import 'package:s_multiloginp/src/models/current_user_model.dart';
import 'package:s_multiloginp/src/models/twitter_login_model.dart';

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

  // Variales inits social media
  String? googleIOSClientId;
  TwitterLoginModel? twitterLoginData;
  LinkedinLoginModel? linkedinLoginData;

  // Inits social media
  googleLoginInit(String? iOSClientId) {
    googleIOSClientId = iOSClientId;
  }

  twitterLoginInit({TwitterLoginModel? newTwLoginData}) {
    twitterLoginData = newTwLoginData;
  }

  linkedinLoginInit({LinkedinLoginModel? newLkLoginData}) {
    linkedinLoginData = newLkLoginData;
  }

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
      OAuthCredential twitterOAuthCredential =
          await TwitterLoginManager().twitterLogin(twitterLoginData);
      return user = await _auth.signInWithCredential(twitterOAuthCredential);
    } on FirebaseAuthException catch (e) {
      await onFirebaseAuthException(error: e);
      return null;
    }
  }

  //? LINKEDIN
  // Manejado, por ahora, en el widget de la libreria

  // OTROS
  Future<void> onFirebaseAuthException(
      {required FirebaseAuthException error, String? inputEmail}) async {
    switch (error.code) {
      default:
        throw Exception(error.message);
    }
  }

  Future<CurrentUserModel> getUserCredential(
      {CurrentUserModel? currentUser}) async {
    //TODO: Cambiar logica para guardar todo en el modelo de currentUser y devolver dicho modelo
    if (user != null && user!.user != null) {
      return userCredential = CurrentUserModel(
        token: await user!.user!.getIdToken(),
      );
    } else {
      return userCredential = CurrentUserModel(
        token: currentUser?.token,
      );
    }
  }

  String getUserData() {
    if (user != null && user!.user != null) {
      return user!.user!.email ??
          (user!.user!.displayName ?? "No email or name data");
    } else {
      return "No user data";
    }
  }

  onLogOut() async {
    // Firebase Logout
    await _auth.signOut();
    // Social Media Logouts
    GoogleLoginManager().googleLogout();
    FacebookLoginManager().facebookLogout();
    // AuthManager Logout
    user = null;
    userCredential = null;
  }
}
