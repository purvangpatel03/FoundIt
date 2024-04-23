import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseMessage {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  requestPermission() async {
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );


    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
    } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
      print('User granted provisional permission');
    } else {
      print('User declined or has not accepted permission');
    }
  }

  sendMessage() async {
    final fcmToken = await FirebaseMessaging.instance.getToken();
    print('FCM Token: $fcmToken');
  }


}
