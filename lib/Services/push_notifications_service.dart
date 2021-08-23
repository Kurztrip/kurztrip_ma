import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_core/firebase_core.dart';

class PushNotificationsService {
  static FirebaseMessaging messaging = FirebaseMessaging.instance;
  static String? token;
  static StreamController<String> _messageStreamController = new StreamController.broadcast();

  static String notification_title = '';
  static String notification_body = '';

  static Future _backgroundHandler(RemoteMessage message) async {
    print('onBackground Handler ${message.messageId}');
    notification_title = message.notification?.title ?? 'Sin Titulo';
    notification_body = message.notification?.body ?? 'Sin Cuerpo';
    print(notification_title);
    print(notification_body);
  }

  static Future _onMessageHandler(RemoteMessage message) async {
    print('onMessageHandler Handler ${message.messageId}');
    notification_title = message.notification?.title ?? 'Sin Titulo';
    notification_body = message.notification?.body ?? 'Sin Cuerpo';
    print(notification_title);
    print(notification_body);
  }

  static Future _onMessageOpenApp(RemoteMessage message) async {
    print('onMessageOpenApp Handler ${message.messageId}');
    notification_title = message.notification?.title ?? 'Sin Titulo';
    notification_body = message.notification?.body ?? 'Sin Cuerpo';
    print(notification_title);
    print(notification_body);
  }

  static Future initializeApp() async {
    //PUSH NOTIFICATIONS
    await Firebase.initializeApp();
    token = await FirebaseMessaging.instance.getToken();

    print('token: $token');

    //Handlers

    FirebaseMessaging.onBackgroundMessage(_backgroundHandler);
    FirebaseMessaging.onMessage.listen(_onMessageHandler);
    FirebaseMessaging.onMessageOpenedApp.listen(_onMessageOpenApp);

    //LOCAL NOTIFICATIONS
  }

  static closeStreams() {
    _messageStreamController.close();
  }
}
