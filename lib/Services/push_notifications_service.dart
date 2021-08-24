import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kurztrip_ma/services_provider.dart';

class PushNotificationsService {
  static FirebaseMessaging messaging = FirebaseMessaging.instance;

  static StreamController<String> _messageStreamController = new StreamController.broadcast();

  static String notification_title = '';
  static String notification_body = '';
  static String message_to_show_on_toast = '';

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
    message_to_show_on_toast = notification_title + ": " + notification_body;

    Fluttertoast.showToast(msg: message_to_show_on_toast, toastLength: Toast.LENGTH_LONG, gravity: ToastGravity.BOTTOM);
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
    device_id = await FirebaseMessaging.instance.getToken() ?? "error at setting device ID";

    print('token: $device_id');

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
