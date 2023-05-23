// //* Flutter imports
// import 'package:flutter/material.dart';

// //* Project imports
// import 'package:s_multiloginp/s_multiloginp.dart';

// //* Package imports
// import 'package:linkedin_login/linkedin_login.dart';

// class LinkedinLoginManager {
//   linkedinLogin(LinkedinLoginModel? lkLoginData, BuildContext context) async {
//     if (lkLoginData != null) {
//       Navigator.push(
//         context,
//         MaterialPageRoute<void>(
//           builder: (final BuildContext context) => LinkedInUserWidget(
//             redirectUrl: lkLoginData.redirectUrl,
//             clientId: lkLoginData.clientId,
//             clientSecret: lkLoginData.clientSecret,
//             onError: (final UserFailedAction e) {
//               debugPrint('Error: ${e.toString()}');
//               debugPrint('Error: ${e.stackTrace.toString()}');
//               onerrorlinkedin
//             },
//             onGetUserProfile: (final UserSucceededAction linkedInUser) {
//               debugPrint(
//                 'Access token ${linkedInUser.user.token.accessToken}',
//               );

//               debugPrint('User id: ${linkedInUser.user.userId}');

//               user = UserObject(
//                 firstName: linkedInUser?.user?.firstName?.localized?.label,
//                 lastName: linkedInUser?.user?.lastName?.localized?.label,
//                 email: linkedInUser
//                     ?.user?.email?.elements[0]?.handleDeep?.emailAddress,
//                 profileImageUrl: linkedInUser
//                     ?.user
//                     ?.profilePicture
//                     ?.displayImageContent
//                     ?.elements[0]
//                     ?.identifiers[0]
//                     ?.identifier,
//               );
//               // Navigator.pop(context);
//               onresultlinkedin
//             },
//           ),
//           fullscreenDialog: true,
//         ),
//       );
//     } else {
//       return throw Exception(
//           "No es posible iniciar sesión con LinkedIn si primero no se define \"linkedinInitData\" en \"SMultiLogin().multiLoginInit()\"");
//     }
//   }

//   // linkedinLogout() async {}
// }
