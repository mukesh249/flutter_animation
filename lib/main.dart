import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animation/common/size_config.dart';
import 'package:flutter_animation/first_demo.dart';
import 'package:flutter_animation/ui/animate_list/animate_list.dart';
import 'package:flutter_animation/ui/bottom_navigation/bottom_nav_a.dart';
import 'package:flutter_animation/ui/custom_paints/demo_custom_shape.dart';
import 'package:flutter_animation/ui/furniture/pages/furniture_home.dart';
import 'package:flutter_animation/ui/logitech/page/logitech_home_page.dart';
import 'package:flutter_animation/ui/sofa_set/page/sofa_set_page.dart';
import 'package:flutter_animation/ui/weather/weather_page.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'firebase_options.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_animation/first_demo_controller.dart';
// FCM
const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel',
  'High Importance Channel',
  description: 'This channel is used for important notifications',
  importance: Importance.high,
  playSound: true,
);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // you can do any stuffs that should work when notification comes in background

  // Be aware that this task should not take too much time, unless it would be skipped in OS
  SharedPreferences prefs = await SharedPreferences.getInstance();
  int? count = prefs.getInt('notif-count');
  await prefs.setInt('notif-count', (count ?? 0) + 1);
}


// It is assumed that all messages contain a data field with the key 'type'
Future<void> setupInteractedMessage() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  final token = await FirebaseMessaging.instance.getToken();
  // if token is not saved save it. You can save it to your server, and use it to send notifications to specific user
  if (sharedPreferences.getString('firebaseToken') != token) {
    sharedPreferences.setString('firebaseToken', token ?? '');
  }

  /// need to check if user give access to notifications
  /// if not ask for it
  final settings = await FirebaseMessaging.instance.requestPermission();
  if (settings.authorizationStatus != AuthorizationStatus.authorized) {
    // if not granted, ask it again
    await FirebaseMessaging.instance.requestPermission();
  }
  if (settings.authorizationStatus != AuthorizationStatus.authorized) {
    // still didnot give access? just skip other parts. This user will not get notification anyway
    return;
  }

  // Get any messages which caused the application to open from
  // a terminated state.
  RemoteMessage? initialMessage =
  await FirebaseMessaging.instance.getInitialMessage();

  // If the message also contains a data property with a "type" of "chat",
  // navigate to a chat screen
  if (initialMessage != null) {
    _handleMessage(initialMessage, true);
  }

  // Also handle any interaction when the app is in the background via a
  // Stream listener
  FirebaseMessaging.onMessageOpenedApp.listen(
        (RemoteMessage message) {
      _handleMessage(message, true);
    },
  );

  // currently user is using your app, and suddenly get notification. you will listen it here:
  _listenWhenAppIsInForeground();
}

void _listenWhenAppIsInForeground() {
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    _handleMessage(message, false);
  });
}

void _handleMessage(RemoteMessage message, bool onTapNotif) {
  print("notification_message : ${message.data}\n onTap : $onTapNotif");
  showNotification();
  /*hasUnopenedNotifs = true;
  setState(() {});
  if (onTapNotif) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return NotificationDetailScreen(
        title: message.notification?.title ?? '',
        details: message.notification?.body ?? '',
      );
    })).then((value) {
      hasUnopenedNotifs = false;
      setState(() {});
    });
  }*/
}

var _counter = 0.obs;
void showNotification() {
    _counter.value++;
  flutterLocalNotificationsPlugin.show(
      0,
      "Testing $_counter",
      "How you doin ?",
      const NotificationDetails(
          android: AndroidNotificationDetails(
              "high_importance_channel",
              "High Importance Channel",
              channelDescription: "This channel is used for important notifications",
              importance: Importance.high,
              color: Colors.blue,
              playSound: true,
              icon: '@mipmap/ic_launcher'),
          iOS: DarwinNotificationDetails(
              presentSound: true, presentAlert: true, presentBadge: true)),
      payload: 'Open from Local Notification');

   /* messages.add(
      Message(
        title: "Testing $_counter",
        body: "How you doin ?",
      ),
    );*/
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance; // Change here
  firebaseMessaging.getToken().then((token){
    debugPrint("firebase_token : $token");//etQNAMXlSbOsOp57RSn9d8:APA91bEA746UOR9IDtJWhW-bOxUM2OexZ9jBMlpsSk7bkZgalbjdlaFGkjqbk5zEJewPLK79lPSlIi_11KyRKdPhwYkUvs54GNVcM7n6_MNhaQr-tIi6W3wC1LkVmR4hHJC31prI88hN
  });
  Get.put(FirstDemoController());
  runApp(const MyApp());


  if (Platform.isAndroid || Platform.isIOS) {
    FirebaseMessaging? messaging;
    messaging = FirebaseMessaging.instance;
    await messaging.requestPermission();
    if (Platform.isAndroid) {
      await FirebaseMessaging.instance.setAutoInitEnabled(true);
    }

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
        alert: true, badge: true, sound: true);

    setupInteractedMessage();
  }

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    AppSizes().initSizes(context);
    return GetMaterialApp(
      themeMode: ThemeMode.system,
      darkTheme: ThemeData(
        primaryColor: Colors.purple,
        scaffoldBackgroundColor: Colors.teal,
      ),
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:   DemoCustomShape(),
      //home:   FurnitureHome(),
      //home:   AnimateList(),
      //home:  BottomNavA(),
      //home:  FirstDemo(),
      //home: const WeatherPage(),
      //home:  LogitechHomePage(),
      //home:  SofaPage(),
    );
  }
}
