import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationServices{
  FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

  void requestNotificationPermission()async {
    NotificationSettings settings = await firebaseMessaging.requestPermission(
      alert: true,
      announcement: true,
      carPlay: true,
      criticalAlert: true,
      badge: true,
      provisional: true,
      sound: true,
    );

    if(settings.authorizationStatus == AuthorizationStatus.authorized){
      print("user granted permission");

    }else if(settings.authorizationStatus == AuthorizationStatus.provisional){
      print("user granted provisional permission");
    }else {
      print("user denied permission");

    }
  }
}