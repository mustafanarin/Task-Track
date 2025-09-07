import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final notificationServiceProvider = Provider<NotificationService>((ref) {
  return NotificationService();
});

class NotificationService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _localNotifications = FlutterLocalNotificationsPlugin();

  Future<void> initialize() async {
    try {
      await Firebase.initializeApp();

      NotificationSettings settings = await _firebaseMessaging.requestPermission(
        alert: true,
        badge: true,
        sound: true,
      );

      if (settings.authorizationStatus == AuthorizationStatus.authorized) {
        await _setupLocalNotifications();

        // Default topic
        await _firebaseMessaging.subscribeToTopic('all');

        FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
        FirebaseMessaging.onMessage.listen(_handleForegroundMessage);
        FirebaseMessaging.onMessageOpenedApp.listen(_handleMessageOpenedApp);
      }
    } catch (e) {
      if (kDebugMode) {
        print('Notification initialization error: $e');
      }
    }
  }

  Future<void> _setupLocalNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    final InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
    );

    await _localNotifications.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse details) {
        if (kDebugMode) {
          print('Notification clicked: ${details.payload}');
        }
      },
    );
    await _createNotificationChannel();
  }

  Future<void> _createNotificationChannel() async {
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'notification_channel',
      'Notifications Channel',
      description: 'This channel is used for important notifications.',
      importance: Importance.high,
      playSound: true,
    );

    await _localNotifications
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
  }

  Future<void> showNotification(String title, String body) async {
    try {
      const AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'notification_channel',
        'Notifications Channel',
        channelDescription: 'This channel is used for important notifications.',
        importance: Importance.high,
        priority: Priority.high,
        icon: '@mipmap/ic_launcher',
      );

      const NotificationDetails platformChannelSpecifics =
          NotificationDetails(android: androidPlatformChannelSpecifics);

      await _localNotifications.show(
        0,
        title,
        body,
        platformChannelSpecifics,
      );
    } catch (e) {
      if (kDebugMode) {
        print('Show notification error: $e');
      }
    }
  }

  void _handleForegroundMessage(RemoteMessage message) {
    showNotification(
      message.notification?.title ?? 'New Notification',
      message.notification?.body ?? '',
    );
  }

  void _handleMessageOpenedApp(RemoteMessage message) {
    if (kDebugMode) {
      print('Message opened app: ${message.messageId}');
    }
  }

  Future<void> subscribeToTopic(String topic) async {
    await _firebaseMessaging.subscribeToTopic(topic);
  }

  Future<void> unsubscribeFromTopic(String topic) async {
    await _firebaseMessaging.unsubscribeFromTopic(topic);
  }
}

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  if (kDebugMode) {
    print("Handling a background message: ${message.messageId}");
  }
}
