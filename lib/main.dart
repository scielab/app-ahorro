import 'package:app/language/l10n.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:app/routes/routes.dart';
import 'package:app/api/firebase_api.dart';
import 'package:app/helpers/dependences.dart';
import 'package:app/utils/color_custom.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';


final navigatorKey = GlobalKey<NavigatorState>();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  await Firebase.initializeApp();
  await FirebaseApiNotification().initNotification();

  final sharedPreferences = await SharedPreferences.getInstance();
  Get.put<SharedPreferences>(sharedPreferences);
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'App Ahorro',
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      theme: ThemeData(
        fontFamily: 'Montserrat',
        appBarTheme: AppBarTheme(color: AppColors.primaryContentColor),
        colorScheme: ColorScheme.fromSeed(
          background: AppColors.primaryContentColor,
          seedColor: const Color.fromARGB(255, 255, 255, 255)),
        useMaterial3: true,
      ),
      initialBinding: BindingInit(),
      getPages: RouterHelper.routes,
      initialRoute: RouterHelper.getSignin(),
      
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: L10n.all,
    );
  }
}
