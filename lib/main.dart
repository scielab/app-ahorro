import 'package:app/api/firebase_api.dart';
import 'package:app/controllers/auth/auth_controller.dart';
import 'package:app/helpers/dependences.dart';
import 'package:app/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';


final navigatorKey = GlobalKey<NavigatorState>();


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseApiNotification().initNotification();
  // Agregando una base de datos local DB
  //final database = openDatabase(join(await getDatabasesPath(), 'question.db'));
  
  runApp(const MyApp());
  await init();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Get.put<AuthController>(AuthController());

    return GetMaterialApp(
      title: 'App Ahorro',
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      theme: ThemeData(
        appBarTheme: AppBarTheme(color: Colors.grey[100]),
        colorScheme: ColorScheme.fromSeed(
          background: Colors.grey[100],
                    
          seedColor: const Color.fromARGB(255, 255, 255, 255)),
        useMaterial3: true,
      ),
      getPages: RouterHelper.routes,
      initialRoute: RouterHelper.getSignin(),
    );
  }
}

