// ignore_for_file: unnecessary_null_comparison

import 'dart:async';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

//model
class PushNotification {
  PushNotification({
    this.title,
    this.body,
    this.data,
  });

  String? title;
  String? body;
  Map<String, dynamic>? data;
}

Future _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // print("Handling a background message: ${message.messageId}");
}

class FirebaseMessagingService {
  static String? token;
  static FirebaseMessaging? _messaging;

  // For handling notification when the app is in terminated state
  static toNotification(RemoteMessage initialMessage) async {
    return PushNotification(
      title: initialMessage.notification?.title,
      body: initialMessage.notification?.body,
      data: initialMessage.data,
    );
  }

  static Future<StreamController<PushNotification>>
      registerNotification() async {
    // GetToken
    token = await FirebaseMessaging.instance.getToken();
    StreamController<PushNotification> streamMessage = StreamController<
        PushNotification>.broadcast(); // 2. Instantiate Firebase Messaging
    _messaging = FirebaseMessaging.instance;
    // 3. On iOS, this helps to take the user permissions
    NotificationSettings settings = await _messaging!.requestPermission(
      alert: true,
      badge: true,
      provisional: false,
      sound: true,
    );
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      // Add the following line
      FirebaseMessaging.onBackgroundMessage(
          _firebaseMessagingBackgroundHandler);
      // For handling the received notifications
      FirebaseMessaging.onMessage.listen((RemoteMessage initialMessage) {
        if (initialMessage != null) {
          streamMessage.add(toNotification(initialMessage));
        }
      });
      // For handling notification when the app is in terminated state
      RemoteMessage? initialMessage =
          await FirebaseMessaging.instance.getInitialMessage();

      if (initialMessage != null) {
        streamMessage.add(toNotification(initialMessage));
      }
    } else {
      if (kDebugMode) {
        print('User declined or has not accepted permission');
      }
    }

    return streamMessage;
  }

  static processLinkToPage(pathRedirect, BuildContext context) async {
    // try {
    //   if (pathRedirect != null && pathRedirect != '') {
    //     var _laction = pathRedirect.split("_");
    //     String path = _laction[1].toString();
    //     // if (path.contains("member") && !CommonMethods.isLogin) {
    //     //   // CommonMethods.showMessageInfo("please.loginagain".tr());
    //     //   return;
    //     // }
    //     // if (path != null) {

    //     // }

    //     return;
    //   }
    // } catch (e) {
    //   // CommonMethods.showMessageError("please.loginagain".tr());
    // }
  }
}
