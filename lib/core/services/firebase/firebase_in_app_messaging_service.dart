// // ignore_for_file: unnecessary_null_comparison

// import 'package:firebase_in_app_messaging/firebase_in_app_messaging.dart';
// import 'package:mymystore/core/commons/common_methods.dart';

// class FirebaseInAppMessagingService {
//   static FirebaseInAppMessaging fiam = FirebaseInAppMessaging.instance;

//   static init() async {}

//   static triggerEvent(String event) async {
//     if (CommonMethods.isMobile()) {
//       FirebaseInAppMessagingService.fiam.triggerEvent(event);
//     }
//   }

//   static void disable() {
//     if (CommonMethods.isMobile()) {
//       fiam.setMessagesSuppressed(true);
//     }
//   }

//   static void reEnable() {
//     if (CommonMethods.isMobile()) {
//       fiam.setMessagesSuppressed(false);
//     }
//   }
// }
