import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';
 import 'package:shop_ecommerce/constants.dart';
import 'package:shop_ecommerce/custom_scroll_behavior.dart';
import 'package:shop_ecommerce/models/tickets.dart';
import 'package:shop_ecommerce/models/under_maintainance_model.dart';
import 'package:shop_ecommerce/provider/go_to_page.dart';
import 'package:shop_ecommerce/provider/has_won.dart';
import 'package:shop_ecommerce/provider/internet_check_provider.dart';
import 'package:shop_ecommerce/provider/minimum_product_details.dart';
import 'package:shop_ecommerce/provider/product_provider.dart';
import 'package:shop_ecommerce/provider/stream_under_maintainance.dart';
import 'package:shop_ecommerce/provider/stream_user_tickets.dart';
import 'package:shop_ecommerce/provider/temp_selected_slots.dart';
import 'package:shop_ecommerce/provider/user_provider.dart';
import 'package:shop_ecommerce/provider/user_temp_selected_slots_provider.dart';
import 'package:shop_ecommerce/routes.dart';
import 'package:shop_ecommerce/screens/splash_screen/splash_screen.dart';
import 'package:shop_ecommerce/theme.dart';
import 'package:device_info_plus/device_info_plus.dart';

const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    description:
        'This channel is used for important notifications.', // description
    importance: Importance.high,
    playSound: true);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> _firebaseMessagingBackgroundHandler(message) async {
  await Firebase.initializeApp();
  print('Handling a background message ${message.messageId}');
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp],
  );
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  MobileAds.instance.initialize();

  Provider.debugCheckInvalidValueType = null;
  final PendingDynamicLinkData? initialLink =
      await FirebaseDynamicLinks.instance.getInitialLink();
  runApp(
    MultiProvider(
      providers: [
        //   if (FirebaseAuth.instance.currentUser != null)
        StreamProvider<Tickets?>.value(
            value: Database().tickets, initialData: Tickets(ticketCount: 0)),
        StreamProvider<UnderMaintainanceModel?>.value(
            value: UnderMaintainanceDB().underMaintainance,
            initialData: UnderMaintainanceModel(isUnderMaintainance: false)),
        StreamProvider<NetworkStatus>(
          create: (context) =>
              NetworkStatusService().networkStatusController.stream,
          initialData: NetworkStatus.Offline,
        ),

        Provider<MinimumProductProvider>(
            create: (_) => MinimumProductProvider()),
        Provider<Userprovider>(create: (_) => Userprovider()),
        Provider<ProductProvider>(create: (_) => ProductProvider()),
        Provider<TempReservedSlots>(create: (_) => TempReservedSlots()),
        Provider<HasWon>(create: (_) => HasWon()),
        Provider<GoToPageProvider>(create: (_) => GoToPageProvider()),
        Provider<UserTempSelectedSlotsProvider>(
            create: (_) => UserTempSelectedSlotsProvider()),
      ],
      child: MyApp(
        initialLink: initialLink,
      ),
    ),
  );
}

class MyApp extends StatefulWidget {
  MyApp({
    Key? key,
    required this.initialLink,
  }) : super(key: key);
  final PendingDynamicLinkData? initialLink;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int? androidSdkVersion;
  String? path;

  @override
  void initState() {
    super.initState();
    if (widget.initialLink != null) {
      path = widget.initialLink!.link.pathSegments.last;
      if(path!=null)
      context.read<GoToPageProvider>().addPath(path!);
    }
    getSDKInfo() async {
      final deviceInfo = await DeviceInfoPlugin().deviceInfo;
      final androidSdkVersion1 =
          deviceInfo is AndroidDeviceInfo ? deviceInfo.version.sdkInt : 0;
      setState(() {
        androidSdkVersion = androidSdkVersion1;
      });
    }

    getSDKInfo();
    const AndroidInitializationSettings('@mipmap/ic_stat_foreground_logo');

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(channel.id, channel.name,
                  channelDescription: channel.description,
                  playSound: true,
                  icon: '@mipmap/ic_stat_foreground_logo',
                  priority: Priority.high,
                  importance: Importance.high),
            ));
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        showDialog(
            context: context,
            builder: (_) {
              return AlertDialog(
                title: Text(notification.title!),
                content: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [Text(notification.body!)],
                  ),
                ),
              );
            });
      }
    });
  }

  // Platform messages are asynchronous, so we initialize in an async method.

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    EasyLoading.instance
      ..displayDuration = defaultDuration2sec
      ..indicatorType = EasyLoadingIndicatorType.threeBounce
      ..loadingStyle = EasyLoadingStyle.custom
      ..indicatorSize = 40.0
      ..radius = 12.0
      ..progressColor = MediumPinkPurple
      ..backgroundColor = aWhite
      // ..boxShadow = <BoxShadow>[]
      ..indicatorColor = MediumPinkPurple
      ..textColor = DarkGray
      ..textStyle = text13DarkFw500
      ..maskColor = Transparent
      ..userInteractions = true
      ..maskType = EasyLoadingMaskType.custom;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        systemNavigationBarColor: Color(0xFF000000),
        systemNavigationBarIconBrightness: Brightness.dark,
        systemNavigationBarDividerColor: null,
        statusBarColor: backgroundColor,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.dark,
      ),
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (context, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: theme(),
            scrollBehavior: CustomScrollBehavior(
              androidSdkVersion: androidSdkVersion ?? 0,
            ),
            builder: EasyLoading.init(),
            initialRoute: MainSplashScreen.routeName,
            routes: routes,
          );
        },
      ),
    );
  }
}
