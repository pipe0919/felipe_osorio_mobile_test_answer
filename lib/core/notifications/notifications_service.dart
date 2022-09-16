import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotificationService {
  static FirebaseMessaging messaging = FirebaseMessaging.instance;

  dynamic notiProvider;

  static String? token;
  // ignore: prefer_final_fields
  static StreamController<String> _streamController =
      StreamController.broadcast();

  static Stream<String> get streamController => _streamController.stream;

  static Future _backgroundHandler(RemoteMessage message) async {
    _streamController.add(message.notification?.title ?? "No Title");
  }

  static Future _onMessageHandler(RemoteMessage message) async {
    _streamController.add(message.notification?.title ?? "No Title");
  }

  static Future _onMessageOpenApp(RemoteMessage message) async {
    _streamController.add(message.notification?.title ?? "No Title");
  }

  static Future initializeApp() async {
    await Firebase.initializeApp();
    await requestPermission();
    token = await FirebaseMessaging.instance.getToken();
    print('este es el token de la app:$token.');
    FirebaseMessaging.onBackgroundMessage(_backgroundHandler);
    FirebaseMessaging.onMessage.listen(_onMessageHandler);
    FirebaseMessaging.onMessageOpenedApp.listen(_onMessageOpenApp);
  }

  static requestPermission() async {
    NotificationSettings settings = await messaging.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true);
  }

  static closeStreamsb() {
    _streamController.close();
  }
}
