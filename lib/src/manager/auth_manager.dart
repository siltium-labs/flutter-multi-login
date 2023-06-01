//* Package imports
import 'package:firebase_auth/firebase_auth.dart';

//* Project imports
import 'package:s_multiloginp/src/manager/google_login_manager.dart';
import 'package:s_multiloginp/src/manager/facebook_login_manager.dart';
import 'package:s_multiloginp/src/manager/apple_login_manager.dart';
import 'package:s_multiloginp/src/manager/twitter_login_manager.dart';
import 'package:s_multiloginp/src/manager/microsoft_login_manager.dart';
import 'package:s_multiloginp/src/models/current_user_model.dart';
import 'package:s_multiloginp/src/models/linkedin_init_login_model.dart';
import 'package:s_multiloginp/src/models/twitter_init_login_model.dart';

class AuthManager {
  static final AuthManager _instance = AuthManager._constructor();
  factory AuthManager() {
    return _instance;
  }
  AuthManager._constructor();

  // Variables:
  final FirebaseAuth _auth = FirebaseAuth.instance;
  UserCredential? user;
  CurrentUserModel? userCredential;
  // Variables Social Media Inits:
  String? googleIOSClientId;
  TwitterInitLoginModel? twitterLoginData;
  LinkedinInitLoginModel? linkedinLoginData;

  // Social Media Inits:
  googleLoginInit(String? iOSClientId) {
    googleIOSClientId = iOSClientId;
  }

  twitterLoginInit({TwitterInitLoginModel? newTwLoginData}) {
    twitterLoginData = newTwLoginData;
  }

  linkedinLoginInit({LinkedinInitLoginModel? newLkLoginData}) {
    linkedinLoginData = newLkLoginData;
  }

  // Login Methods:
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
  Future<UserCredential?> signInWithTwitter() async {
    try {
      OAuthCredential twitterOAuthCredential =
          await TwitterLoginManager().twitterLogin(twitterLoginData);
      return user = await _auth.signInWithCredential(twitterOAuthCredential);
    } on FirebaseAuthException catch (e) {
      await onFirebaseAuthException(error: e);
      return null;
    }
  }

  //* MICROSOFT
  Future<UserCredential?> signInWithMicrosoft() async {
    try {
      MicrosoftAuthProvider microsoftProvider =
          await MicrosoftLoginManager().microsoftLogin();
      return user = await _auth.signInWithProvider(microsoftProvider);
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
    if (user != null && user!.user != null) {
      return userCredential = CurrentUserModel(
        displayName: user!.user!.displayName,
        email: user!.user!.email,
        phoneNumber: user!.user!.phoneNumber,
        photoURL: user!.user!.photoURL,
        token: await user!.user!.getIdToken(),
        refreshToken: user!.user!.refreshToken,
      );
    } else if (currentUser != null) {
      return userCredential = CurrentUserModel(
        displayName: currentUser.displayName,
        email: currentUser.email,
        phoneNumber: currentUser.phoneNumber,
        photoURL: currentUser.photoURL,
        token: currentUser.token,
        refreshToken: currentUser.refreshToken,
      );
    } else {
      throw Exception("Error in fetching user data: The user was not given");
    }
  }

  CurrentUserModel? getUserData() {
    if (userCredential != null) {
      return userCredential!;
    } else {
      return null;
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
