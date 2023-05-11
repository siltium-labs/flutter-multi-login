//* Dart imports
// import 'dart:convert';
// import 'dart:math';

//* Package imports
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
// import 'package:google_sign_in/google_sign_in.dart';
import 'package:s_multiloginp/src/manager/apple_login_manager.dart';
import 'package:s_multiloginp/src/manager/facebook_login_manager.dart';
import 'package:s_multiloginp/src/manager/google_login_manager.dart';
// import 'package:sign_in_with_apple/sign_in_with_apple.dart';
// import 'package:crypto/crypto.dart';

//* Project imports
import 'package:s_multiloginp/src/models/current_user_model.dart';

class AuthManager {
  static final AuthManager _instance = AuthManager._constructor();
  factory AuthManager() {
    return _instance;
  }
  AuthManager._constructor();

  //Variables
  final FirebaseAuth _auth = FirebaseAuth.instance;
  UserCredential? user;
  CurrentUserModel? userCredential;

  //*EMAIL
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

  //!GOOGLE
  Future<UserCredential?> signInWithGoogle() async {
    try {
      // // Trigger the authentication flow (abre sdk login google)
      // final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // // Obtain the auth details from the request (despues de elegir el usuario)
      // final GoogleSignInAuthentication? googleAuth =
      //     await googleUser?.authentication;

      // // Create a new credential (guardar credenciales)
      // final googleOAuthCredential = GoogleAuthProvider.credential(
      //   accessToken: googleAuth?.accessToken,
      //   idToken: googleAuth?.idToken,
      // );

      // Once signed in, return the UserCredential (inicio de sesion)
      OAuthCredential googleOAuthCredential =
          await GoogleLoginManager().googleLogin();
      return user = await _auth.signInWithCredential(googleOAuthCredential);
      // return user;
    } on FirebaseAuthException catch (e) {
      await onFirebaseAuthException(error: e);
      return null;
    }
  }

  //?FACEBOOK
  Future<UserCredential?> signInWithFacebook() async {
    try {
      // // Trigger the sign-in flow (abre sdk login facebook)
      // final LoginResult loginResult = await FacebookAuth.instance.login(
      //   loginBehavior: LoginBehavior.webOnly,
      // );

      // // Create a credential from the access token (guardar credenciales)
      // final OAuthCredential facebookOAuthCredential =
      //     FacebookAuthProvider.credential(loginResult.accessToken!.token);

      // Once signed in, return the UserCredential (inicio de sesion)
      OAuthCredential facebookOAuthCredential =
          await FacebookLoginManager().facebookLogin();
      return user = await _auth.signInWithCredential(facebookOAuthCredential);
      // return user;
    } on FirebaseAuthException catch (e) {
      await onFirebaseAuthException(error: e);
      return null;
    }
  }

  //TODO: APPLE (para ios)
  // Metodos necesarios para el Apple SingIn
  // String generateNonce([int length = 32]) {
  //   const charset =
  //       '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
  //   final random = Random.secure();
  //   return List.generate(length, (_) => charset[random.nextInt(charset.length)])
  //       .join();
  // }

  // String sha256ofString(String input) {
  //   final bytes = utf8.encode(input);
  //   final digest = sha256.convert(bytes);
  //   return digest.toString();
  // }

  // Apple SingIn
  Future<UserCredential?> signInWithApple() async {
    try {
      // // Prevent replay attacks with the credential returned from Apple
      // final rawNonce = generateNonce();
      // final nonce = sha256ofString(rawNonce);

      // // Request credential for the currently signed in Apple account.
      // final appleCredential = await SignInWithApple.getAppleIDCredential(
      //   scopes: [
      //     AppleIDAuthorizationScopes.email,
      //     AppleIDAuthorizationScopes.fullName,
      //   ],
      //   nonce: nonce,
      // );

      // // Create an `OAuthCredential` from the credential returned by Apple.
      // final appleOAuthCredential = OAuthProvider("apple.com").credential(
      //   idToken: appleCredential.identityToken,
      //   rawNonce: rawNonce,
      // );
      OAuthCredential appleOAuthCredential =
          await AppleLoginManager().appleLogin();
      return user = await _auth.signInWithCredential(appleOAuthCredential);
      // return user;
    } on FirebaseAuthException catch (e) {
      await onFirebaseAuthException(error: e);
      return null;
    }
  }

  //OTROS
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
    // await GoogleSignIn().signOut();
    // await FacebookAuth.instance.logOut();
    GoogleLoginManager().googleLogout();
    FacebookLoginManager().facebookLogout();
    await _auth.signOut();
    //
    user = null;
    userCredential = null;
  }

  String getUserData() {
    return user!.user!.email ?? (user!.user!.displayName ?? "No hay datos");
  }
}
