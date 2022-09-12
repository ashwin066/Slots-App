import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
 import 'package:get/get.dart';
import 'package:shop_ecommerce/routes.dart';
import 'package:shop_ecommerce/screens/sign_in/sign_in_screen.dart';

import 'package:shop_ecommerce/screens/splash_screen/splash_screen.dart';
 import 'package:shop_ecommerce/service/controllers/product_controller.dart';
import 'package:shop_ecommerce/theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
 
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          theme: theme(),
          home: SignInScreen(),
          initialRoute: MainSplashScreen.routeName,
          routes: routes,
        );
      },
    );
  }
}
