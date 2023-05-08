//* Package imports
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

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
      // Trigger the authentication flow (abre sdk login google)
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request (despues de elegir el usuario)
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // Create a new credential (guardar credenciales)
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential (inicio de sesion)
      user = await _auth.signInWithCredential(credential);
      return user;
    } on FirebaseAuthException catch (e) {
      await onFirebaseAuthException(error: e);
      return null;
    }
  }

  //?FACEBOOK
  Future<UserCredential?> signInWithFacebook() async {
    try {
      // Trigger the sign-in flow (abre sdk login facebook)
      final LoginResult loginResult = await FacebookAuth.instance.login(
        loginBehavior: LoginBehavior.webOnly,
      );

      // Create a credential from the access token (guardar credenciales)
      final OAuthCredential facebookAuthCredential =
          FacebookAuthProvider.credential(loginResult.accessToken!.token);

      // Once signed in, return the UserCredential (inicio de sesion)
      user = await _auth.signInWithCredential(facebookAuthCredential);
      return user;
    } on FirebaseAuthException catch (e) {
      await onFirebaseAuthException(error: e);
      return null;
    }
  }

  //TODO: APPLE
  Future<UserCredential?> signInWithApple() async {
    // final appleProvider = AppleAuthProvider();
    // if (kIsWeb) {
    //   user = await _auth.signInWithPopup(appleProvider);
    // } else {
    //   user = await _auth.signInWithProvider(appleProvider);
    // }
    return user;
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
    await FacebookAuth.instance.logOut();
    await GoogleSignIn().signOut();
    await _auth.signOut();
    //
    user = null;
    userCredential = null;
  }

  String getUserData() {
    return user!.user!.email ?? (user!.user!.displayName ?? "No hay datos");
  }
}
