// //* Package imports
// import 'package:firebase_auth/firebase_auth.dart';

// class TwitterLoginManager {
//   twitterLogin() async {
//     if (twLoginData != null) {
//       // Create a TwitterLogin instance
//       final twitterLogin = TwitterLogin(
//         apiKey: twLoginData.apiKey,
//         apiSecretKey: twLoginData.apiSecretKey,
//         redirectURI: twLoginData.redirectURI,
//       );

//       // Trigger the sign-in flow
//       final authResult = await twitterLogin.loginV2();

//       // Create a credential from the access token
//       final twitterOAuthCredential = TwitterAuthProvider.credential(
//         accessToken: authResult.authToken!,
//         secret: authResult.authTokenSecret!,
//       );

//       // Once signed in, return the UserCredential (inicio de sesion, en AuthManager)
//       return twitterOAuthCredential;
//     } else {
//       return throw Exception("No es posible iniciar sesión con Twitter si primero no se define \"twitterInitData\" en \"SMultiLogin().multiLoginInit()\"");
//     }
//   }

//   // twitterLogout() async {}
// }
