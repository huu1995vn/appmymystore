// ignore_for_file: unnecessary_null_comparison, empty_catches

import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:raoxe/core/commons/common_methods.dart';
import 'package:raoxe/core/services/firebase/cloud_firestore.service.dart';

//model
class PushNotification {
  PushNotification(
      {this.title, this.body, this.data, this.isBackgournd = false});

  String? title;
  String? body;
  Map<String, dynamic>? data;
  bool isBackgournd = false;
}

Future _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('Handling a background message ${message.messageId}');
}

class FirebaseMessagingService {
  static StreamController<PushNotification> streamMessage = StreamController<
      PushNotification>.broadcast(); // 2. Instantiate Firebase Messaging
  static String? token;
  static FirebaseMessaging? _messaging;
  // For handling notification when the app is in terminated state
  static convertNotification(RemoteMessage initialMessage,
      [bool isBackgournd = false]) {
    return PushNotification(
        title: initialMessage.notification?.title,
        body: initialMessage.notification?.body,
        data: initialMessage.data,
        isBackgournd: isBackgournd);
  }

  static init() async {
    try {
      token = await FirebaseMessaging.instance.getToken();
      FirebaseMessaging.instance.onTokenRefresh.listen((token) {
        token = token;
      });
      registerNotification();
    } catch (e) {
      CommonMethods.wirtePrint(e);
    }
  }

  static registerNotification() async {
    // GetToken

    _messaging = FirebaseMessaging.instance;
    // 3. On iOS, this helps to take the user permissions
    NotificationSettings settings = await _messaging!.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
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
          streamMessage.add(convertNotification(initialMessage));
        }
      });
      FirebaseMessaging.onMessageOpenedApp
          .listen((RemoteMessage initialMessage) {
        if (initialMessage != null) {
          streamMessage.add(convertNotification(initialMessage, true));
        }
      });
      // For handling notification when the app is in terminated state
      RemoteMessage? initialMessage =
          await FirebaseMessaging.instance.getInitialMessage();

      if (initialMessage != null) {
        streamMessage.add(convertNotification(initialMessage));
      }
    } else {
      if (kDebugMode) {
        print('User declined or has not accepted permission');
      }
    }
  }

  static refeshToken() async {
    try {
      await FirebaseMessaging.instance.deleteToken();
      token = await FirebaseMessaging.instance.getToken();
      CloudFirestoreSerivce.setdevice();
    } catch (e) {
      CommonMethods.wirtePrint(e);
    }
  }

  static subscribeToTopic(String topic) async {
    return await FirebaseMessaging.instance.subscribeToTopic(topic);
  }

  static unsubscribeFromTopic(String topic) async {
    return await FirebaseMessaging.instance.unsubscribeFromTopic(topic);
  }

  static processLinkToPage(pathRedirect, BuildContext context) async {
    // try {
    //   if (pathRedirect != null && pathRedirect != '') {
    //     var _laction = pathRedirect.split("_");
    //     String path = _laction[1].toString();
    //     // if (path.contains("member") && !CommonMethods.isLogin) {
    //     //   // CommonMethods.showMessageInfo("please.loginagain".tr);
    //     //   return;
    //     // }
    //     // if (path != null) {

    //     // }

    //     return;
    //   }
    // } catch (e) {
    //   // CommonMethods.showMessageError("please.loginagain".tr);
    // }
  }
}
