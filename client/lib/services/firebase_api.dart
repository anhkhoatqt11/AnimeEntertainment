// ignore_for_file: avoid_print

import 'package:anime_and_comic_entertainment/components/notifications/OverlayNotification.dart';
import 'package:anime_and_comic_entertainment/components/ui/AlertDialog.dart';
import 'package:anime_and_comic_entertainment/services/user_api.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class FirebaseApi {
  final _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initNotification() async {
    await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    final fcmToken = await _firebaseMessaging.getToken();
    print('Token: $fcmToken');
    await FirebaseMessaging.instance.setAutoInitEnabled(true);
  }

  @pragma('vm:entry-point')
  Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    await Firebase.initializeApp();
    print("Handling a background message: ${message.messageId}");
  }

  Future<void> setupInteractedMessage() async {
    // Get any messages which caused the application to open from
    // a terminated state.
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) {
      _handleMessage(initialMessage);
    }
    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
  }

  void _handleMessage(RemoteMessage message) {
    print(message.notification?.title);
  }

  void storeDeviceToken(BuildContext context) {
    _firebaseMessaging.getToken().then((token) {
      print('Token: $token');
      UsersApi.storeDeviceToken(context, token);
    });
  }

  void listenEvent(BuildContext context) {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      // showDialog(
      //     context: context,
      //     builder: (_) => CustomAlertDialog(
      //         content: message.notification?.title ?? "",
      //         title: 'Thông báo',
      //         action: () {}));
      // Navigator.of(context)
      //     .overlay!
      //     .insert(OverlayEntry(builder: (BuildContext context) {
      //   return OverlayNotification(
      //       content: message.notification?.title ?? "", type: 1);
      // }));
      Navigator.of(context).push(
        PageRouteBuilder(
          opaque: false,
          pageBuilder: (BuildContext context, _, __) {
            return OverlayNotification(
              content: message.notification?.title ?? "",
              type: 1,
            );
          },
        ),
      );
    });
    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }
}
